import 'package:dochouda/features/RDV/rdv.dart';
import 'package:dochouda/features/consultations/presentation/consultation_screen.dart';
import 'package:dochouda/features/dashboard/presentation/dashboard_screen.dart';
import 'package:dochouda/features/patients/presentation/patients_screen.dart';
import 'package:flutter/material.dart';
import 'package:m3e_floating_toolbar/floating_toolbar/m3e_floating_toolbar.dart';
import 'package:m3e_floating_toolbar/floating_toolbar/style/m3e_floating_toolbar_decoration.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return
    // 1. The Main Floating Toolbar
    M3EHorizontalFloatingToolbar(
      expanded: true,
      decoration: M3EFloatingToolbarDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 8),
      ),
      // leadingContent: IconButton(
      //   icon: const Icon(Icons.attachment_rounded),
      //   onPressed: () {},
      // ),
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const DashboardScreen(),
                ),
              );
            },
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.bar_chart_rounded),
                Text('Dashboard', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),

          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => RDV()));
            },
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.calendar_today_rounded),
                Text('RDV', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ConsultationScreen(),
                ),
              );
            },
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.medical_services_rounded),
                Text('Consultations', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const PatientsScreen()),
              );
            },
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.people_rounded),
                Text('Patients', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
      //trailingContent: IconButton(
      //  icon: const Icon(Icons.send_rounded),
      //  onPressed: () {},
      //),
    );
  }
}
