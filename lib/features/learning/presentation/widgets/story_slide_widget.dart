import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'lesson_slide_header.dart';

class StorySlideWidget extends StatefulWidget {
  final String story;
  final String character;

  const StorySlideWidget({
    super.key,
    required this.story,
    required this.character,
  });

  @override
  State<StorySlideWidget> createState() => _StorySlideWidgetState();
}

class _StorySlideWidgetState extends State<StorySlideWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Parse story sections (split by bold markers or line breaks)
    final sections = _parseStory(widget.story);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Immersive header with character
                LessonSlideHeader(
                  title: 'Real-World Story',
                  subtitle: 'Learn from real experiences',
                  gradientColors: [
                    AppColors.primaryPurple.withValues(alpha: 0.25), // Darker
                    AppColors.electricBlue.withValues(alpha: 0.20), // Darker
                  ],
                  borderColor: AppColors.primaryPurple.withValues(
                    alpha: 0.4,
                  ), // Darker border
                  titleColor: AppColors.primaryPurple,
                  icon: TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 600),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: 0.8 + (value * 0.2),
                        child: Text(
                          widget.character,
                          style: const TextStyle(
                            fontSize: 32,
                          ), // Reduced from 56
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 28),

                // Story content with visual hierarchy
                ...sections.asMap().entries.map((entry) {
                  final index = entry.key;
                  final section = entry.value;

                  return TweenAnimationBuilder<double>(
                    duration: Duration(milliseconds: 400 + (index * 100)),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: _buildStorySection(section, index),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _parseStory(String story) {
    final sections = <Map<String, dynamic>>[];
    final lines = story.split('\n');

    for (final line in lines) {
      if (line.trim().isEmpty) continue;

      // Check if it's a bold section (starts with **)
      if (line.trim().startsWith('**') && line.trim().endsWith('**')) {
        sections.add({
          'type': 'heading',
          'text': line.trim().replaceAll('**', ''),
        });
      } else if (line.trim().startsWith('•') || line.trim().startsWith('-')) {
        sections.add({
          'type': 'bullet',
          'text': line.trim().substring(1).trim(),
        });
      } else {
        sections.add({'type': 'paragraph', 'text': line.trim()});
      }
    }

    return sections;
  }

  Widget _buildStorySection(Map<String, dynamic> section, int index) {
    final type = section['type'];
    final text = section['text'];

    switch (type) {
      case 'heading':
        return Padding(
          padding: EdgeInsets.only(bottom: 16, top: index == 0 ? 0 : 20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.sunsetOrange.withValues(alpha: 0.12),
                  AppColors.sunsetOrange.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border(
                left: BorderSide(color: AppColors.sunsetOrange, width: 3),
              ),
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
                height: 1.4,
              ),
            ),
          ),
        );

      case 'bullet':
        return Padding(
          padding: const EdgeInsets.only(bottom: 12, left: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryPurple.withValues(alpha: 0.3),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildFormattedText(
                  text,
                  const TextStyle(
                    fontSize: 15,
                    height: 1.6,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        );

      case 'paragraph':
      default:
        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: _buildFormattedText(
            text,
            const TextStyle(
              fontSize: 15.5,
              height: 1.7,
              color: AppColors.textPrimary,
              letterSpacing: 0.2,
            ),
          ),
        );
    }
  }

  Widget _buildFormattedText(String text, TextStyle baseStyle) {
    if (!text.contains('**')) {
      return Text(text, style: baseStyle);
    }

    final spans = <InlineSpan>[];
    final pattern = RegExp(r'\*\*(.*?)\*\*');

    int lastMatchEnd = 0;

    for (final match in pattern.allMatches(text)) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(text: text.substring(lastMatchEnd, match.start)));
      }
      spans.add(
        TextSpan(
          text: match.group(1),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );
      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastMatchEnd)));
    }

    return Text.rich(TextSpan(style: baseStyle, children: spans));
  }
}
