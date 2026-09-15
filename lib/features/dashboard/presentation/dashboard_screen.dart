import 'package:dochouda/features/auth/presentation/login_screen.dart';
import 'package:dochouda/features/dashboard/presentation/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:m3e_floating_toolbar/floating_toolbar/m3e_floating_toolbar.dart';
import 'package:m3e_floating_toolbar/floating_toolbar/style/m3e_floating_toolbar_decoration.dart';

import '../../auth/providers/auth_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: CircleAvatar(
=======
        leading: const Padding(
          padding: EdgeInsets.only(left: 8),
          child: CircleAvatar(radius: 24, child: Icon(Icons.person)),
        ),

        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Praticien",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
            Text(
              "Nom et prenom",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
>>>>>>> 723b33427f7adcc1dcbddd6bb1e2d5a2162cb767
            child: MenuAnchor(
              menuChildren: [
                MenuItemButton(
                  leadingIcon: const Icon(Icons.person),
                  child: const Text('Profile'),
                  onPressed: () {},
                ),
                MenuItemButton(
                  leadingIcon: const Icon(Icons.person_add_alt_1),
                  child: const Text('Ajouter un utilisateur'),
                  onPressed: () {},
                ),
                MenuItemButton(
                  leadingIcon: const Icon(Icons.people_alt_rounded),
                  child: const Text('Utilisateurs'),
                  onPressed: () {},
                ),

                MenuItemButton(
                  leadingIcon: const Icon(Icons.password),
                  child: const Text('Changer le mot de passe'),
                  onPressed: () {},
                ),
                const PopupMenuDivider(),
                MenuItemButton(
                  leadingIcon: const Icon(Icons.logout),
                  child: const Text('Déconnexion'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
              ],
              builder:
                  (
                    BuildContext context,
                    MenuController controller,
                    Widget? child,
                  ) {
                    return IconButton.filledTonal(
                      icon: const Icon(Icons.person),
                      onPressed: () {
                        if (controller.isOpen) {
                          controller.close();
                        } else {
                          controller.open();
                        }
                      },
                    );
                  },
            ),
          ),
        ),

        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${auth.user!.role} ',
                    style: const TextStyle(
                      color: Colors.blue, // accent color
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: auth.user!.email,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            Text(
              auth.user!.name,
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
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            ),
          ),
        ],
      ),

      // --- INTEGRATED FLOATING MENU ---
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
                      Text('Dashboard', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),

                IconButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (context) => Menu()));
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

      // --------------------------------
      body: SafeArea(
        child: SingleChildScrollView(
          // Added extra padding at the bottom so the FAB doesn't cover the last content
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            children: [
              // Placed within a Stack or screen layout (Screen Alignment: Bottom Center):

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
                          _buildStatCard(context, '1000', 'Mois dernier', true),
                          _buildStatCard(context, '1000', 'Cette année', true),
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
                          _buildStatCard(context, '1000', 'Cette année', false),
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
