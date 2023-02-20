import "package:flutter/material.dart";
import 'package:megawallet/components/text_input/input.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextControllers textControllers = TextControllers();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;


    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 80,
          width: 80,
          child: const Image(
            image: AssetImage("assets/logo/login.png"),
            fit: BoxFit.cover,
          ),
        ),
        TextInput(
            controller: textControllers.email,
            hintText: "Enter your email",
            isPasswordType: false,
            labelText: "email",
            prefixIcon: const Icon(Icons.email)),
        TextInput(
            controller: textControllers.password,
            hintText: "Enter your email",
            isPasswordType: false,
            labelText: "email",
            prefixIcon: const Icon(Icons.password)),
        Container(
          height: 60,
          width: 170,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            color: Color.fromARGB(255, 49, 49, 49),
          ),
          child: Center(
              child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.navigate_next,
              size: 30,
              color: Colors.white,
            ),
          )),
        )
      ],
    );
  }
}

class TextControllers {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
}
