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
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
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
                  onPressed: () {},
                  icon: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.bar_chart_rounded),
                      Text('Dashbord', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),

                IconButton(
                  onPressed: () {},
                  icon: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.calendar_today_rounded),
                      Text('RDV', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.medical_services_rounded),
                      Text('Consultations', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),

                IconButton(
                  onPressed: () {},
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
          ),

          const SizedBox(width: 12),

          // 2. The Isolated "+" Action Button
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFFE6D6FF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              icon: const Icon(Icons.add, color: Color(0xFF5E4A83), size: 28),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
