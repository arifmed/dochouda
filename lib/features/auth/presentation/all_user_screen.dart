import 'package:dochouda/features/auth/presentation/add_user_screen.dart';
import 'package:dochouda/features/auth/presentation/profile_user.dart';
import 'package:flutter/material.dart';
import 'package:dochouda/features/auth/data/add_user.dart';

class AllUserScreen extends StatefulWidget {
  const AllUserScreen({super.key});

  @override
  State<AllUserScreen> createState() => _AllUserState();
}

class _AllUserState extends State<AllUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Utilisateurs du système '),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddUserScreen()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: AddUser.getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (snapshot.data!.isEmpty) {
            return Center(child: Text('Aucun utilisateur trouvé'));
          } else {
            final users = snapshot.data!;
            return GridView.builder(
              itemCount: users.length,

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio:
                    (MediaQuery.of(context).size.width * .060) /
                    (MediaQuery.of(context).size.height * .046),
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final user = users[index];
                return Padding(
                  padding: const EdgeInsets.all(4.5),
                  child: Expanded(
                    child: Container(
                      width: 320,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Top Image section
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24.0),
                              child: AspectRatio(
                                aspectRatio: 0.95,
                                child: Image.network(
                                  user.avatar ?? '',
                                  fit: BoxFit.cover,

                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.person, size: 50);
                                  },
                                ),
                              ),
                            ),
                          ),

                          // User Info section
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Name & Verified Badge
                                Row(
                                  children: [
                                    Text(
                                      user.name,
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                            0.035,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: const BoxDecoration(
                                        color: Color(
                                          0xFF25D366,
                                        ), // Green verified color
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    ),
                                  ],
                                ),

                                // Description
                                Row(
                                  children: [
                                    Icon(
                                      Icons.email_outlined,
                                      size: 20,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      user.email,
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                            0.03,
                                        color: Colors.grey,
                                        height: 1.3,
                                      ),
                                    ),
                                  ],
                                ),

                                Row(
                                  children: [
                                    Icon(
                                      Icons.badge_rounded,
                                      size: 20,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      user.role,
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                            0.03,
                                        color: Colors.grey,
                                        height: 1.3,
                                      ),
                                    ),

                                    // Follow Button
                                  ],
                                ),
                                SizedBox(height: 8),
                                FilledButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProfileUser(user: user),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.read_more_rounded),
                                  label: const Text('Details'),
                                  style: FilledButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
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
              },
            );
          }
        },
      ),
    );
  }
}
