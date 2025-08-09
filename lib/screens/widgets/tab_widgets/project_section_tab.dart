import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../project_tile_card.dart';

class ProjectTabTile extends StatefulWidget {
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
  State<ProjectTabTile> createState() => _ProjectTabTileState();
}

class _ProjectTabTileState extends State<ProjectTabTile> {

  final List<Color> lightColors = [
    Color(0xFFFFF3E0), // Light Orange
    Color(0xFFE1F5FE), // Light Blue
    Color(0xFFE8F5E9), // Light Green
    Color(0xFFFFEBEE), // Light Pink
    Color(0xFFF3E5F5), // Light Purple
    Color(0xFFFFF9C4), // Light Yellow
    Color(0xFFD7CCC8), // Light Brown/Grey
    Color(0xFFF1F8E9), // Green Tint
    Color(0xFFE0F7FA), // Cyan Tint
  ];


  late VideoPlayerController _controller;
  bool _isHovered = false;

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

  void _handleHover(bool hovering) {
    setState(() => _isHovered = hovering);
    if (_controller.value.isInitialized) {
      hovering ? _controller.play() : _controller.pause();
    }
  }

  Widget _buildFrame() {
    final bool isWeb = widget.project.isWeb;
    final double frameWidth = isWeb ? 294 : 110;
    final double frameHeight = isWeb ? 167 : 234 ;

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
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildDeviceFrameWrapper({required Widget child}) {
    final bool isWeb = widget.project.isWeb;
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          widget.project.isWeb
              ? 'assets/images/desktop_frame.png'
              : 'assets/images/iphone_frame.png',
          width: widget.project.isWeb ? 420: 500  ,
        ),
        Positioned(
            top: isWeb ? 30 : 13,
            child: child),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 500,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: 500,
                height: 300,
                decoration: BoxDecoration(
                  // color: Colors.yellow,
                  color: lightColors[widget.index % lightColors.length],
                  borderRadius: BorderRadius.circular(12),

                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _buildDeviceFrameWrapper(child: _buildFrame()),
                )),
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
            const SizedBox(height: 12),
            if (widget.project.link.isNotEmpty)
              GestureDetector(
                onTap: () => _launchPlayStore(widget.project.link),
                child: Text(
                  "View in Play Store →",
                  style: GoogleFonts.b612(
                    color: Colors.blueAccent,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}