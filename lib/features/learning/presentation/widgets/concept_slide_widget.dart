import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'lesson_slide_header.dart';

class ConceptSlideWidget extends StatefulWidget {
  final String concept;
  final List<String> keyPoints;

  const ConceptSlideWidget({
    super.key,
    required this.concept,
    required this.keyPoints,
  });

  @override
  State<ConceptSlideWidget> createState() => _ConceptSlideWidgetState();
}

class _ConceptSlideWidgetState extends State<ConceptSlideWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
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
    final sections = _parseConcept(widget.concept);

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
                // Stunning header with gradient
                LessonSlideHeader(
                  title: 'CORE CONCEPT',
                  subtitle: 'Master the fundamentals',
                  gradientColors: [
                    AppColors.indigo.withValues(alpha: 0.12),
                    AppColors.lavender.withValues(alpha: 0.08),
                  ],
                  borderColor: AppColors.indigo.withValues(alpha: 0.25),
                  titleColor: AppColors.indigo,
                  icon: TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 700),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: 0.7 + (value * 0.3),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryPurple.withValues(
                                  alpha: 0.3,
                                ),
                                blurRadius: 12,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.lightbulb_rounded,
                            color: AppColors.white,
                            size: 28,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 28),

                // Concept content with staggered animations
                ...sections.asMap().entries.map((entry) {
                  final index = entry.key;
                  final section = entry.value;

                  return TweenAnimationBuilder<double>(
                    duration: Duration(milliseconds: 500 + (index * 120)),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 15 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: _buildConceptSection(section),
                  );
                }),

                if (widget.keyPoints.isNotEmpty) ...[
                  const SizedBox(height: 32),

                  // Key takeaways section with stunning design
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 800),
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
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.emerald.withValues(alpha: 0.08),
                            AppColors.mintGreen.withValues(alpha: 0.05),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: AppColors.emerald.withValues(alpha: 0.2),
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.emerald,
                                      AppColors.mintGreen,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.emerald.withValues(
                                        alpha: 0.3,
                                      ),
                                      blurRadius: 8,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.check_circle_rounded,
                                  color: AppColors.white,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Key Takeaways',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Animated key points with numbered badges
                          ...widget.keyPoints.asMap().entries.map((entry) {
                            final index = entry.key;
                            final point = entry.value;

                            return TweenAnimationBuilder<double>(
                              duration: Duration(
                                milliseconds: 600 + (index * 100),
                              ),
                              tween: Tween(begin: 0.0, end: 1.0),
                              builder: (context, value, child) {
                                return Opacity(
                                  opacity: value,
                                  child: Transform.translate(
                                    offset: Offset(10 * (1 - value), 0),
                                    child: child,
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Gradient number badge
                                    Container(
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.emerald,
                                            AppColors.mintGreen,
                                          ],
                                        ),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.emerald.withValues(
                                              alpha: 0.25,
                                            ),
                                            blurRadius: 6,
                                            spreadRadius: 1,
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${index + 1}',
                                          style: const TextStyle(
                                            color: AppColors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 3),
                                        child: Text(
                                          point,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            height: 1.6,
                                            color: AppColors.textPrimary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _parseConcept(String concept) {
    final sections = <Map<String, dynamic>>[];
    final lines = concept.split('\n');

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      final trimmed = line.trim();
      if (trimmed.isEmpty) continue;

      if (trimmed.startsWith('---')) {
        sections.add({'type': 'divider', 'text': ''});
        continue;
      }

      final insightMatch = RegExp(
        r'^\*\*(Key Insight|Key Lesson|Pro Tip|Note):\*\*\s*(.*)$',
        caseSensitive: false,
      ).firstMatch(trimmed);
      if (insightMatch != null) {
        final insightTitle = insightMatch.group(1)!;
        String insightText = insightMatch.group(2)!.trim();
        if (insightText.isEmpty && i + 1 < lines.length) {
          int j = i + 1;
          while (j < lines.length && lines[j].trim().isEmpty) {
            j++;
          }
          if (j < lines.length) {
            insightText = lines[j].trim();
            i = j;
          }
        }
        sections.add({
          'type': 'insight',
          'title': insightTitle.toUpperCase(),
          'text': insightText,
        });
        continue;
      }

      if (trimmed.startsWith('•') ||
          trimmed.startsWith('- ') ||
          trimmed.startsWith('·')) {
        sections.add({
          'type': 'bullet',
          'text': trimmed.replaceFirst(RegExp(r'^[•\-·\s]+'), '').trim(),
        });
        continue;
      }

      sections.add({'type': 'rich_text', 'text': trimmed});
    }

    return sections;
  }

  Widget _buildConceptSection(Map<String, dynamic> section) {
    final type = section['type'];
    final text = section['text'] as String;

    switch (type) {
      case 'divider':
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 1.5,
                  color: AppColors.border.withValues(alpha: 0.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Icon(
                  Icons.auto_awesome,
                  color: AppColors.primaryPurple.withValues(alpha: 0.4),
                  size: 18,
                ),
              ),
              Expanded(
                child: Container(
                  height: 1.5,
                  color: AppColors.border.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        );

      case 'insight':
        final title = section['title'] ?? 'KEY INSIGHT';
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.lavender.withValues(alpha: 0.2),
                AppColors.lavender.withValues(alpha: 0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.primaryPurple.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryPurple.withValues(alpha: 0.15),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.lightbulb_outline_rounded,
                  color: AppColors.primaryPurple,
                  size: 22,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.primaryPurple,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      text,
                      style: const TextStyle(
                        fontSize: 15.5,
                        height: 1.6,
                        color: AppColors.textPrimary,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

      case 'bullet':
        return Padding(
          padding: const EdgeInsets.only(bottom: 14, left: 8),
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
                ),
              ),
              const SizedBox(width: 14),
              Expanded(child: _buildRichText(text)),
            ],
          ),
        );

      case 'rich_text':
      default:
        if (text.startsWith('**') && text.contains(':**')) {
          final parts = text.split(':**');
          if (parts.length >= 2) {
            final title = parts[0].replaceAll('**', '').trim();
            final desc = parts.sublist(1).join(':**').trim();

            if (desc.isEmpty) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(top: 16, bottom: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryPurple.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.primaryPurple.withValues(alpha: 0.25),
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.primaryPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              );
            }

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.surfaceLayer1,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.border.withValues(alpha: 0.6),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryPurple.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {}, // Adds an interactive ripple effect
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 2),
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.primaryPurple.withValues(
                                alpha: 0.1,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.push_pin_rounded,
                              size: 14,
                              color: AppColors.primaryPurple,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: const TextStyle(
                                    color: AppColors.primaryPurple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                _buildRichText(desc),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildRichText(text),
        );
    }
  }

  Widget _buildRichText(String text) {
    final spans = <TextSpan>[];
    final regex = RegExp(r'\*\*(.*?)\*\*');
    int lastIndex = 0;

    for (final match in regex.allMatches(text)) {
      // Add text before the bold part
      if (match.start > lastIndex) {
        spans.add(
          TextSpan(
            text: text.substring(lastIndex, match.start),
            style: const TextStyle(
              fontSize: 15.5,
              height: 1.7,
              color: AppColors.textPrimary,
              letterSpacing: 0.2,
            ),
          ),
        );
      }

      // Add bold text with purple color
      spans.add(
        TextSpan(
          text: match.group(1),
          style: const TextStyle(
            fontSize: 16,
            height: 1.7,
            color: AppColors.primaryPurple,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.3,
          ),
        ),
      );

      lastIndex = match.end;
    }

    // Add remaining text
    if (lastIndex < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(lastIndex),
          style: const TextStyle(
            fontSize: 15.5,
            height: 1.7,
            color: AppColors.textPrimary,
            letterSpacing: 0.2,
          ),
        ),
      );
    }

    return RichText(text: TextSpan(children: spans));
  }
}
