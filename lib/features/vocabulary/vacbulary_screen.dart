import 'package:flutter/material.dart';
import 'package:launguagelearning/core/utils/styles.dart';

class VocabularyScreen extends StatelessWidget {
  const VocabularyScreen({super.key, required this.sectionName});
  static const String routeName = '/vocabulary';

  final String sectionName;

  // Static vocabulary data
  final List<Map<String, dynamic>> vocabularyItems = const [
    {
      'word': 'Hello',
      'translation': 'مرحبا',
      'image': 'assets/images/Duck.jpg',
      'color': Color(0xFFFFB6C1), // Light pink
    },
    {
      'word': 'Goodbye',
      'translation': 'مع السلامة',
      'image': 'assets/images/Duck.jpg',
      'color': Color(0xFF98FB98), // Pale green
    },
    {
      'word': 'Thank you',
      'translation': 'شكرا',
      'image': 'assets/images/Duck.jpg',
      'color': Color(0xFFFFD700), // Gold
    },
    {
      'word': 'Please',
      'translation': 'من فضلك',
      'image': 'assets/images/Duck.jpg',
      'color': Color(0xFF87CEEB), // Sky blue
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sectionName),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: vocabularyItems.length,
        itemBuilder: (context, index) {
          final item = vocabularyItems[index];
          return Container(
            height: 300,
            decoration: BoxDecoration(
              color: item['color'],
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      item['image'],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.image,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  item['word'],
                  style: TextStyles.font16Blackbold,
                ),
                const SizedBox(height: 8),
                Text(
                  item['translation'],
                  style: TextStyles.font15BlackMedium,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}