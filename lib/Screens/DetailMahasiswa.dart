import 'package:crudmahasiswasqflite/Screens/CustomPainer.dart';
import 'package:crudmahasiswasqflite/db/constant.dart';
import 'package:crudmahasiswasqflite/db/db_helper.dart';
import 'package:crudmahasiswasqflite/models/mahasiswa.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DetailMahasiswa extends StatelessWidget {
  final Mahasiswa mahasiswa;
  DetailMahasiswa(this.mahasiswa);
  getMahasiswas() async {
    Database dbClient = await dbHelper.db;
    var result = await dbClient.query(tabelNama, columns: [
      //result digunakan untuk menyimpan database mahasiswa
      columnId,
      columnNamaDepan,
      columnNamaBelakang,
      columnNim,
      columnProdi,
    ]);
    if (result.length > 0 && result != null) {
      return result.toList();
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Mahasiswa'),
        backgroundColor: Colors.grey,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
              height: height * 0.85,
              width: width * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(colors: [
                    Colors.amber[50],
                    Colors.grey[400],
                  ])),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CustomPaint(
                  size: Size(width, height),
                  painter: CardCustomPainter(),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Center(
                            child: Image.asset(
                              "assets/logo.png",
                              width: width * 0.3,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Universitas Muria Kudus",
                            style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(
                            height: 160,
                          ),
                          Text(
                            "Nama Depan : ${mahasiswa.namaDepan}",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            "Nama Belakang : ${mahasiswa.namaBelakang}",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            "NIM: ${mahasiswa.nim}",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            "Program Studi : ${mahasiswa.prodi}",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // child: Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Column(
              //     children: <Widget>[
              //       Text("Nama Depan : ${mahasiswa.namaDepan}"),
              //       Text("Nama Belakang : ${mahasiswa.namaBelakang}"),
              //       Text("Nomor Induk Mahasiswa : ${mahasiswa.nim}"),
              //       Text("Program Studi : ${mahasiswa.prodi}"),
              //     ],
              //   ),
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
