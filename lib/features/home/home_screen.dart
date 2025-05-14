import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launguagelearning/core/utils/styles.dart';
import 'package:launguagelearning/features/question/audioQuestion/audio_Question.dart' as audio;
import 'package:launguagelearning/features/question/imageQuestion/imageQuestion.dart' as image;
import 'package:launguagelearning/features/question/manager/cubit/question_cubit.dart';
import 'package:launguagelearning/features/question/reading/questionscreen.dart' as reading;
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
            child: BlocBuilder<QuestionLangugeCubit, QuestionState>(
              builder: (context, state) {
                if (state is QuestionLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is QuestionFailure) {
                  return Center(child: Text(state.message));
                }
                if (state is QuestionSuccess) {
                  return ListView.builder(
                    itemCount: levelData.length,
                    itemBuilder: (context, index) {
                      final level = levelData[index];
                      return GestureDetector(
                        onTap: () {
                          if (level['title'] == 'VOCABULARY') return;
                          
                          final questions = state.questions.where((q) {
                            switch (level['title']) {
                              case 'LISTENING':
                                return q.questionType == 'audio';
                              case 'READING':
                                return q.questionType == 'text';
                              case 'MEMORY':
                                return q.questionType == 'image';
                              default:
                                return false;
                            }
                          }).toList();

                          if (questions.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('No questions available for this level'),
                              ),
                            );
                            return;
                          }

                          switch (level['title']) {
                            case 'LISTENING':
                              Navigator.pushNamed(
                                context,
                                audio.AudioQuestionScreen.routeName,
                                arguments: {'questions': questions},
                              );
                              break;
                            case 'READING':
                              Navigator.pushNamed(
                                context,
                                reading.QuestionScreen.routeName,
                                arguments: {'questions': questions},
                              );
                              break;
                            case 'MEMORY':
                              Navigator.pushNamed(
                                context,
                                image.ImageQuestionScreen.routeName,
                                arguments: {'questions': questions},
                              );
                              break;
                          }
                        },
                        child: LevelItem(
                          title: level['title'],
                          icon: level['icon'],
                          background: level['background'],
                        ),
                      );
                    },
                  );
                }
                return const SizedBox();
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