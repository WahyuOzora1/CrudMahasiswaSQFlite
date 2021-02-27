import 'package:crudmahasiswasqflite/Screens/HomeScreen.dart';
import 'package:crudmahasiswasqflite/Screens/SignInScreen.dart';
import 'package:crudmahasiswasqflite/db/db_helper.dart';
import 'package:crudmahasiswasqflite/models/user.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  final User user;
  SignUpScreen({this.user});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  DbHelper db = DbHelper();

  TextEditingController username;
  TextEditingController email;
  TextEditingController password;
  final _formKey = GlobalKey<FormState>();

  void checkForm() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      await db.saveUser(User(
        username: username.text,
        email: email.text,
        password: password.text,
      ));

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignInScreen()));
    }
  }

  @override
  void initState() {
    username = TextEditingController(
        text: widget.user == null
            ? ''
            : widget.user.username ??
                ''); //kalau dikirim diisi dengan nama yang ada
    email = TextEditingController(
        text: widget.user == null ? '' : widget.user.email);
    password = TextEditingController(
        text: widget.user == null ? '' : widget.user.password);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Image.asset(
                      'assets/logo.png',
                      height: 180,
                      width: 180,
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
                        'Sign Up',
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: username,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'password tidak boleh kosong';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: email,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'email tidak boleh kosong';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      obscureText: true,
                      controller: password,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'password tidak boleh kosong';
                        }
                        return null;
                      },
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
                        child: Text('Sign Up'),
                        onPressed: () {
                          checkForm();
                          //signUp();
                        },
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()));
                    },
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                            text: 'I have an account?',
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: ' Sign In',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
