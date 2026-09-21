import 'package:dochouda/features/auth/models/user_model.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: Colors.white,
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
                    height: 180,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1534088568595-a066f410bcda?q=80&w=1000',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Follow Button
                  Positioned(
                    top: 24,
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
                            icon: const Icon(
                              Icons.edit,
                              size: 20,
                              color: Colors.black,
                            ),
                            label: const Text(
                              'Modifier',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
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
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const CircleAvatar(
                        radius: 54,
                        backgroundColor: Color(0xFFE2E8F0),
                        backgroundImage: NetworkImage(
                          'https://i.pravatar.cc/300?img=12', // Placeholder avatar
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Status Bar / Experience Indicator Section
              Padding(
                padding: const EdgeInsets.only(left: 150, right: 24),
                child: Row(
                  children: [
                    const Text(
                      'exp.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SizedBox(
                        height: 18,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 22,
                          itemBuilder: (context, index) {
                            // Colors corresponding to the gradient indicator in the design
                            Color color = Colors.grey.shade300;
                            if (index < 3) {
                              color = const Color(0xFF6B5B95);
                            } else if (index < 6) {
                              color = const Color(0xFFE94B3C);
                            } else if (index < 10) {
                              color = const Color(0xFFF3A683);
                            } else if (index < 14) {
                              color = const Color(0xFF574B90);
                            } else if (index < 16) {
                              color = const Color(0xFF45B7D1);
                            }

                            return Container(
                              width: 3,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 1.5,
                              ),
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Name and Title Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.user.name!,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Product Designer who focuses on\nsimplicity & usability.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                        height: 1.4,
                      ),
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
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
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
