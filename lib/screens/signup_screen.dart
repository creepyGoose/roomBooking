import 'package:flutter/material.dart';
import 'package:loja/models/user_model.dart';
import 'package:loja/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Cadastrar "),
          centerTitle: true,
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor, // background
              ),
              child: Icon(Icons.login, color: Colors.white, size: 16.0),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            )
          ],
        ),
        body:
            ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          if (model.isLoading)
            return Center(child: CircularProgressIndicator());
          return Form(
              key: _formKey,
              child: ListView(padding: EdgeInsets.all(16.0), children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  validator: (text) {
                    if (text.isEmpty || text.length <= 3) {
                      return 'Nome Inválido';
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: "Nome Completo"),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _addressController,
                  validator: (text) {
                    if (text.isEmpty || text.length <= 4) {
                      return 'Endereço Inválido';
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: "Logradouro"),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                    controller: _emailController,
                    validator: (text) {
                      if (text.isEmpty ||
                          !RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(text)) {
                        return 'Insira um email válido';
                      }
                      return null;
                    },
                    decoration: InputDecoration(hintText: "E-mail"),
                    keyboardType: TextInputType.emailAddress),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _passController,
                  validator: (text) {
                    if (text.isEmpty || text.length <= 7) {
                      return "Senha inválida";
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: "Senha"),
                  obscureText: true,
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                    height: 44.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor, // background
                        onPrimary: Colors.white, // foreground
                      ),
                      child: Text(
                        "Registrar",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Map<String, dynamic> userData = {
                            "name": _nameController.text,
                            "email": _emailController.text,
                            "address": _addressController.text,
                          };

                          model.signUp(
                              userData: userData,
                              pass: _passController.text,
                              onSuccess: _onSuccess,
                              onFail: _onFail);
                        }
                      },
                    ))
              ]));
        }));
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
          content: Text("Verifique seu e-mail"),
          backgroundColor: Theme.of(context).primaryColor,
          duration: Duration(seconds: 4)),
    );
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
          content: Text("Falha ao Criar Usuário"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2)),
    );
  }
}
