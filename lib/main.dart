import 'package:flutter/material.dart';
import 'package:loja/models/user_model.dart';
import 'package:loja/screens/home_screen.dart';
import 'package:loja/screens/welcome_screen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'models/cart_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        return ScopedModel<CartModel>(
          model: CartModel(model),
          child: MaterialApp(
              title: "FullWorking",
              theme: ThemeData(
                  primarySwatch: Colors.orange,
                  primaryColor: Color.fromARGB(255, 239, 81, 27)),
              debugShowCheckedModeBanner: false,
              home: !model.isLoggedIn ? WelcomeScreen() : HomeScreen()),
        );
      }),
    );
  }
}
