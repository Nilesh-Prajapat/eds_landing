import 'package:flutter/material.dart';

class events extends StatefulWidget {
  const events({super.key});

  @override
  State<events> createState() => _eventsState();
}

class _eventsState extends State<events> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        height: size .height,
        width: size.width,
        child: Center(
          child: Text("data"),
        )
    );
  }
}
