import 'package:flutter/material.dart';
import '../project_tile_card.dart';

class ProjectTabTile extends StatelessWidget {
  final Project project;
  final double width;
  final int index;

  const ProjectTabTile({
    super.key,
    required this.project,
    required this.width,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    // Delegates directly to the gorgeous Clyde glassmorphic background video tile
    return ProjectTile(
      project: project,
      width: width,
      index: index,
    );
  }
}