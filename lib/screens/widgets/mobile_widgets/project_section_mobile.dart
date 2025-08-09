import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart'; // 👈 Added

import '../project_tile_card.dart';

class ProjectMobileTile extends StatefulWidget {
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
  State<ProjectMobileTile> createState() => _ProjectMobileTileState();
}

class _ProjectMobileTileState extends State<ProjectMobileTile> {
  final List<Color> lightColors = [
    const Color(0xFFFFF3E0), // Light Orange
    const Color(0xFFE1F5FE), // Light Blue
    const Color(0xFFE8F5E9), // Light Green
    const Color(0xFFFFEBEE), // Light Pink
    const Color(0xFFF3E5F5), // Light Purple
    const Color(0xFFFFF9C4), // Light Yellow
    const Color(0xFFD7CCC8), // Light Brown/Grey
    const Color(0xFFF1F8E9), // Green Tint
    const Color(0xFFE0F7FA), // Cyan Tint
  ];

  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.project.videoPath)
      ..setVolume(0)
      ..setLooping(true)
      ..initialize().then((_) => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _launchPlayStore(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    // Play if more than 50% visible
    if (info.visibleFraction > 0.5) {
      if (!_controller.value.isPlaying) _controller.play();
    } else {
      if (_controller.value.isPlaying) _controller.pause();
    }
  }

  Widget _buildFrame() {
    final bool isWeb = widget.project.isWeb;
    final double frameWidth = isWeb
        ? MediaQuery.of(context).size.width * 0.6
        : MediaQuery.of(context).size.width * 0.25;
    final double frameHeight = isWeb
        ? MediaQuery.of(context).size.width * 0.4
        : MediaQuery.of(context).size.width * 0.53;

    return Container(
      height: frameHeight,
      width: frameWidth,
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isWeb ? 0 : 11),
        child: _controller.value.isInitialized
            ? SizedBox(
          width: frameWidth,
          height: frameHeight,
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _controller.value.size.width,
              height: _controller.value.size.height,
              child: Opacity(
                opacity: 0.95,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
        )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildDeviceFrameWrapper({required Widget child}) {
    return child;
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('project_tile_${widget.index}'),
      onVisibilityChanged: _onVisibilityChanged,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: double.infinity,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 300,
              decoration: BoxDecoration(
                color: lightColors[widget.index % lightColors.length],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: _buildDeviceFrameWrapper(child: _buildFrame()),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.project.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.b612(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.project.description,
              textAlign: TextAlign.center,
              style: GoogleFonts.b612(
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            if (widget.project.link.isNotEmpty)
              GestureDetector(
                onTap: () => _launchPlayStore(widget.project.link),
                child: Text(
                  "View in Play Store →",
                  style: GoogleFonts.b612(
                    color: Colors.blueAccent,
                    fontSize: 11,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
