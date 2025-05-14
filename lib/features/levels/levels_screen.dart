import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launguagelearning/core/utils/styles.dart';
import 'package:launguagelearning/data/models/levels_model.dart';
import 'package:launguagelearning/features/levels/manager/cubit/levels_cubit.dart';
import 'package:launguagelearning/features/sections/sections_Screen.dart';

class LevelsScreen extends StatelessWidget {
  const LevelsScreen({super.key});
  static const String routeName = '/levelsScreen';

  @override
  Widget build(BuildContext context) {
    // Trigger fetch when screen builds
    context.read<LevelsCubit>().fetchLevels();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Levels'),
      ),
      body: BlocBuilder<LevelsCubit, LevelsState>(
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
                  onTap: (){
 Navigator.pushNamed(
      context,
      SectionsScreen.routeName,
      arguments: level.id, // Pass levelId
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
      ),
    );
  }

  Color _getColorForIndex(int index) {
    final colors = [Colors.green, Colors.blue, Colors.orange, Colors.red];
    return colors[index % colors.length];
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
