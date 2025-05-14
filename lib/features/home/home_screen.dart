import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launguagelearning/core/utils/styles.dart';
import 'package:launguagelearning/features/question/audioQuestion/audio_Question.dart';
import 'package:launguagelearning/features/question/manager/cubit/question_cubit.dart';
import 'package:launguagelearning/features/sections/manager/cubit/sections_cubit.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key, required this.sectionName, required this.sectionImage, required this.sectionId});
  static const String routeName = '/homescreen';
final String sectionName;
  final String sectionImage;
    final int sectionId;

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
     context.read<QuestionLangugeCubit>().fetchquestionsBySectionId(sectionId);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Levels'),
      ),
      body: Column(
        children: [
        Image.network(
          sectionImage,
          height: 200,
          width: 200,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
        ),
          const SizedBox(height: 20),
          Text(
        sectionName,
            style: TextStyles.font16Blackbold,
          ),
                    const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              itemCount: levelData.length,
              itemBuilder: (context, index) {
                final level = levelData[index];
                return GestureDetector(

                  child: LevelItem(
                    title: level['title'],
                    icon: level['icon'],
                    background: level['background'],
                  ),
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