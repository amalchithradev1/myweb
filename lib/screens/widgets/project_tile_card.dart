import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Project {
  final String title;
  final String description;
  final String videoPath;
  final String playStoreLink;
  final String appStoreLink;
  final bool isWeb;

  Project({
    required this.title,
    required this.description,
    required this.videoPath,
    required this.playStoreLink,
    required this.appStoreLink,
    this.isWeb = false,
  });
}

class ProjectTile extends StatefulWidget {
  final Project project;
  final double width;
  final int index;

  const ProjectTile({
    super.key,
    required this.project,
    required this.width,
    required this.index,
  });

  @override
  State<ProjectTile> createState() => _ProjectTileState();
}

class _ProjectTileState extends State<ProjectTile> {
  late VideoPlayerController _controller;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.project.videoPath)
      ..setVolume(0)
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {});
        _controller.play(); // Auto-play looping background video
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint("Could not launch $url: $e");
    }
  }

  Widget _buildStoreButton(String text, IconData icon, String url) {
    final bool isWeb = widget.project.isWeb;
    return GestureDetector(
      onTap: () => _launchUrl(url),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isWeb ? 12 : 8,
            vertical: isWeb ? 7 : 5.5,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15), // Translucent fill
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.white.withOpacity(0.85), // Clean white border
              width: 1.2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: isWeb ? 11 : 9.5, color: Colors.white),
              SizedBox(width: isWeb ? 6 : 4),
              Text(
                text,
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: isWeb ? 10 : 8.5,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonsLayout() {
    List<Widget> buttons = [];
    if (widget.project.playStoreLink.isNotEmpty) {
      buttons.add(_buildStoreButton("Play Store", FontAwesomeIcons.googlePlay,
          widget.project.playStoreLink));
    }
    if (widget.project.appStoreLink.isNotEmpty) {
      buttons.add(_buildStoreButton(
          "App Store", FontAwesomeIcons.apple, widget.project.appStoreLink));
    }

    if (widget.project.isWeb) {
      // Horizontal row of buttons for Web horizontal overlays
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: buttons
            .map((btn) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: btn,
                ))
            .toList(),
      );
    } else {
      // Vertical stacked column for Mobile portrait overlays
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: buttons
            .map((btn) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: btn,
                ))
            .toList(),
      );
    }
  }

  Widget _buildHoverOverlay() {
    final bool isWeb = widget.project.isWeb;
    final bool isMobileOrTablet = MediaQuery.of(context).size.width < 950;
    final double targetOpacity = isMobileOrTablet ? 1.0 : (_isHovered ? 1.0 : 0.0);

    return AnimatedOpacity(
      opacity: targetOpacity,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isWeb ? 6 : 14),
        child: BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: 4, sigmaY: 4), // Gorgeous modern glass blur
          child: Container(
            color:
                Colors.black.withOpacity(0.55), // soft dark transparent cover
            padding: EdgeInsets.symmetric(
              horizontal: isWeb ? 12 : 6,
              vertical: 16,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Small category tag
                Text(
                  isWeb ? "WEB PLATFORM" : "MOBILE APP",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 6),
                // Large white bold Title
                Text(
                  widget.project.title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: isWeb ? 22 : 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 16),
                // Compact button panel
                _buildButtonsLayout(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVideoDisplay() {
    return _controller.value.isInitialized
        ? SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover, // Covering mockup screen completely
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.black12,
            ),
          );
  }

  Widget _buildMobilePhoneFrame(Widget videoChild) {
    final double frameWidth = widget.width - 10;
    final double frameHeight = frameWidth * 2.10;

    return Center(
      child: Container(
        width: frameWidth,
        height: frameHeight,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
          border: Border.all(
            color: const Color(0xFF2C2C2C), // Premium space grey border
            width: 5.5,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Video display inside screen area
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: videoChild,
              ),
            ),
            // Glassmorphic hover overlay inside bezel
            Positioned.fill(
              child: _buildHoverOverlay(),
            ),
            // Speaker Notch / Dynamic Pill
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 44,
                  height: 9,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(5)),
                  ),
                ),
              ),
            ),
            // Camera dot inside speaker pill
            Positioned(
              top: 2,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 3.5,
                  height: 3.5,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1E1E1E),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWebMonitorFrame(Widget videoChild) {
    final double frameWidth = widget.width - 10;
    final double frameHeight = frameWidth * 0.57;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Monitor Screen Bezels
          Container(
            width: frameWidth,
            height: frameHeight,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
              border: Border.all(
                color: const Color(0xFF252525), // Matte black bezel
                width: 5,
              ),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: videoChild,
                  ),
                ),
                Positioned.fill(
                  child: _buildHoverOverlay(),
                ),
              ],
            ),
          ),
          // Metallic stand stem
          Container(
            width: 26,
            height: 12,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.grey[400]!,
                  Colors.grey[300]!,
                  Colors.grey[200]!,
                  Colors.grey[400]!,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          // Matte grey stand base plate
          Container(
            width: 90,
            height: 4.5,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(2.5)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 3,
                  offset: const Offset(0, 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isWeb = widget.project.isWeb;
    final double frameWidth = widget.width - 10;
    final double computedHeight = isWeb
        ? (frameWidth * 0.57 + 16.5)
        : (frameWidth * 2.10);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            _isHovered = !_isHovered;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutQuart,
          transform: Matrix4.identity()
            ..translate(0.0, _isHovered ? -8.0 : 0.0), // Parallax lift
          width: widget.width,
          height: computedHeight,
          child: isWeb
              ? _buildWebMonitorFrame(_buildVideoDisplay())
              : _buildMobilePhoneFrame(_buildVideoDisplay()),
        ),
      ),
    );
  }
}
