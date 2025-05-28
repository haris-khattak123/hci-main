import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:math';
import '../providers/auth_provider.dart';

class MessagesScreen extends StatefulWidget {
  final List<Map<String, dynamic>> messages;

  const MessagesScreen({super.key, required this.messages});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> with SingleTickerProviderStateMixin {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Timer? _typingTimer;
  Timer? _messageSimulationTimer;
  bool _isTyping = false;
  String _typingUnit = '';
  final Random _random = Random();
  final List<String> _units = ['Alpha', 'Bravo', 'Charlie', 'Delta', 'Echo'];
  final List<String> _operators = ['1', '2', '3', '4', '5', '6'];
  final List<String> _statusMessages = [
    'Sector secure',
    'Movement detected in grid %d%d',
    'Requesting backup at position %d%d',
    'Mission complete, returning to base',
    'Enemy contact, grid %d%d',
    'Supplies needed at checkpoint %d',
    'Area clear, proceeding to next objective',
    'Hostile activity reported in sector %d',
    'Recon complete, no threats detected',
    'Awaiting further instructions',
    'Team in position, ready for extraction',
    'Weather conditions deteriorating',
    'Equipment check complete, all systems operational',
    'Local civilians spotted, requesting guidance',
    'Comms check, signal strength %d%%',
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
    _startMessageSimulation();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _animationController.dispose();
    _typingTimer?.cancel();
    _messageSimulationTimer?.cancel();
    super.dispose();
  }

  void _startMessageSimulation() {
    // Simulate incoming messages every 15-30 seconds
    _messageSimulationTimer = Timer.periodic(
      Duration(seconds: 15 + _random.nextInt(15)),
      (timer) {
        if (mounted && !_isTyping) {
          _simulateIncomingMessage();
        }
      },
    );
  }

  void _simulateIncomingMessage() {
    final unit = _units[_random.nextInt(_units.length)];
    final operator = _operators[_random.nextInt(_operators.length)];
    final sender = '$unit-$operator';
    String message = _statusMessages[_random.nextInt(_statusMessages.length)];
    
    // Replace placeholders with random numbers
    message = message.replaceAllMapped(
      RegExp(r'%d'),
      (match) => _random.nextInt(10).toString(),
    );

    // Simulate typing indicator
    setState(() {
      _isTyping = true;
      _typingUnit = unit;
    });

    // Simulate typing delay (1-3 seconds)
    _typingTimer = Timer(
      Duration(seconds: 1 + _random.nextInt(2)),
      () {
        if (mounted) {
          Provider.of<AuthProvider>(context, listen: false).sendMessage(
            sender,
            message,
            context,
          );
          setState(() {
            _isTyping = false;
            _typingUnit = '';
          });
          _scrollToBottom();
        }
      },
    );
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUnit = Provider.of<AuthProvider>(context).currentUnit;
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
              bottom: BorderSide(
                color: Colors.green[700]!,
                width: 1.5,
              ),
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
                child: const Icon(Icons.security, color: Colors.green, size: 24),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'UNIT $currentUnit',
                          style: TextStyle(
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
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
                            'SECURE CHANNEL',
                            style: TextStyle(
                              color: Colors.green[300],
                              fontSize: 12,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
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
                          'ENCRYPTED CONNECTION ACTIVE',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green[700]!.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.radio_button_checked,
                      color: Colors.green[700],
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'LIVE',
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
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[900],
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.grey[900]!,
                  Colors.grey[850]!,
                ],
              ),
            ),
            child: Stack(
              children: [
                CustomPaint(
                  painter: _GridBackgroundPainter(),
                  size: Size.infinite,
                ),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      if (_isTyping) _buildTypingIndicator(),
                      Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          reverse: true,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          itemCount: widget.messages.length,
                          itemBuilder: (context, index) {
                            final msg = widget.messages[index];
                            return _buildMessageItem(msg, index);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        _buildMessageInput(context),
      ],
    );
  }

  Widget _buildTypingIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.green[700]!.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                _typingUnit.substring(0, 1),
                style: TextStyle(
                  color: Colors.green[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.green[700]!.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTypingDot(0),
                const SizedBox(width: 4),
                _buildTypingDot(1),
                const SizedBox(width: 4),
                _buildTypingDot(2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingDot(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600),
      curve: Interval(index * 0.2, (index + 1) * 0.2, curve: Curves.easeInOut),
      builder: (context, value, child) {
        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: Colors.green[700]!.withOpacity(0.3 + value * 0.7),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }

  Widget _buildMessageItem(Map<String, dynamic> msg, int index) {
    final isCommand = msg['isCommand'] as bool;
    final isLastInGroup = index == widget.messages.length - 1 ||
        widget.messages[index + 1]['sender'] != msg['sender'];

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: isLastInGroup ? 16 : 4,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isCommand) ...[
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.green[700]!.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.green[700]!.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  msg['sender']!.substring(0, 1),
                  style: TextStyle(
                    color: Colors.green[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isLastInGroup && !isCommand) ...[
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 4),
                    child: Row(
                      children: [
                        Text(
                          msg['sender']!,
                          style: TextStyle(
                            color: Colors.green[300],
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.green[700]!.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'UNIT ${msg['unit']}',
                            style: TextStyle(
                              color: Colors.green[300],
                              fontSize: 10,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isCommand
                        ? Colors.red[900]!.withOpacity(0.7)
                        : Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isCommand
                          ? Colors.red.withOpacity(0.3)
                          : Colors.green[700]!.withOpacity(0.3),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (isCommand ? Colors.red : Colors.green[700])!.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        msg['message']!,
                        style: const TextStyle(
                          color: Colors.white,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isCommand ? Icons.gavel : Icons.access_time,
                            color: Colors.grey[500],
                            size: 12,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            msg['time']!,
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 11,
                              letterSpacing: 0.5,
                            ),
                          ),
                          if (isCommand) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'COMMAND',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Colors.green[700]!.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
        border: Border(
          top: BorderSide(
            color: Colors.green[700]!.withOpacity(0.3),
            width: 1,
          ),
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
            child: Icon(Icons.security, color: Colors.green[700], size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.green[700]!.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: TextField(
                controller: _messageController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Type secure message...',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.green[700],
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.green[700]!.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      Provider.of<AuthProvider>(context, listen: false).sendMessage(
        'Operator',
        _messageController.text,
        context,
      );
      _messageController.clear();
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
}

class _GridBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green[800]!.withOpacity(0.1)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    const step = 20.0;
    for (double i = 0.0; i < size.width; i += step) {
      canvas.drawLine(Offset(i, 0.0), Offset(i, size.height), paint);
    }
    for (double i = 0.0; i < size.height; i += step) {
      canvas.drawLine(Offset(0.0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
