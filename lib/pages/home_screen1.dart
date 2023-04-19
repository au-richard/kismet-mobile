import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> decisions = [];
  final TextEditingController _textEditingController = TextEditingController();
  final StreamController<int> _selectedController = StreamController<int>();
  int selected = 0;
  List<FortuneItem> items = [
    FortuneItem(child: Text('Option 1')),
    FortuneItem(child: Text('Option 2')),
  ]; // Define items list

  // void _addDecision() {
  //   String newDecision = _textEditingController.text.trim();
  //   if (newDecision.isNotEmpty) {
  //     setState(() {
  //       decisions.add(newDecision);
  //       if (decisions.length >= 2) {
  //         // Update items list in the FortuneWheel widget
  //         items = List.generate(decisions.length, (index) {
  //           return FortuneItem(child: Text(decisions[index]));
  //         });
  //       } else if (decisions.length == 1) {
  //         // Add a default option if there is only one decision
  //         items = [
  //           FortuneItem(child: Text(decisions[0])),
  //           FortuneItem(child: Text("Option 1")),
  //           FortuneItem(child: Text("Option 2")),
  //         ];
  //       } else {
  //         // Add two default options if there are no decisions
  //         items = [
  //           FortuneItem(child: Text("Option 1")),
  //           FortuneItem(child: Text("Option 2")),
  //         ];
  //       }
  //       selected = 0; // Reset selected item to 0
  //     });
  //     _textEditingController.clear(); // Clear the text field
  //     _selectedController.sink.add(selected); // Update selected item in stream
  //   }
  // }

  void _addDecision() {
    String newDecision = _textEditingController.text.trim();
    if (newDecision.isNotEmpty) {
      setState(() {
        decisions.add(newDecision);
        if (decisions.length >= 2) {
          // Update items list in the FortuneWheel widget
          items = List.generate(decisions.length, (index) {
            return FortuneItem(child: Text(decisions[index]));
          });
        } else if (decisions.length == 1) {
          // Add a default option if there is only one decision
          items = [
            FortuneItem(child: Text(decisions[0])),
            FortuneItem(child: Text("Option 1")),
          ];
        } else {
          // Add two default options if there are no decisions
          items = [
            FortuneItem(child: Text("Option 1")),
            FortuneItem(child: Text("Option 2")),
          ];
        }
        selected = 0; // Reset selected item to 0
      });
      _textEditingController.clear(); // Clear the text field
      _selectedController.sink.add(selected); // Update selected item in stream
    }
  }

  void _spinWheel() {
    final random = Random();
    final newSelected = random.nextInt(items.length);
    selected = newSelected;
    _selectedController.sink.add(selected);
  }

  @override
  void dispose() {
    _selectedController.close(); // Close the stream controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fortune Wheel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textEditingController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: const InputDecoration(
                labelText: 'Enter decision',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addDecision,
              child: const Text('Add Decision'),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: FortuneWheel(
                selected: _selectedController.stream,
                onAnimationStart: () => print('Animation started'),
                onAnimationEnd: () => print('Animation ended'),
                items: items,
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _spinWheel,
              child: const Text('Spin'),
            ),
          ],
        ),
      ),
    );
  }
}
