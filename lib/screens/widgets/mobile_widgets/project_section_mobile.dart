import 'package:flutter/material.dart';
import '../project_tile_card.dart';

class ProjectMobileTile extends StatelessWidget {
  final Project project;
  final double width;
  final int index;

  const ProjectMobileTile({
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
