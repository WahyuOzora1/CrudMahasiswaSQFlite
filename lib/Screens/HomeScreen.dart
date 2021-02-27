import 'package:carousel_pro/carousel_pro.dart';
import 'package:crudmahasiswasqflite/db/db_helper.dart';
import 'package:crudmahasiswasqflite/models/mahasiswa.dart';
import 'package:flutter/material.dart';
import 'FormMahasiswaScreen.dart';
import 'DetailMahasiswa.dart';
import 'package:sqflite/sqflite.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //menampung data mahasiswa
  List<Mahasiswa> listmahasiswa = List();
  DbHelper db = DbHelper();

  void initState() {
    //inisialisasi pertama kali buka apliksai
    _getAllMahasiwa();
    super.initState();
  }

  List listCarousel = [
    'assets/depan.png',
    'assets/aud.jpeg',
    'assets/j.png',
    'assets/masjid.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _getAllMahasiwa();
      },
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                // onPageChanged: callbackFunction,
                scrollDirection: Axis.horizontal,
              ),
              items: listCarousel.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      child: Image.asset(i, fit: BoxFit.cover, width: 1000),
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 2.0),
                      decoration: BoxDecoration(color: Colors.grey),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(
              width: double.maxFinite,
              child: Container(
                padding: EdgeInsets.all(12),
                color: Colors.grey[200],
                child: Text(
                  "DAFTAR MAHASISWA UNIVERSITAS MURIA KUDUS",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: listmahasiswa.length,
                itemBuilder: (context, index) {
                  //inisialiasi terlebih dahulu agar bisa diambil data untuk diambil
                  Mahasiswa mahasiswa = listmahasiswa[index];
                  return ListTile(
                    onTap: () {
                      //edit
                      _openFormEdit(mahasiswa);
                    },
                    contentPadding: EdgeInsets.all(5),
                    title: Text(
                      "${mahasiswa.namaDepan} ${mahasiswa.namaBelakang}"
                          .toLowerCase(),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Freshty Milk",
                          fontStyle: FontStyle.italic,
                          color: Colors.black),
                    ),
                    subtitle: Text("${mahasiswa.prodi}"),
                    trailing: IconButton(
                      color: Colors.red,
                      splashColor: Colors.grey[700],
                      icon: Icon(Icons.delete_outline),
                      onPressed: () {
                        //delete
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Informasi"),
                                content: Container(
                                  height: 60.0,
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                          "Apakah anda yakin ingin menghapus data ${mahasiswa.namaDepan}"),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  MaterialButton(
                                      onPressed: () {
                                        //delete
                                        _deleteMahasiswa(mahasiswa, index);
                                        Navigator.pop(context);
                                      },
                                      child: Text("Yes")),
                                  MaterialButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("No")),
                                ],
                              );
                            });
                      },
                    ),
                    leading: IconButton(
                      onPressed: () {
                        //detail
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailMahasiswa(mahasiswa),
                            ));
                      },
                      icon: Icon(Icons.visibility),
                    ),
                  );
                }),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.grey,
          onPressed: () {
            _openFormCreate();
          },
        ),
      ),
    );
  }

  //Method untuk mengambil list Mahasiwa
  Future<void> _getAllMahasiwa() async {
    var list = await db.getAllMahasiwa();

    setState(() {
      listmahasiswa.clear();
      list.forEach((mahasiswa) {
        //mengambil satu persatu
        listmahasiswa.add(Mahasiswa.fromMap(mahasiswa));
      });
    });
  }

  Future<void> _deleteMahasiswa(Mahasiswa mahasiswa, int position) async {
    //pegawai untuk meghapus di databaswe nya position mengahapus dilistnya
    await db.deleteMahasiwa(mahasiswa);
    setState(() {
      listmahasiswa.removeAt(position);
    });
  }

//Future digunakan, ketika saya edit data mahassiswa terus kita mau edit lagi maknya kita makai future
  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        // result supaya tahu dia jadi nambah atau tidak dan jika nambah harus ngirimi nilai balik
        context,
        MaterialPageRoute(
          builder: (context) => FormMahasiswa(),
        ));

    if (result == 'Simpan') {
      _getAllMahasiwa();
    }
  }

//Future digunakan, ketika saya edit data mahassiswa terus kita mau edit lagi maknya kita makai future
  Future<void> _openFormEdit(Mahasiswa mahasiswa) async {
    var result = await Navigator.push(
        // result supaya tahu dia jadi nambah atau tidak dan jika nambah harus ngirimi nilai balik
        context,
        MaterialPageRoute(
            builder: (context) => FormMahasiswa(mahasiswa: mahasiswa)));

    if (result == 'Update') {
      await _getAllMahasiwa();
    }
  }
}
