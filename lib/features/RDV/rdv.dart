import 'package:flutter/material.dart';

class RDV extends StatefulWidget {
  const RDV({super.key});

  @override
  State<RDV> createState() => _RDVState();
}

class _RDVState extends State<RDV> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("RDV")));
  }
}
