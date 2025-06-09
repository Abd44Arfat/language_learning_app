import 'package:flutter/material.dart';

class VocabularyScreen extends StatelessWidget {
  const VocabularyScreen({super.key, required this.sectionName});
  static const String routeName = '/vocabulary';

  final String sectionName;

  final List<Map<String, dynamic>> vocabularyItems = const [
    {
      'word': 'Lion',
      'image': 'https://static.vecteezy.com/system/resources/previews/027/695/949/non_2x/lion-symbol-cute-lion-cartoon-vector.jpg',
    },
    {
      'word': 'Giraffe',
      'image': 'https://img.freepik.com/free-vector/hand-drawn-cartoon-giraffe-illustration_23-2150368576.jpg?semt=ais_items_boosted&w=740',
    },
    {
      'word': 'Duck',
      'image': 'https://i.pinimg.com/736x/ff/91/58/ff91583814612053bc1b76b0c65a6b57.jpg',
    },
    {
      'word': 'Monkey',
      'image': 'https://www.shutterstock.com/image-vector/young-cute-monkey-baby-sweet-600nw-2270033121.jpg',
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
          childAspectRatio: 0.7,
        ),
        itemCount: vocabularyItems.length,
        itemBuilder: (context, index) {
          final section = vocabularyItems[index];
          return GestureDetector(
            onTap: () {
              // Handle tap
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Image container taking most of the space
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        child: Image.network(
                          section['image'],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Icon(
                            Icons.image,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Word container at the bottom
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(20),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          section['word'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}