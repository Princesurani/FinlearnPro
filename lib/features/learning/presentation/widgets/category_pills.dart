import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_animations.dart';
import '../../data/learning_models.dart';

class CategoryPills extends StatefulWidget {
  const CategoryPills({
    super.key,
    required this.categories,
    this.selectedId,
    this.onSelected,
  });

  final List<LearningCategory> categories;

  final String? selectedId;

  final ValueChanged<String?>? onSelected;

  @override
  State<CategoryPills> createState() => _CategoryPillsState();
}

class _CategoryPillsState extends State<CategoryPills> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Explore Topics',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              if (widget.selectedId != null)
                GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    widget.onSelected?.call(null);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryPurple.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.close_rounded,
                          size: 16,
                          color: AppColors.primaryPurple,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Clear',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryPurple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        SizedBox(
          height: 110,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: widget.categories.length,
            itemBuilder: (context, index) {
              final category = widget.categories[index];
              final isSelected = category.id == widget.selectedId;

              return Padding(
                padding: EdgeInsets.only(
                  right: index < widget.categories.length - 1 ? 12 : 0,
                ),
                child: _CategoryPillItem(
                  category: category,
                  isSelected: isSelected,
                  onTap: () {
                    HapticFeedback.selectionClick();
                    widget.onSelected?.call(
                      isSelected ? null : category.id,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CategoryPillItem extends StatefulWidget {
  const _CategoryPillItem({
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  final LearningCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<_CategoryPillItem> createState() => _CategoryPillItemState();
}

class _CategoryPillItemState extends State<_CategoryPillItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppAnimations.fastDuration,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: AppAnimations.pressedScale,
    ).animate(
      CurvedAnimation(parent: _controller, curve: AppAnimations.defaultCurve),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap();
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final category = widget.category;
    final isSelected = widget.isSelected;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: AnimatedContainer(
          duration: AppAnimations.mediumDuration,
          curve: AppAnimations.defaultCurve,
          width: 85,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? category.color : AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected
                  ? category.color
                  : category.color.withValues(alpha: 0.2),
              width: isSelected ? 2 : 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: isSelected
                    ? category.color.withValues(alpha: 0.35)
                    : Colors.black.withValues(alpha: 0.06),
                blurRadius: isSelected ? 16 : 10,
                offset: const Offset(0, 4),
                spreadRadius: isSelected ? 2 : 0,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: AppAnimations.fastDuration,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.25)
                      : category.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  category.icon,
                  size: 18,
                  color: isSelected ? Colors.white : category.color,
                ),
              ),
              const SizedBox(height: 4),

              Text(
                category.name.split(' ').first,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
