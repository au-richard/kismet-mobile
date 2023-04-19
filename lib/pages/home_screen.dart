// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final TextEditingController _textController = TextEditingController();
//   final List<FortuneItem> _options = [];
//   final StreamController<int> _selectedOption =
//       StreamController<int>.broadcast();
//   bool _isSpinning = false;

//   @override
//   void dispose() {
//     _textController.dispose();
//     _selectedOption.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Decision Maker Wheel'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//             child: FortuneWheel(
//               selected: _selectedOption.stream,
//               items: _options.isNotEmpty ? _options : _getDefaultOptions(),
//               // items: _getOptions(),
//               onAnimationEnd: _handleAnimationEnd,
//               animateFirst: _isSpinning,
//             ),
//           ),
//           const SizedBox(height: 16),
//           TextField(
//             controller: _textController,
//             decoration: InputDecoration(
//               hintText: 'Enter an option',
//               suffixIcon: IconButton(
//                 icon: const Icon(Icons.add),
//                 onPressed: _handleAddOption,
//               ),
//             ),
//             onSubmitted: (_) => _handleAddOption(),
//           ),
//           const SizedBox(height: 16),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               ElevatedButton(
//                 onPressed: _isSpinning ? null : _handleSpinWheel,
//                 child: const Text('Spin'),
//               ),
//               ElevatedButton(
//                 onPressed: _handleClearOptions,
//                 child: const Text('Clear Options'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // void _handleAddOption() {
//   //   final newOption = _textController.text.trim();
//   //   if (newOption.isNotEmpty) {
//   //     setState(() {
//   //       _options.add(FortuneItem(child: Text(newOption)));
//   //       _textController.clear();
//   //       _updateOptions(_options);
//   //     });
//   //   }
//   // }

//   void _handleAddOption() {
//     final newOption = _textController.text.trim();
//     if (newOption.isNotEmpty) {
//       setState(() {
//         _options.clear(); // Clear default options
//         _options.add(FortuneItem(child: Text(newOption)));
//         _options
//             .add(FortuneItem(child: Text('Option 2'))); // Add a second option
//         _textController.clear();
//       });
//     }
//   }

//   void _handleSpinWheel() {
//     setState(() {
//       _isSpinning = true;
//       _selectedOption.add(0);
//     });
//   }

//   void _handleAnimationEnd() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         int selected = -1;
//         Widget selectedOption = const Text('');
//         if (_options.isNotEmpty) {
//           final selected = Fortune.randomInt(_options.length, -1);
//           selectedOption = _options[selected].child;
//         }
//         return AlertDialog(
//           title: const Text('Selected Option'),
//           content: selectedOption,
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 setState(() {
//                   _isSpinning = false;
//                   if (_options.isNotEmpty) {
//                     _selectedOption.add(selected);
//                   }
//                 });
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _updateOptions(List<FortuneItem> newOptions) {
//     setState(() {
//       _options.clear();
//       _options.addAll(newOptions);
//     });
//   }

//   void _handleClearOptions() {
//     setState(() {
//       _options.clear();
//     });
//   }

//   // List<FortuneItem> _getDefaultOptions() {
//   //   return [
//   //     const FortuneItem(child: Text('Bob')),
//   //     const FortuneItem(child: Text('Andy')),
//   //     const FortuneItem(child: Text('Mike')),
//   //     const FortuneItem(child: Text('James')),
//   //   ];
//   // }

//   // List<FortuneItem> _getOptions() {
//   //   if (_options.isEmpty) {
//   //     return [
//   //       const FortuneItem(child: Text('Option 1')),
//   //       const FortuneItem(child: Text('Option 2')),
//   //       const FortuneItem(child: Text('Option 3')),
//   //       const FortuneItem(child: Text('Option 4')),
//   //     ];
//   //   } else {
//   //     return _options;
//   //   }
//   // }

//   List<FortuneItem> _getOptions() {
//     List<FortuneItem> options = [];

//     for (String option in _options) {
//       options.add(FortuneItem(child: Text(option)));
//     }

//     return options;
//   }
//   // List<FortuneItem> _getOptions() {
//   //   return _options;
//   // }
// }
