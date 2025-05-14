import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launguagelearning/core/utils/constants.dart';
import 'package:launguagelearning/features/home/home_screen.dart';
import 'package:launguagelearning/features/sections/manager/cubit/sections_cubit.dart';
import 'package:launguagelearning/data/models/sections_model.dart';
class SectionsScreen extends StatelessWidget {
  static const String routeName = '/sections';
  final int levelId;

  const SectionsScreen({super.key, required this.levelId});

  @override
  Widget build(BuildContext context) {
    context.read<SectionsCubit>().fetchSectionsByLevelId(levelId);

    return Scaffold(
      appBar: AppBar(title: const Text('Sections')),
      body: BlocBuilder<SectionsCubit, SectionsState>(
        builder: (context, state) {
          if (state is SectionsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SectionsFailure) {
            return Center(child: Text(state.message));
          } else if (state is SectionsSuccess) {
            final sections = state.sections;
            return GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.75,
              ),
              itemCount: sections.length,
              itemBuilder: (context, index) {
                final section = sections[index];
                return Column(
                  children: [
                    Expanded(
                      child: GestureDetector(
                                          onTap: (){
Navigator.pushNamed(
        context,
        Homescreen.routeName,
        arguments: {
          'section_id':section.id,
          'sectionName': section.name,
          'sectionImage': section.image?.isNotEmpty ?? false
              ? ApiUrls.imageBaseURL + section.image!
              : 'https://your_default_image_url',
              
        },
      );

                  },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                                         child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.network(
                            section.image?.isNotEmpty ?? false
                                ? ApiUrls.imageBaseURL + section.image!
                                : 'https://your_default_image_url', // Replace with a default image URL or placeholder
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image),
                          ),
                        ),
                        
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      section.name,
                      style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            );
          } else {
            return const Center(child: Text('Please wait...'));
          }
        },
      ),
    );
  }
}
