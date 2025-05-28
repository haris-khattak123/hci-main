import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Unit {
  final String name;
  final String type;
  final String status;
  final int personnel;
  final String location;
  final List<String> equipment;
  final Map<String, dynamic> missionStatus;

  Unit({
    required this.name,
    required this.type,
    required this.status,
    required this.personnel,
    required this.location,
    required this.equipment,
    required this.missionStatus,
  });
}

class Personnel {
  final String id;
  final String name;
  final String rank;
  final String role;
  final String unit;
  final String status;
  final String lastSeen;

  Personnel({
    required this.id,
    required this.name,
    required this.rank,
    required this.role,
    required this.unit,
    required this.status,
    required this.lastSeen,
  });
}

class Mission {
  final String id;
  final String title;
  final String status;
  final String priority;
  final String assignedUnit;
  final String description;
  final DateTime startTime;
  final DateTime? endTime;
  final List<String> objectives;
  final Map<String, String> resources;

  Mission({
    required this.id,
    required this.title,
    required this.status,
    required this.priority,
    required this.assignedUnit,
    required this.description,
    required this.startTime,
    this.endTime,
    required this.objectives,
    required this.resources,
  });
}

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String _currentUnit = 'Alpha';
  String _email = 'operator@command.gov';
  String _rank = 'Lieutenant';
  String _role = 'Communications Officer';

  // Units data
  final List<Unit> _units = [
    Unit(
      name: 'Alpha',
      type: 'Infantry',
      status: 'Active',
      personnel: 12,
      location: 'Grid 42-15',
      equipment: ['M4A1', 'NVG', 'Radio', 'Medical Kit'],
      missionStatus: {
        'currentMission': 'Patrol Sector 7',
        'status': 'In Progress',
        'progress': 65,
        'casualties': 0,
        'supplies': 85,
      },
    ),
    Unit(
      name: 'Bravo',
      type: 'Recon',
      status: 'Active',
      personnel: 8,
      location: 'Grid 38-22',
      equipment: ['DRONE', 'Binoculars', 'Thermal Camera', 'Radio'],
      missionStatus: {
        'currentMission': 'Area Surveillance',
        'status': 'In Progress',
        'progress': 40,
        'casualties': 0,
        'supplies': 90,
      },
    ),
    Unit(
      name: 'Charlie',
      type: 'Support',
      status: 'Active',
      personnel: 15,
      location: 'Base Camp',
      equipment: ['Supply Truck', 'Medical Equipment', 'Radio', 'Generator'],
      missionStatus: {
        'currentMission': 'Supply Distribution',
        'status': 'In Progress',
        'progress': 75,
        'casualties': 0,
        'supplies': 60,
      },
    ),
    Unit(
      name: 'Delta',
      type: 'Special Ops',
      status: 'Active',
      personnel: 6,
      location: 'Grid 45-18',
      equipment: ['Specialized Gear', 'NVG', 'Encrypted Radio', 'Advanced Medical Kit'],
      missionStatus: {
        'currentMission': 'High-Value Target Extraction',
        'status': 'In Progress',
        'progress': 30,
        'casualties': 0,
        'supplies': 95,
      },
    ),
  ];

  // Personnel data
  final List<Personnel> _personnel = [
    Personnel(
      id: 'A-101',
      name: 'John Smith',
      rank: 'Sergeant',
      role: 'Squad Leader',
      unit: 'Alpha',
      status: 'Active',
      lastSeen: '2 minutes ago',
    ),
    Personnel(
      id: 'B-203',
      name: 'Sarah Johnson',
      rank: 'Corporal',
      role: 'Recon Specialist',
      unit: 'Bravo',
      status: 'Active',
      lastSeen: '5 minutes ago',
    ),
    // Add more personnel as needed
  ];

  // Active missions
  final List<Mission> _missions = [
    Mission(
      id: 'M-001',
      title: 'Sector 7 Patrol',
      status: 'In Progress',
      priority: 'High',
      assignedUnit: 'Alpha',
      description: 'Conduct routine patrol of Sector 7, report any suspicious activity.',
      startTime: DateTime.now().subtract(const Duration(hours: 2)),
      objectives: [
        'Secure perimeter',
        'Check supply caches',
        'Report enemy movements',
      ],
      resources: {
        'Personnel': '12 soldiers',
        'Equipment': 'Standard issue',
        'Support': 'Charlie Unit',
      },
    ),
    Mission(
      id: 'M-002',
      title: 'Area Surveillance',
      status: 'In Progress',
      priority: 'Medium',
      assignedUnit: 'Bravo',
      description: 'Monitor enemy movements in designated area.',
      startTime: DateTime.now().subtract(const Duration(hours: 1)),
      objectives: [
        'Set up observation posts',
        'Monitor enemy communications',
        'Map enemy positions',
      ],
      resources: {
        'Personnel': '8 recon specialists',
        'Equipment': 'DRONE, Thermal cameras',
        'Support': 'Command Center',
      },
    ),
    // Add more missions as needed
  ];

  // Messages with more realistic military communication
  final List<Map<String, dynamic>> _messages = [
    {
      'sender': 'Command',
      'message': 'All units, commence operation PHANTOM. Report status.',
      'time': '08:30',
      'unit': 'All',
      'isCommand': true,
      'priority': 'High',
    },
    {
      'sender': 'Alpha-1',
      'message': 'Alpha in position. Sector 7 secure. No hostiles detected.',
      'time': '08:32',
      'unit': 'Alpha',
      'isCommand': false,
      'status': 'Normal',
    },
    {
      'sender': 'Bravo-6',
      'message': 'Movement detected in grid 42. Possible enemy patrol. Requesting backup.',
      'time': '08:35',
      'unit': 'Bravo',
      'isCommand': false,
      'status': 'Alert',
    },
    {
      'sender': 'Command',
      'message': 'Bravo-6, maintain position. Alpha-2 en route to your location. ETA 5 minutes.',
      'time': '08:36',
      'unit': 'Bravo',
      'isCommand': true,
      'priority': 'High',
    },
    {
      'sender': 'Charlie-3',
      'message': 'Supply convoy en route to Alpha position. ETA 15 minutes.',
      'time': '08:40',
      'unit': 'Charlie',
      'isCommand': false,
      'status': 'Normal',
    },
  ];

  // Getters
  bool get isAuthenticated => _isAuthenticated;
  String get currentUnit => _currentUnit;
  String get email => _email;
  String get rank => _rank;
  String get role => _role;
  List<Unit> get units => _units;
  List<Personnel> get personnel => _personnel;
  List<Mission> get missions => _missions;
  List<Map<String, dynamic>> get unitMessages =>
      _messages.where((msg) => msg['unit'] == _currentUnit || msg['unit'] == 'All').toList();

  // Unit operations
  Unit? getUnitDetails(String unitName) {
    return _units.firstWhere((unit) => unit.name == unitName);
  }

  List<Personnel> getUnitPersonnel(String unitName) {
    return _personnel.where((p) => p.unit == unitName).toList();
  }

  List<Mission> getUnitMissions(String unitName) {
    return _missions.where((m) => m.assignedUnit == unitName).toList();
  }

  // Authentication
  void login(String email, String password) {
    _isAuthenticated = true;
    _email = email;
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }

  void changeUnit(String unit) {
    _currentUnit = unit;
    notifyListeners();
  }

  // Communication
  void sendMessage(String sender, String message, BuildContext context) {
    final now = DateTime.now();
    final formattedTime = DateFormat('HH:mm').format(now);

    _messages.insert(0, {
      'sender': sender,
      'message': message,
      'time': formattedTime,
      'unit': _currentUnit,
      'isCommand': false,
      'status': 'Normal',
    });
    notifyListeners();
  }

  void addCommandMessage(String message, {String priority = 'Normal'}) {
    final now = DateTime.now();
    final formattedTime = DateFormat('HH:mm').format(now);

    _messages.insert(0, {
      'sender': 'Command',
      'message': message,
      'time': formattedTime,
      'unit': 'All',
      'isCommand': true,
      'priority': priority,
    });
    notifyListeners();
  }

  // Mission operations
  void updateMissionStatus(String missionId, String status, {int? progress}) {
    final missionIndex = _missions.indexWhere((m) => m.id == missionId);
    if (missionIndex != -1) {
      final mission = _missions[missionIndex];
      _missions[missionIndex] = Mission(
        id: mission.id,
        title: mission.title,
        status: status,
        priority: mission.priority,
        assignedUnit: mission.assignedUnit,
        description: mission.description,
        startTime: mission.startTime,
        endTime: status == 'Completed' ? DateTime.now() : null,
        objectives: mission.objectives,
        resources: mission.resources,
      );
      notifyListeners();
    }
  }

  // Personnel operations
  void updatePersonnelStatus(String personnelId, String status) {
    final personnelIndex = _personnel.indexWhere((p) => p.id == personnelId);
    if (personnelIndex != -1) {
      final person = _personnel[personnelIndex];
      _personnel[personnelIndex] = Personnel(
        id: person.id,
        name: person.name,
        rank: person.rank,
        role: person.role,
        unit: person.unit,
        status: status,
        lastSeen: 'Just now',
      );
      notifyListeners();
    }
  }

  // Simulate incoming messages
  void simulateIncomingMessage() {
    final now = DateTime.now();
    final formattedTime = DateFormat('HH:mm').format(now);
    final units = ['Alpha', 'Bravo', 'Charlie', 'Delta'];
    final randomUnit = units[(DateTime.now().millisecondsSinceEpoch % 4).toInt()];
    
    final messages = [
      'Sector secure, proceeding to next checkpoint',
      'Movement detected in grid %d%d, investigating',
      'Requesting backup at position %d%d, enemy contact',
      'Mission complete, returning to base',
      'Supplies running low, need resupply at checkpoint %d',
      'Weather conditions deteriorating, visibility reduced',
      'Local civilians spotted, requesting guidance',
      'Equipment malfunction, need technical support',
      'Area clear, no threats detected',
      'Comms check, signal strength %d%%',
    ];
    
    final randomMessage = messages[(DateTime.now().millisecondsSinceEpoch % messages.length).toInt()]
        .replaceAllMapped(RegExp(r'%d'), (match) => (DateTime.now().millisecondsSinceEpoch % 10).toString());

    _messages.insert(0, {
      'sender': '$randomUnit-${(DateTime.now().millisecondsSinceEpoch % 10).toInt()}',
      'message': randomMessage,
      'time': formattedTime,
      'unit': randomUnit,
      'isCommand': false,
      'status': 'Normal',
    });
    notifyListeners();
  }
}