import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textController = TextEditingController();
  final List<Fortune> _options = [];

  int _selectedOption = 0;
  bool _isSpinning = false;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Decision Maker Wheel'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: FortuneWheel(
              selected: _selectedOption,
              items: _options.isNotEmpty ? _options : _getDefaultOptions(),
              onAnimationEnd: _handleAnimationEnd,
              animateFirst: _isSpinning,
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: 'Enter an option',
              suffixIcon: IconButton(
                icon: Icon(Icons.add),
                onPressed: _handleAddOption,
              ),
            ),
            onSubmitted: (_) => _handleAddOption(),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _isSpinning ? null : _handleSpinWheel,
            child: Text('Spin'),
          ),
        ],
      ),
    );
  }

  void _handleAddOption() {
    final newOption = _textController.text.trim();
    if (newOption.isNotEmpty) {
      setState(() {
        _options.add(Fortune(id: _options.length, child: Text(newOption)));
        _textController.clear();
      });
    }
  }

  void _handleSpinWheel() {
    setState(() {
      _isSpinning = true;
      _selectedOption = 0;
    });
  }

  void _handleAnimationEnd(int selected) {
    final selectedOption = _options[selected].child;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Selected Option'),
          content: selectedOption,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _isSpinning = false;
                });
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  List<Fortune> _getDefaultOptions() {
    return [
      Fortune(id: 0, child: Text('Option 1')),
      Fortune(id: 1, child: Text('Option 2')),
      Fortune(id: 2, child: Text('Option 3')),
      Fortune(id: 3, child: Text('Option 4')),
    ];
  }
}
