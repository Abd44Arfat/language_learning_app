import 'package:flutter/material.dart';
import 'package:launguagelearning/core/utils/styles.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});
  static const String routeName = '/homescreen';

  // Static level data
  final List<Map<String, dynamic>> levelData = const [
    {
      'title': 'VOCABULARY',
      'icon': Icons.school,
      'background': Colors.green,
    },
    {
      'title': 'LISTENING',
      'icon': Icons.star,
     'background': Colors.blue,
    },
    {
      'title': 'READING',
      'icon': Icons.star,
      'background': Colors.orange,
    },
    {
      'title': 'MEMORY',
      'icon': Icons.military_tech,
      'background': Colors.red,
    },
  
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Levels'),
      ),
      body: Column(
        children: [
          Image.asset('assets/images/image 83.png'),
          const SizedBox(height: 20),
          Text(
            'ALPHABET',
            style: TextStyles.font16Blackbold,
          ),
                    const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              itemCount: levelData.length,
              itemBuilder: (context, index) {
                final level = levelData[index];
                return LevelItem(
                  title: level['title'],
                  icon: level['icon'],
                  background: level['background'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

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