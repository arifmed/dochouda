import 'package:dochouda/features/auth/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileUser extends StatefulWidget {
  const ProfileUser({super.key, required this.user});
  final UserModel user;
  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(title: const Text('Profile')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section with Cover Image, Avatar, and Follow Button
              Stack(
                clipBehavior: Clip.none,
                children: [
                  // Banner Image Container
                  Container(
                    height: 50,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      image: const DecorationImage(
                        image: NetworkImage(''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Follow Button
                  Positioned(
                    top: 5,
                    right: 32,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),

                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FilledButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.edit, size: 20),
                            label: const Text(
                              'Modifier',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Profile Avatar Overlapping Cover
                  Positioned(
                    left: 32,
                    bottom: -50,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: const CircleAvatar(
                        radius: 54,

                        backgroundImage: NetworkImage(
                          'https://i.pravatar.cc/300?img=12', // Placeholder avatar
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              const SizedBox(height: 40),

              // Name and Title Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.user.name,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,

                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Role: ${widget.user.role}',
                      style: TextStyle(fontSize: 18, height: 1.4),
                    ),
                    Text(
                      'Email: ${widget.user.email}',
                      style: TextStyle(fontSize: 18, height: 1.4),
                    ),
                    Text(
                      'Date de création: ${DateFormat("dd/MM/yyyy HH:mm").format(DateTime.parse("${widget.user.created_at}").toLocal())}',
                      style: TextStyle(fontSize: 18, height: 1.4),
                    ),
                    Text(
                      'Date de mise à jour: ${DateFormat("dd/MM/yyyy HH:mm").format(DateTime.parse("${widget.user.updated_at}").toLocal())}',
                      style: TextStyle(fontSize: 18, height: 1.4),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Stats Divider Line
              Divider(color: Colors.grey.shade200, height: 1),

              // Statistics Section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Row(
                  children: [
                    _buildStatItem('72.9K', 'Likes'),
                    _buildVerticalDivider(),
                    _buildStatItem('828', 'Posts'),
                    _buildVerticalDivider(),
                    _buildStatItem('342.9K', 'Views'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget to build each stat column
  static Widget _buildStatItem(String count, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(
            count,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 16, color: Colors.grey)),
        ],
      ),
    );
  }

  // Helper widget for vertical divider between stats
  static Widget _buildVerticalDivider() {
    return Container(height: 40, width: 1, color: Colors.grey.shade200);
  }
}
