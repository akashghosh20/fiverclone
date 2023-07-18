import 'package:flutter/material.dart';

class VisitorList extends StatefulWidget {
  const VisitorList({super.key});

  @override
  State<VisitorList> createState() => _VisitorListState();
}

class _VisitorListState extends State<VisitorList> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Please Complete The Profile First  ",style:TextStyle(
        fontSize: 20 ,
        color: Colors.black,
      ),),

      ),

    );

  }
}
