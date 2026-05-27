import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
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
  final String thumbnailPath;

  Project({
    required this.title,
    required this.description,
    required this.videoPath,
    required this.playStoreLink,
    required this.appStoreLink,
    this.isWeb = false,
    this.thumbnailPath = '',
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
  bool _isHovered = false;

  void _showProjectDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.75), // Gorgeous dim overlay
      barrierDismissible: true,
      builder: (BuildContext context) {
        return _ProjectDetailsModal(project: widget.project);
      },
    );
  }

  Widget _buildHoverOverlay() {
    final bool isWeb = widget.project.isWeb;
    final bool isMobileOrTablet = MediaQuery.of(context).size.width < 950;

    if (isMobileOrTablet) {
      // Clean, premium floating button without any overlay shade or text blocking the screenshot!
      return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.78), // Obsidian glassmorphic capsule
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.35),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
              border: Border.all(
                color: Colors.white.withOpacity(0.18),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.visibility_rounded, size: 11, color: Colors.white),
                const SizedBox(width: 5),
                Text(
                  "View Details",
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Desktop hover configuration
    final double targetOpacity = _isHovered ? 1.0 : 0.0;
    return AnimatedOpacity(
      opacity: targetOpacity,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isWeb ? 5 : 10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4), // Gorgeous modern glass blur
          child: Container(
            color: Colors.black.withOpacity(0.55), // soft dark transparent cover
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
                    fontSize: isWeb ? 18 : 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 12),
                
                // Compact elegant "View Details" button
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.visibility_rounded, size: 12, color: Colors.black),
                      const SizedBox(width: 6),
                      Text(
                        "View Details",
                        style: GoogleFonts.outfit(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStaticDisplay() {
    final bool isWeb = widget.project.isWeb;

    // 1. If a screenshot/thumbnail path is set, show the image asset!
    if (widget.project.thumbnailPath.isNotEmpty) {
      return Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              widget.project.thumbnailPath,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter, // Always align app screenshots to the top (perfect navigation bar showcasing)
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.12), // clean dynamic dimming overlay
            ),
          ),
          Center(
            child: Container(
              width: isWeb ? 42 : 34,
              height: isWeb ? 42 : 34,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.55),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white30,
                  width: 1.2,
                ),
              ),
              child: Icon(
                Icons.play_arrow_rounded,
                color: Colors.white.withOpacity(0.9),
                size: isWeb ? 24 : 20,
              ),
            ),
          ),
        ],
      );
    }

    // 2. Otherwise, dynamically render an elegant, customized branding card fallback!
    final String firstLetter = widget.project.title.isNotEmpty 
        ? widget.project.title.substring(0, 1).toUpperCase() 
        : 'A';

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF16161D),
            const Color(0xFF060608),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: -10,
            bottom: -10,
            child: Icon(
              isWeb ? Icons.computer_rounded : Icons.phone_android_rounded,
              size: isWeb ? 90 : 70,
              color: Colors.white.withOpacity(0.015),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: isWeb ? 54 : 46,
                  height: isWeb ? 54 : 46,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.04),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.12),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      firstLetter,
                      style: GoogleFonts.outfit(
                        fontSize: isWeb ? 22 : 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.85),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "TAP TO PREVIEW",
                  style: GoogleFonts.outfit(
                    fontSize: 7.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white24,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobilePhoneFrame(Widget screenChild) {
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
            // Screen display
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: screenChild,
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
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(5)),
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

  Widget _buildWebMonitorFrame(Widget screenChild) {
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
                    child: screenChild,
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
              borderRadius: const BorderRadius.vertical(top: Radius.circular(2.5)),
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
        onTap: () => _showProjectDetailsDialog(context),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutQuart,
          transform: Matrix4.identity()
            ..translate(0.0, _isHovered ? -8.0 : 0.0), // Parallax lift
          width: widget.width,
          height: computedHeight,
          child: isWeb
              ? _buildWebMonitorFrame(_buildStaticDisplay())
              : _buildMobilePhoneFrame(_buildStaticDisplay()),
        ),
      ),
    );
  }
}

// =========================================================================
// PREMIUM RESPONSIVE VIDEO POPUP MODAL DIALOG
// =========================================================================

class _ProjectDetailsModal extends StatefulWidget {
  final Project project;

  const _ProjectDetailsModal({required this.project});

  @override
  State<_ProjectDetailsModal> createState() => _ProjectDetailsModalState();
}

class _ProjectDetailsModalState extends State<_ProjectDetailsModal> {
  late VideoPlayerController _controller;
  bool _isVideo = true;
  bool _isControllerInitialized = false;

  @override
  void initState() {
    super.initState();
    final String path = widget.project.videoPath.toLowerCase();
    _isVideo = path.endsWith('.mp4') || path.endsWith('.mov') || path.endsWith('.avi');

    if (_isVideo) {
      final String videoPath = widget.project.videoPath;
      
      // Dynamic Web Production path resolver
      Uri videoUri;
      if (kIsWeb) {
        final String basePath = Uri.base.toString();
        final int queryIdx = basePath.indexOf('?');
        final int hashIdx = basePath.indexOf('#');
        int endIdx = basePath.length;
        if (queryIdx != -1) endIdx = queryIdx;
        if (hashIdx != -1 && hashIdx < endIdx) endIdx = hashIdx;
        
        String cleanBase = basePath.substring(0, endIdx);
        if (cleanBase.endsWith('index.html')) {
          cleanBase = cleanBase.substring(0, cleanBase.length - 10);
        }
        if (!cleanBase.endsWith('/')) {
          cleanBase = '$cleanBase/';
        }
        
        final String relativeAsset = videoPath.startsWith('assets/') 
            ? videoPath.substring(7) 
            : videoPath;
        
        final String absoluteUrl = '${cleanBase}assets/assets/$relativeAsset';
        videoUri = Uri.parse(absoluteUrl);
      } else {
        videoUri = Uri.parse(videoPath);
      }

      _controller = kIsWeb 
          ? VideoPlayerController.networkUrl(videoUri)
          : VideoPlayerController.asset(videoPath)
        ..setVolume(0)
        ..setLooping(true)
        ..initialize().then((_) {
          if (mounted) {
            setState(() {
              _isControllerInitialized = true;
            });
            _controller.play(); // Auto-play loops
          }
        }).catchError((e) {
          debugPrint("Modal video initialization failed: $e");
        });
    }
  }

  @override
  void dispose() {
    if (_isVideo) {
      _controller.dispose();
    }
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
    return GestureDetector(
      onTap: () => _launchUrl(url),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.white30,
              width: 1.2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                text,
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 12,
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
      buttons.add(_buildStoreButton("Google Play", FontAwesomeIcons.googlePlay, widget.project.playStoreLink));
    }
    if (widget.project.appStoreLink.isNotEmpty) {
      buttons.add(_buildStoreButton("App Store", FontAwesomeIcons.apple, widget.project.appStoreLink));
    }

    return Wrap(
      spacing: 12,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: buttons,
    );
  }

  Widget _buildVideoDisplay() {
    if (!_isVideo) {
      return SizedBox.expand(
        child: Image.asset(
          widget.project.videoPath,
          fit: BoxFit.cover,
        ),
      );
    }

    return _isControllerInitialized
        ? SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
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
              color: Colors.white24,
            ),
          );
  }

  Widget _buildMobilePhoneFrame(double width) {
    final double frameWidth = width - 10;
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
              color: Colors.black.withOpacity(0.5),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(
            color: const Color(0xFF2C2C2C),
            width: 5.5,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: _buildVideoDisplay(),
              ),
            ),
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
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(5)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWebMonitorFrame(double width) {
    final double frameWidth = width - 10;
    final double frameHeight = frameWidth * 0.57;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: frameWidth,
            height: frameHeight,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
              border: Border.all(
                color: const Color(0xFF252525),
                width: 5,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: _buildVideoDisplay(),
            ),
          ),
          Container(
            width: 26,
            height: 12,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.grey[800]!,
                  Colors.grey[700]!,
                  Colors.grey[600]!,
                  Colors.grey[800]!,
                ],
              ),
            ),
          ),
          Container(
            width: 90,
            height: 4.5,
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(2.5)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isDesktop = size.width > 900;
    final bool isWeb = widget.project.isWeb;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(isDesktop ? 24 : 16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12), // Premium glass background blur
        child: Container(
          width: isDesktop ? 860 : double.infinity,
          height: isDesktop ? 520 : size.height * 0.85,
          decoration: BoxDecoration(
            color: const Color(0xEC0E0E12), // Obsidian deep semi-transparent black
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: Colors.white.withOpacity(0.12), // clean crisp obsidian border
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Premium Close Button in Top Right
              Positioned(
                top: 16,
                right: 16,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Colors.white70,
                    size: 24,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.06),
                    hoverColor: Colors.white.withOpacity(0.15),
                  ),
                ),
              ),
              
              // Main Responsive Layout
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: isDesktop
                    ? Row(
                        children: [
                          // Left side: Large Mockup Frame
                          SizedBox(
                            width: 320,
                            child: Center(
                              child: isWeb
                                  ? _buildWebMonitorFrame(320)
                                  : _buildMobilePhoneFrame(175),
                            ),
                          ),
                          const SizedBox(width: 32),
                          // Right side: App details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center, // Perfect vertical centering next to the mockup frame!
                              children: [
                                // Category pill
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.06),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.white12, width: 1),
                                  ),
                                  child: Text(
                                    isWeb ? "WEB & CLOUD PLATFORM" : "MOBILE APPLICATION",
                                    style: GoogleFonts.outfit(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white60,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                // Title
                                Text(
                                  widget.project.title,
                                  style: GoogleFonts.outfit(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Divider(color: Colors.white12, height: 20),
                                const SizedBox(height: 8),
                                // Detailed Description (Flexible to allow vertical centering when text is short)
                                Flexible(
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Text(
                                      widget.project.description,
                                      style: GoogleFonts.outfit(
                                        fontSize: 14.5,
                                        height: 1.6,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white.withOpacity(0.75),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                // Action Buttons
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: _buildButtonsLayout(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12),
                            // Top side: Large Unsqueezed Mockup Screen
                            Center(
                              child: isWeb
                                  ? _buildWebMonitorFrame(MediaQuery.of(context).size.width * 0.68)
                                  : _buildMobilePhoneFrame(190), // Magnificently tall 399px fixed height!
                            ),
                            const SizedBox(height: 24),
                            // Bottom side: Description scroll panel
                            Text(
                              isWeb ? "WEB & CLOUD PLATFORM" : "MOBILE APPLICATION",
                              style: GoogleFonts.outfit(
                                fontSize: 9.5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white38,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 6),
                            // Title
                            Text(
                              widget.project.title,
                              style: GoogleFonts.outfit(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Divider(color: Colors.white12, height: 12),
                            const SizedBox(height: 8),
                            // Description text (Scrolls naturally with parent sheet)
                            Text(
                              widget.project.description,
                              style: GoogleFonts.outfit(
                                fontSize: 13.5,
                                height: 1.6,
                                fontWeight: FontWeight.w300,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Action Buttons
                            Center(child: _buildButtonsLayout()),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
