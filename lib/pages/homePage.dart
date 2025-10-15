import 'package:eds_landing/main.dart';
import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return  Container(
      color: Colors.red,
      height: size.height,
      width: size.width,
      child:Text("data"));
  }
}
