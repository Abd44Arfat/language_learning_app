

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:launguagelearning/core/utils/styles.dart';
import 'package:launguagelearning/data/models/levels_model.dart';
import 'package:launguagelearning/features/levels/manager/cubit/levels_cubit.dart';
import 'package:launguagelearning/features/sections/sections_Screen.dart';
import 'package:speech_to_text/speech_to_text.dart';


class LevelsScreen extends StatefulWidget {
  const LevelsScreen({super.key});
  static const String routeName = '/levelsScreen';

  @override
  State<LevelsScreen> createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
  int _selectedIndex = 0;

  // Screens (levels is index 0)
  final List<Widget> _screens = [
    const LevelsBody(),     // Home
AIScreen ()  ,
SettingsScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Language Learning')),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.smart_toy),
            label: 'AI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
class LevelsBody extends StatelessWidget {
  const LevelsBody({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<LevelsCubit>().fetchLevels();

    return BlocBuilder<LevelsCubit, LevelsState>(
      builder: (context, state) {
        if (state is LevelsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LevelsFailure) {
          return Center(child: Text(state.message));
        } else if (state is LevelsSuccess) {
          final levels = state.levels;

          return ListView.builder(
            itemCount: levels.length,
            itemBuilder: (context, index) {
              final level = levels[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    SectionsScreen.routeName,
                    arguments: level.id,
                  );
                },
                child: LevelItem(
                  title: level.name,
                  icon: Icons.school,
                  background: _getColorForIndex(index),
                ),
              );
            },
          );
        } else {
          return const Center(child: Text('Please wait...'));
        }
      },
    );
  }

  Color _getColorForIndex(int index) {
    final colors = [Colors.green, Colors.blue, Colors.orange, Colors.red];
    return colors[index % colors.length];
  }
}


// class LevelsScreen extends StatelessWidget {
//   const LevelsScreen({super.key});
//   static const String routeName = '/levelsScreen';

//   @override
//   Widget build(BuildContext context) {
//     // Trigger fetch when screen builds
//     context.read<LevelsCubit>().fetchLevels();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Levels'),
//       ),
//       body: BlocBuilder<LevelsCubit, LevelsState>(
//         builder: (context, state) {
//           if (state is LevelsLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is LevelsFailure) {
//             return Center(child: Text(state.message));
//           } else if (state is LevelsSuccess) {
//             final levels = state.levels;

//             return ListView.builder(
//               itemCount: levels.length,
//               itemBuilder: (context, index) {
//                 final level = levels[index];
//                 return GestureDetector(
//                   onTap: (){
//  Navigator.pushNamed(
//       context,
//       SectionsScreen.routeName,
//       arguments: level.id, // Pass levelId
//     );


//                   },
//                   child: LevelItem(
//                     title: level.name,
//                     icon: Icons.school,
//                     background: _getColorForIndex(index),
//                   ),
//                 );
//               },
//             );
//           } else {
//             return const Center(child: Text('Please wait...'));
//           }
//         },
//       ),
//     );
//   }

//   Color _getColorForIndex(int index) {
//     final colors = [Colors.green, Colors.blue, Colors.orange, Colors.red];
//     return colors[index % colors.length];
//   }
// }

class LevelItem extends StatelessWidget {
  const LevelItem({
    super.key,
    required this.title,
    required this.icon,
    required this.background,
  });

  final String title;
  final IconData icon;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 32, color: Colors.white),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class AIScreen extends StatefulWidget {
  const AIScreen({super.key});
  static const String routeName = '/levelsScreen';

  @override
  State<AIScreen> createState() => _AIScreenState();
}

class _AIScreenState extends State<AIScreen> {
  final SpeechToText _speech = SpeechToText();
  bool _isListening = false;
  String _originalText = '';
  String _correctedText = '';

  Future<void> startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(
        onResult: (result) {
          setState(() => _originalText = result.recognizedWords);
          print("🎙️ Original: $_originalText");
        },
      );
    }
  }

  Future<void> correctGrammar(String sentence) async {
    final response = await http.post(
      Uri.parse('https://api.languagetool.org/v2/check'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'text': sentence,
        'language': 'en-US',
      },
    );

    final result = jsonDecode(response.body);
    String corrected = sentence;

    for (var match in result['matches'].reversed) {
      if (match['replacements'].isNotEmpty) {
        final replacement = match['replacements'][0]['value'];
        final offset = match['offset'];
        final length = match['length'];
        corrected = corrected.replaceRange(offset, offset + length, replacement);
      }
    }

    setState(() => _correctedText = corrected);
    print("✅ Corrected: $_correctedText");
  }

  void reset() {
    _speech.stop();
    setState(() {
      _originalText = '';
      _correctedText = '';
      _isListening = false;
    });
  }

  /// 🧪 زر للتجربة بدون تسجيل صوت
  void testSample() {
    const sampleText = "I has a apple and she go to school yesterday.";
    setState(() => _originalText = sampleText);
    correctGrammar(sampleText);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Icon(Icons.mic, size: 80, color: _isListening ? Colors.red : Colors.blue),
        const SizedBox(height: 20),
        const Text("Your Text:", style: TextStyle(fontWeight: FontWeight.bold)),
        Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(12),
          height: 100,
          width: double.infinity,
          color: Colors.blue.shade50,
          child: SingleChildScrollView(child: Text(_originalText)),
        ),
        const Text("Corrected Text:", style: TextStyle(fontWeight: FontWeight.bold)),
        Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(12),
          height: 100,
          width: double.infinity,
          color: Colors.green.shade50,
          child: SingleChildScrollView(child: Text(_correctedText)),
        ),
        const Spacer(),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          children: [
            ElevatedButton(
              onPressed: () async {
                if (_originalText.isNotEmpty) {
                  await correctGrammar(_originalText);
                }
              },
              child: const Text("Correct it"),
            ),
            ElevatedButton(
              onPressed: startListening,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade100),
              child: const Text("🎙️ Record again", style: TextStyle(color: Colors.blue)),
            ),
            ElevatedButton(
              onPressed: reset,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade100),
              child: const Text("Reset", style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: testSample,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber.shade100),
              child: const Text("🧪 Test Sample", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
        SizedBox(height: 10),
        Center(child: Text("Username: John Doe")),
        Center(child: Text("Email: john@example.com")),
        SizedBox(height: 20),
        Divider(),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text("Logout"),
        ),
      ],
    );
  }
}


