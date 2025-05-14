import 'package:flutter/material.dart';
import '../settings/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: colorScheme.onSurface, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: colorScheme.primary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.edit, color: colorScheme.primary),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile header
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  // Profile picture
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: colorScheme.primary.withOpacity(0.2),
                        child: CircleAvatar(
                          radius: 58,
                          backgroundColor: colorScheme.primary,
                          child: const Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: colorScheme.secondary,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: colorScheme.surface,
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            size: 20,
                            color: colorScheme.onSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Name
                  Text(
                    'Lana Smith',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Email
                  Text(
                    'lana.smith@example.com',
                    style: TextStyle(
                      fontSize: 16,
                      color: colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
            
            // Stats section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _buildStatItem(context, '42', 'Recipes'),
                  _buildStatItem(context, '12', 'Weeks'),
                  _buildStatItem(context, '1.2k', 'Followers'),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Settings sections
            _buildSection(
              context,
              'Account',
              [
                _buildSettingItem(context, Icons.person_outline, 'Personal Information'),
                _buildSettingItem(context, Icons.lock_outline, 'Security'),
                _buildSettingItem(context, Icons.notifications_none, 'Notifications'),
              ],
            ),
            
            _buildSection(
              context,
              'Preferences',
              [
                _buildSettingItem(context, Icons.restaurant_menu, 'Dietary Preferences'),
                _buildSettingItem(context, Icons.fitness_center, 'Health Goals'),
                _buildSettingItem(context, Icons.kitchen, 'Pantry Management'),
              ],
            ),
            
            _buildSection(
              context,
              'Other',
              [
                _buildSettingItem(context, Icons.help_outline, 'Help & Support'),
                _buildSettingItem(context, Icons.info_outline, 'About'),
                _buildSettingItem(
                  context, 
                  Icons.logout, 
                  'Log Out',
                  textColor: colorScheme.error,
                ),
              ],
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatItem(BuildContext context, String value, String label) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSection(BuildContext context, String title, List<Widget> items) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          ...items,
        ],
      ),
    );
  }
  
  Widget _buildSettingItem(
    BuildContext context, 
    IconData icon, 
    String title, 
    {Color? textColor}
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: textColor ?? colorScheme.primary,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: textColor ?? colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: colorScheme.outline,
        ),
        onTap: () {},
      ),
    );
  }
}
