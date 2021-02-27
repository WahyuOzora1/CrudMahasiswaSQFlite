/// Model itu ibaratnya data saat ini yang akan kita apakai
/// db, cadangan data yag akan diambil di model
///
///
///
///
class Mahasiswa {
  int id;
  String namaDepan;
  String namaBelakang;
  String nim;
  String prodi;

  Mahasiswa({this.id, this.namaDepan, this.namaBelakang, this.nim, this.prodi});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      //masukin satu" tiap datanya, kalau id nya tidak null baru masukin ke map
      map['id'] = id;
    }
    map['namaDepan'] = namaDepan;
    map['namaBelakang'] = namaBelakang;
    map['nim'] = nim;
    map['prodi'] = prodi;

    return map;
  }

  Mahasiswa.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.namaDepan = map['namaDepan'];
    this.namaBelakang = map['namaBelakang'];
    this.nim = map['nim'];
    this.prodi = map['prodi'];
  }
}
