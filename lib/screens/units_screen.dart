import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class UnitsScreen extends StatelessWidget {
  const UnitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                color: Colors.green[700]!.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border(
              bottom: BorderSide(color: Colors.green[700]!, width: 1.5),
            ),
          ),
          child: Row(
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
                'UNIT DEPLOYMENT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
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
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: authProvider.units.map((unit) => _buildUnitItem(unit, authProvider)).toList(),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                color: Colors.green[700]!.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
            border: Border(
              top: BorderSide(color: Colors.green[700]!, width: 1.5),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green[700]!.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.terminal, color: Colors.green[700], size: 20),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'COMMAND PANEL',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildCommandButton(
                'All Units Status',
                Icons.assessment,
                'View real-time status of all deployed units',
                () => _showAllUnitsStatus(context, authProvider),
              ),
              const SizedBox(height: 8),
              _buildCommandButton(
                'Personnel Management',
                Icons.people_alt,
                'Manage unit personnel and assignments',
                () => _showPersonnelManagement(context, authProvider),
              ),
              const SizedBox(height: 8),
              _buildCommandButton(
                'Mission Briefing',
                Icons.description,
                'Access current mission objectives and protocols',
                () => _showMissionBriefing(context, authProvider),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUnitItem(Unit unit, AuthProvider authProvider) {
    final isSelected = authProvider.currentUnit == unit.name;
    final missionStatus = unit.missionStatus;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? Colors.green[900]!.withOpacity(0.3) : Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? Colors.green[700]! : Colors.green[700]!.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green[700]!.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(_getUnitIcon(unit.type), color: Colors.green[700], size: 24),
            ),
            title: Row(
              children: [
                Text(
                  unit.name,
                  style: TextStyle(
                    color: Colors.green[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green[700]!.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    unit.type,
                    style: TextStyle(
                      color: Colors.green[300],
                      fontSize: 12,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.green[700],
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    unit.status,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Personnel: ${unit.personnel}',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            trailing: isSelected
                ? Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green[700]!.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.check_circle, color: Colors.green[700], size: 20),
                  )
                : null,
            onTap: () => authProvider.changeUnit(unit.name),
          ),
          if (isSelected) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Mission: ${missionStatus['currentMission']}',
                    style: TextStyle(
                      color: Colors.green[300],
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatusIndicator(
                          'Progress',
                          missionStatus['progress'].toString() + '%',
                          Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildStatusIndicator(
                          'Supplies',
                          missionStatus['supplies'].toString() + '%',
                          Colors.orange,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildStatusIndicator(
                          'Casualties',
                          missionStatus['casualties'].toString(),
                          Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Location: ${unit.location}',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusIndicator(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommandButton(String title, IconData icon, String subtitle, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.green[700]!.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.green[700]!.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.green[700], size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 12,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.green[700], size: 16),
        onTap: onTap,
      ),
    );
  }

  IconData _getUnitIcon(String type) {
    switch (type) {
      case 'Infantry':
        return Icons.directions_walk;
      case 'Recon':
        return Icons.visibility;
      case 'Support':
        return Icons.support;
      case 'Special Ops':
        return Icons.security;
      default:
        return Icons.military_tech;
    }
  }

  void _showAllUnitsStatus(BuildContext context, AuthProvider authProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Row(
          children: [
            Icon(Icons.assessment, color: Colors.green[700]),
            const SizedBox(width: 8),
            const Text(
              'ALL UNITS STATUS',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: authProvider.units.map((unit) {
              final missionStatus = unit.missionStatus;
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.green[700]!.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          unit.name,
                          style: TextStyle(
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.green[700]!.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            unit.type,
                            style: TextStyle(
                              color: Colors.green[300],
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Mission: ${missionStatus['currentMission']}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    Text(
                      'Status: ${missionStatus['status']}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    Text(
                      'Location: ${unit.location}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: missionStatus['progress'] / 100,
                      backgroundColor: Colors.grey[800],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green[700]!),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'CLOSE',
              style: TextStyle(
                color: Colors.green[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPersonnelManagement(BuildContext context, AuthProvider authProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Row(
          children: [
            Icon(Icons.people_alt, color: Colors.green[700]),
            const SizedBox(width: 8),
            const Text(
              'PERSONNEL MANAGEMENT',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: authProvider.personnel.map((person) {
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.green[700]!.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green[700]!.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        person.name[0],
                        style: TextStyle(
                          color: Colors.green[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            person.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${person.rank} - ${person.role}',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green[700]!.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        person.unit,
                        style: TextStyle(
                          color: Colors.green[300],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'CLOSE',
              style: TextStyle(
                color: Colors.green[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showMissionBriefing(BuildContext context, AuthProvider authProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Row(
          children: [
            Icon(Icons.description, color: Colors.green[700]),
            const SizedBox(width: 8),
            const Text(
              'MISSION BRIEFING',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: authProvider.missions.map((mission) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.green[700]!.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            mission.title,
                            style: TextStyle(
                              color: Colors.green[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getPriorityColor(mission.priority).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            mission.priority,
                            style: TextStyle(
                              color: _getPriorityColor(mission.priority),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      mission.description,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Assigned Unit: ${mission.assignedUnit}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Objectives:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    ...mission.objectives.map((objective) => Padding(
                          padding: const EdgeInsets.only(left: 8, bottom: 4),
                          child: Row(
                            children: [
                              Icon(Icons.arrow_right, color: Colors.green[700], size: 16),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  objective,
                                  style: const TextStyle(color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'CLOSE',
              style: TextStyle(
                color: Colors.green[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}