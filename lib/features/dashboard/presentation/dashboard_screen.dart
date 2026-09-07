import 'package:flutter/material.dart';
import 'package:m3e_floating_toolbar/m3e_floating_toolbar.dart'; // Ensure this is imported

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 8),
          child: CircleAvatar(radius: 24, child: Icon(Icons.person)),
        ),
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Docteur',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
            Text(
              'Houda CHAFIQ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton.filledTonal(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton.filledTonal(
              icon: const Icon(Icons.logout),
              onPressed: () {},
            ),
          ),
        ],
      ),

      // --- INTEGRATED FLOATING MENU ---
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. The Main Floating Toolbar
          M3EHorizontalFloatingToolbar(
            expanded: true,
            decoration: M3EFloatingToolbarDecoration(
              colors: M3EFloatingToolbarDefaults.vibrantColors(context),
              motion: M3EMotion.expressiveSpatialFast,
            ),
            leadingContent: IconButton(
              icon: const Icon(Icons.attachment_rounded),
              onPressed: () {},
            ),
            content: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.mic_rounded),
                  onPressed: () {},
                ),

                IconButton(
                  icon: const Icon(Icons.videocam_rounded),
                  onPressed: () {},
                ),
              ],
            ),
            trailingContent: IconButton(
              icon: const Icon(Icons.send_rounded),
              onPressed: () {},
            ),
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

      // --------------------------------
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            // Added extra padding at the bottom so the FAB doesn't cover the last content
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              children: [
                /////////////////////patients card////////////////////////////
                Card.filled(
                  color: const Color(0xff0a5ad0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0, left: 20.0),
                          child: TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.people, color: Colors.white),
                            label: const Text(
                              'Patients',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.95,
                          height: MediaQuery.of(context).size.width * 0.2,
                          child: Card.filled(
                            color: const Color(0xff0e6fff),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: ListTile(
                                    title: Text(
                                      '1000',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                            0.055,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "Aujourd'hui",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                            0.03,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width * 0.7,
                        child: GridView.count(
                          physics:
                              const NeverScrollableScrollPhysics(), // Added to prevent nested scrolling issues
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          crossAxisCount: 3,
                          padding: const EdgeInsets.all(15),
                          childAspectRatio: 1.0,
                          children: [
                            _buildStatCard(context, '1090', 'Hier', true),
                            _buildStatCard(
                              context,
                              '1200',
                              'Cette semaine',
                              true,
                            ),
                            _buildStatCard(
                              context,
                              '1040',
                              'Semaine dernière',
                              true,
                            ),
                            _buildStatCard(context, '1100', 'Ce mois', true),
                            _buildStatCard(
                              context,
                              '1000',
                              'Mois dernier',
                              true,
                            ),
                            _buildStatCard(
                              context,
                              '1000',
                              'Cette année',
                              true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                /////////////////////Payement///////////////////////////
                Card.filled(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0, left: 20.0),
                          child: TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.payments_rounded,
                              color: Color(0xff0a5ad0),
                            ),
                            label: const Text(
                              'Caisse',
                              style: TextStyle(
                                color: Color(0xff0a5ad0),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.95,
                          height: MediaQuery.of(context).size.width * 0.2,
                          child: Card(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: ListTile(
                                    title: Text(
                                      '1000',
                                      style: TextStyle(
                                        color: const Color(0xff0e6fff),
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                            0.055,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "Aujourd'hui",
                                      style: TextStyle(
                                        color: const Color(0xff0e6fff),
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                            0.03,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width * 0.7,
                        child: GridView.count(
                          physics:
                              const NeverScrollableScrollPhysics(), // Added to prevent nested scrolling issues
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          crossAxisCount: 3,
                          padding: const EdgeInsets.all(15),
                          childAspectRatio: 1.0,
                          children: [
                            _buildStatCard(context, '1090', 'Hier', false),
                            _buildStatCard(
                              context,
                              '1200',
                              'Cette semaine',
                              false,
                            ),
                            _buildStatCard(
                              context,
                              '1040',
                              'Semaine dernière',
                              false,
                            ),
                            _buildStatCard(context, '1100', 'Ce mois', false),
                            _buildStatCard(
                              context,
                              '1000',
                              'Mois dernier',
                              false,
                            ),
                            _buildStatCard(
                              context,
                              '1000',
                              'Cette année',
                              false,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // A helper method to keep your GridView clean since the cards repeat exactly
  Widget _buildStatCard(
    BuildContext context,
    String title,
    String subtitle,
    bool isBlueCard,
  ) {
    return Card.filled(
      color: isBlueCard ? const Color(0xff0e6fff) : Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ListTile(
              title: Text(
                title,
                style: TextStyle(
                  color: isBlueCard ? Colors.white : const Color(0xff0e6fff),
                  fontSize: MediaQuery.of(context).size.width * 0.055,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                subtitle,
                style: TextStyle(
                  color: isBlueCard ? Colors.white : const Color(0xff0e6fff),
                  fontSize: MediaQuery.of(context).size.width * 0.024,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
