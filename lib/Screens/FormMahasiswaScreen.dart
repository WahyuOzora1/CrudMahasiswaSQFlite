import 'package:crudmahasiswasqflite/db/db_helper.dart';
import 'package:crudmahasiswasqflite/models/mahasiswa.dart';
import 'package:crudmahasiswasqflite/models/user.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class FormMahasiswa extends StatefulWidget {
  final Mahasiswa mahasiswa;
  FormMahasiswa({this.mahasiswa});

  @override
  _FormMahasiswaState createState() => _FormMahasiswaState();
}

class _FormMahasiswaState extends State<FormMahasiswa> {
  DbHelper db = DbHelper();

  TextEditingController namaDepan;
  TextEditingController namaBelakang;
  TextEditingController nim;
  TextEditingController prodi;

  @override
  void initState() {
    namaDepan = TextEditingController(
        text: widget.mahasiswa == null
            ? ''
            : widget.mahasiswa.namaDepan ??
                ''); //kalau dikirim diisi dengan nama yang ada
    namaBelakang = TextEditingController(
        text: widget.mahasiswa == null ? '' : widget.mahasiswa.namaBelakang);
    nim = TextEditingController(
        text: widget.mahasiswa == null ? '' : widget.mahasiswa.nim);
    prodi = TextEditingController(
        text: widget.mahasiswa == null ? '' : widget.mahasiswa.prodi);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Mahasiswa"),
        backgroundColor: Colors.grey,
      ),
      body: ListView(
        padding: EdgeInsets.all(18),
        children: <Widget>[
          TextField(
            controller: namaDepan,
            decoration: InputDecoration(
              labelText: "Nama Depan",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: namaBelakang,
            decoration: InputDecoration(
              labelText: "Nama Belakang",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: nim,
            decoration: InputDecoration(
              labelText: "Nomor Induk Mahasiswa",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: prodi,
            decoration: InputDecoration(
              labelText: "Program Studi",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          MaterialButton(
              color: Colors.grey,
              child: (widget.mahasiswa == null)
                  ? Text('Tambah', style: TextStyle(color: Colors.white))
                  : Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () async {
                await upsertMahasiwa(); //method mengupdate atau meninsert
              }),
        ],
      ),
    );
  }

  Future<void> upsertMahasiwa() async {
    if (widget.mahasiswa != null) {
      //update
      await db.updateMahasiswa(Mahasiswa.fromMap({
        'id': widget.mahasiswa.id, //berdasarkan data yang dikirim
        'namaDepan': namaDepan.text, //berdasarkan controllernya
        'namaBelakang': namaBelakang.text,
        'nim': nim.text,
        'prodi': prodi.text,
      }));

      Navigator.pop(
          context, 'update'); //mengindikasikan kalau sudah update data lain
    } else {
      //insert
      await db.saveMahasiswa(Mahasiswa(
          namaDepan: namaDepan.text,
          namaBelakang: namaBelakang.text,
          nim: nim.text,
          prodi: prodi.text));

      Navigator.pop(context, 'Simpan');
    }
  }
}
