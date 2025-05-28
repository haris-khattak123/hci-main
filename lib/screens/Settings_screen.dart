import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.black,
              border: Border(bottom: BorderSide(color: Colors.green[700]!))
          ),
          child: const Text(
            'SECURITY SETTINGS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              ListTile(
                title: const Text('Operator ID'),
                subtitle: Text(
                  authProvider.email,
                  style: const TextStyle(color: Colors.grey),
                ),
                leading: Icon(Icons.person, color: Colors.green[700]),
              ),
              const Divider(color: Colors.grey),
              ListTile(
                title: const Text('Current Unit'),
                subtitle: Text(
                  authProvider.currentUnit,
                  style: const TextStyle(color: Colors.grey),
                ),
                leading: Icon(Icons.group, color: Colors.green[700]),
              ),
              const Divider(color: Colors.grey),
              ListTile(
                title: const Text('Change Access Code'),
                leading: Icon(Icons.lock, color: Colors.green[700]),
                onTap: () => _showChangePasswordDialog(context),
              ),
              const Divider(color: Colors.grey),
              ListTile(
                title: const Text('System Diagnostics'),
                leading: Icon(Icons.build, color: Colors.green[700]),
                onTap: () {},
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.black,
              border: Border(top: BorderSide(color: Colors.red))
          ),
          child: ListTile(
            title: const Text(
              'TERMINATE SESSION',
              style: TextStyle(color: Colors.red),
            ),
            leading: Icon(Icons.logout, color: Colors.red[700]),
            onTap: () => authProvider.logout(),
          ),
        ),
      ],
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'CHANGE ACCESS CODE',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Current Code',
                labelStyle: TextStyle(color: Colors.green[700]),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green[700]!),
                ),
              ),
            ),
            TextField(
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'New Code',
                labelStyle: TextStyle(color: Colors.green[700]),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green[700]!),
                ),
              ),
            ),
            TextField(
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Confirm New Code',
                labelStyle: TextStyle(color: Colors.green[700]),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green[700]!),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[800],
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('Confirm Change'),
          ),
        ],
      ),
    );
  }
}