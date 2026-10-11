import 'package:flutter/material.dart';

class ConsultationDetailScreen extends StatefulWidget {
  const ConsultationDetailScreen({super.key});

  @override
  State<ConsultationDetailScreen> createState() =>
      _ConsultationDetailScreenState();
}

class _ConsultationDetailScreenState extends State<ConsultationDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Consultation Detail')),
      body: const Center(child: Text('Consultation Detail Screen')),
    );
  }
}
