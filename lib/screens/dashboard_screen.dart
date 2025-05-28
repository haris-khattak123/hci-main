import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'messages_screen.dart';
import 'units_screen.dart';
import 'settings_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green[700]!.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.military_tech, color: Colors.green[700], size: 24),
            ),
            const SizedBox(width: 12),
            const Text(
              'TACTICAL COMMS',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(width: 12),
            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _pulseAnimation.value,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green[700]!.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: Colors.green[700]!.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.green[700],
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'SECURE',
                          style: TextStyle(
                            color: Colors.green[300],
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green[700]!.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: Colors.green[700]!.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.security, color: Colors.green[700], size: 16),
                const SizedBox(width: 8),
                Text(
                  'UNIT ${authProvider.currentUnit}',
                  style: TextStyle(
                    color: Colors.green[700],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  color: Colors.green[700]!.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(2, 0),
                ),
              ],
            ),
            child: NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: NavigationRailLabelType.selected,
              backgroundColor: Colors.black,
              selectedIconTheme: IconThemeData(color: Colors.green[700]),
              selectedLabelTextStyle: TextStyle(color: Colors.green[700]),
              unselectedIconTheme: IconThemeData(color: Colors.grey[600]),
              unselectedLabelTextStyle: TextStyle(color: Colors.grey[600]),
              useIndicator: true,
              indicatorColor: Colors.green[700]!.withOpacity(0.2),
              destinations: [
                NavigationRailDestination(
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _selectedIndex == 0 ? Colors.green[700]!.withOpacity(0.1) : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.message),
                  ),
                  selectedIcon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green[700]!.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.message),
                  ),
                  label: const Text('COMMS'),
                ),
                NavigationRailDestination(
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _selectedIndex == 1 ? Colors.green[700]!.withOpacity(0.1) : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.group),
                  ),
                  selectedIcon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green[700]!.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.group),
                  ),
                  label: const Text('UNITS'),
                ),
                NavigationRailDestination(
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _selectedIndex == 2 ? Colors.green[700]!.withOpacity(0.1) : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.security),
                  ),
                  selectedIcon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green[700]!.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.security),
                  ),
                  label: const Text('SECURE'),
                ),
              ],
            ),
          ),
          const VerticalDivider(thickness: 1, width: 1, color: Colors.grey),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.grey[900]!,
                    Colors.grey[850]!,
                  ],
                ),
              ),
              child: _getSelectedScreen(_selectedIndex, authProvider),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getSelectedScreen(int index, AuthProvider authProvider) {
    switch (index) {
      case 0:
        return MessagesScreen(messages: authProvider.unitMessages);
      case 1:
        return const UnitsScreen();
      case 2:
        return const SettingsScreen();
      default:
        return MessagesScreen(messages: authProvider.unitMessages);
    }
  }
}