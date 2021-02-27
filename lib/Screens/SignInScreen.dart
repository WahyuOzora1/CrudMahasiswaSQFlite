import 'package:crudmahasiswasqflite/Screens/HomeScreen.dart';
import 'package:crudmahasiswasqflite/Screens/SignUpScreen.dart';
import 'package:crudmahasiswasqflite/db/constant.dart';
import 'package:crudmahasiswasqflite/db/db_helper.dart';
import 'package:crudmahasiswasqflite/models/user.dart';
import 'package:flutter/material.dart';
import 'package:crudmahasiswasqflite/main.dart';
import 'package:sqflite/sqflite.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  login(String inputEmail, String inputPass) async {
    /// Query get data from table user
    Database dbClient = await dbHelper.db;
    var tempList = await dbClient.query(tabelUser);

    /// Mapping data ke dalam list user
    List<User> listUser = [];
    tempList.forEach((aa) {
      listUser.add(User.fromMap(aa));
    });

    // Validasi apakah username dan password ada
    listUser = listUser
        .where((element) =>
            element.email == inputEmail && element.password == inputPass)
        .toList();
    if ((listUser?.length ?? 0) > 0) {
      // suscces login
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/HomeScreen', (route) => false);
    } else {
      // gagal login
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Email Atau Password Salah"),
              ));
    }
  }

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  void initState() {
    //inisialisasi pertama kali buka aplikasi
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _ctx = context;
    return Scaffold(
      // key: scaffoldKey,
      body: Form(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Center(
              child: Image.asset(
                'assets/logo.png',
                height: 200,
                width: 200,
              ),
            ),
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Universitas Muria Kudus',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                // onSaved: (val) => _username = val,
                controller: username,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                // onSaved: (val) => _password = val,
                obscureText: true,
                controller: password,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: MaterialButton(
                  textColor: Colors.white,
                  color: Colors.yellowAccent[700],
                  child: Text('Login'),
                  onPressed: () {
                    // print(nameController.text);
                    // print(passwordController.text);
                    login(username.text, password.text);
                  },
                )),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
              child: Center(
                child: RichText(
                  text: TextSpan(
                      text: 'Don\'t have an account?',
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: ' SIGN UP',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        )
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
