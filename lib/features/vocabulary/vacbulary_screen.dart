import 'package:flutter/material.dart';

class VocabularyScreen extends StatelessWidget {
   VocabularyScreen({super.key});
  static const String routeName = '/vocab';

  // Sample data for vocabulary categories
  final List<Map<String, String>> vocabCategories = [
    {'title': 'Animals', 'image': 'assets/images/animals.jpg'},
    {'title': 'Food', 'image': 'assets/images/food.jpg'},
    {'title': 'Travel', 'image': 'assets/images/travel.jpg'},
    {'title': 'Sports', 'image': 'assets/images/sports.jpg'},
    {'title': 'Nature', 'image': 'assets/images/nature.jpg'},
    {'title': 'Technology', 'image': 'assets/images/technology.jpg'},
  ];

  // List of background colors for containers
  final List<Color> backgroundColors = [
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.purple.shade100,
    Colors.orange.shade100,
    Colors.red.shade100,
    Colors.teal.shade100,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vocabulary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items per row
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 0.75, // Adjust for image and text
          ),
          itemCount: vocabCategories.length,
          itemBuilder: (context, index) {
            final category = vocabCategories[index];
            // Cycle through colors using modulo
            final bgColor = backgroundColors[index % backgroundColors.length];
            return Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: bgColor, // Apply background color
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.asset(
                        // category['image']!, // Reverted to use category image
                        'assets/images/image 83.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.image_not_supported, size: 50),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  category['title']!,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}