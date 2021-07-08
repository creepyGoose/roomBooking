import 'package:flutter/material.dart';
import 'package:loja/screens/signup_screen.dart';
import 'login_screen.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new FooterView(
            footer: new Footer(
              padding: EdgeInsets.only(bottom: 5.0),
              child: Center(
                child: Text(
                  "Feito com ❤️ por Lucas Eid",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              backgroundColor: Colors.transparent,
            ),
            children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 200.0),
              alignment: Alignment.center,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      height: 300.0,
                      child: Image.network("https://i.imgur.com/e3zyzPd.png",
                          fit: BoxFit.cover),
                    ),
                    SizedBox(height: 80.0),
                    ElevatedButton(
                      child: Text("Cadastre-se"),
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.white,
                        primary: Theme.of(context).primaryColor,
                        elevation: 20,
                        minimumSize: Size(250, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextButton(
                        child: Text("Faça login"),
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        })
                  ]))
        ]));
  }
}
