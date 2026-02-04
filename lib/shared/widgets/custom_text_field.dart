import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_animations.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.enableObscureToggle = false,
    this.autofocus = false,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.showCounter = false,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.validator,
    this.inputFormatters,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.textCapitalization = TextCapitalization.none,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.cursorColor,
    this.style,
    this.labelStyle,
    this.hintStyle,
    this.contentPadding,
    this.borderRadius,
    this.autofillHints,
  });

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final String? label;

  final String? hint;

  final String? helperText;

  final String? errorText;

  final IconData? prefixIcon;

  final Widget? suffixIcon;

  final VoidCallback? onSuffixTap;

  final TextInputType keyboardType;

  final TextInputAction textInputAction;

  final bool obscureText;

  final bool enableObscureToggle;

  final bool autofocus;

  final bool readOnly;

  final bool enabled;

  final int maxLines;

  final int? minLines;

  final int? maxLength;

  final bool showCounter;

  final ValueChanged<String>? onChanged;

  final ValueChanged<String>? onSubmitted;

  final VoidCallback? onTap;

  final String? Function(String?)? validator;

  final List<TextInputFormatter>? inputFormatters;

  final bool autocorrect;

  final bool enableSuggestions;

  final TextCapitalization textCapitalization;

  final Color? fillColor;

  final Color? borderColor;

  final Color? focusedBorderColor;

  final Color? cursorColor;

  final TextStyle? style;

  final TextStyle? labelStyle;

  final TextStyle? hintStyle;

  final EdgeInsetsGeometry? contentPadding;

  final BorderRadius? borderRadius;

  final Iterable<String>? autofillHints;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _focusAnimation;
  late FocusNode _focusNode;
  late TextEditingController _controller;

  bool _isFocused = false;
  bool _obscureText = false;
  String? _validationError;

  @override
  void initState() {
    super.initState();

    _obscureText = widget.obscureText;
    _focusNode = widget.focusNode ?? FocusNode();
    _controller = widget.controller ?? TextEditingController();

    _animationController = AnimationController(
      duration: AppAnimations.fastDuration,
      vsync: this,
    );

    _focusAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );

    _focusNode.addListener(_handleFocusChange);

    if (_controller.text.isNotEmpty || widget.autofocus) {
      _animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    if (widget.controller == null) {
      _controller.dispose();
    }
    _animationController.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });

    if (_isFocused || _controller.text.isNotEmpty) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }

    if (_isFocused) {
      HapticFeedback.selectionClick();
    }
  }

  void _handleTextChange(String value) {
    widget.onChanged?.call(value);

    if (_controller.text.isNotEmpty && _animationController.value == 0) {
      _animationController.forward();
    }

    // Validate on change
    if (widget.validator != null && _validationError != null) {
      setState(() {
        _validationError = widget.validator!(value);
      });
    }
  }

  void _toggleObscure() {
    HapticFeedback.lightImpact();
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _validate() {
    if (widget.validator != null) {
      setState(() {
        _validationError = widget.validator!(_controller.text);
      });
    }
  }

  bool get _hasError => widget.errorText != null || _validationError != null;
  String? get _displayError => widget.errorText ?? _validationError;
  bool get _hasText => _controller.text.isNotEmpty;

  Color get _borderColor {
    if (_hasError) return AppColors.error;
    if (_isFocused) return widget.focusedBorderColor ?? AppColors.primaryPurple;
    return widget.borderColor ?? AppColors.border;
  }

  Color get _labelColor {
    if (_hasError) return AppColors.error;
    if (_isFocused) return AppColors.primaryPurple;
    return AppColors.textTertiary;
  }

  Color get _iconColor {
    if (_hasError) return AppColors.error;
    if (_isFocused) return AppColors.primaryPurple;
    return AppColors.textTertiary;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: AppAnimations.fastDuration,
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: widget.fillColor ??
                (_isFocused
                    ? AppColors.primaryPurple.withAlpha((0.03 * 255).round())
                    : AppColors.surfaceVariant),
            borderRadius: widget.borderRadius ?? AppSpacing.borderRadiusMD,
            border: Border.all(
              color: _borderColor,
              width: _isFocused ? 2.0 : 1.0,
            ),
            boxShadow: _isFocused
                ? [
                    BoxShadow(
                      color: AppColors.primaryPurple.withAlpha((0.1 * 255).round()),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Stack(
            children: [
              // Floating Label
              if (widget.label != null)
                AnimatedBuilder(
                  animation: _focusAnimation,
                  builder: (context, child) {
                    final isFloating = _isFocused || _hasText;
                    return Positioned(
                      left: widget.prefixIcon != null ? 52 : 16,
                      top: isFloating ? 8 : 18,
                      child: AnimatedDefaultTextStyle(
                        duration: AppAnimations.fastDuration,
                        style: TextStyle(
                          color: _labelColor,
                          fontSize: isFloating ? 12 : 16,
                          fontWeight: isFloating ? FontWeight.w500 : FontWeight.w400,
                        ),
                        child: Text(widget.label!),
                      ),
                    );
                  },
                ),

              // Text Field
              TextField(
                controller: _controller,
                focusNode: _focusNode,
                keyboardType: widget.keyboardType,
                textInputAction: widget.textInputAction,
                obscureText: _obscureText,
                autofocus: widget.autofocus,
                readOnly: widget.readOnly,
                enabled: widget.enabled,
                maxLines: widget.maxLines,
                minLines: widget.minLines,
                maxLength: widget.showCounter ? widget.maxLength : null,
                onChanged: _handleTextChange,
                onSubmitted: widget.onSubmitted,
                onTap: widget.onTap,
                onEditingComplete: _validate,
                inputFormatters: widget.inputFormatters,
                autocorrect: widget.autocorrect,
                enableSuggestions: widget.enableSuggestions,
                textCapitalization: widget.textCapitalization,
                autofillHints: widget.autofillHints,
                cursorColor: widget.cursorColor ?? AppColors.primaryPurple,
                style: widget.style ??
                    AppTypography.body.copyWith(
                      color: AppColors.textPrimary,
                    ),
                decoration: InputDecoration(
                  hintText: _isFocused || _hasText ? widget.hint : null,
                  hintStyle: widget.hintStyle ??
                      AppTypography.body.copyWith(
                        color: AppColors.textTertiary,
                      ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: widget.contentPadding ??
                      EdgeInsets.fromLTRB(
                        widget.prefixIcon != null ? 52 : 16,
                        widget.label != null ? 26 : 16,
                        widget.suffixIcon != null ||
                                widget.enableObscureToggle
                            ? 52
                            : 16,
                        12,
                      ),
                  counterText: '',
                  isDense: true,
                ),
              ),

              // Prefix Icon
              if (widget.prefixIcon != null)
                Positioned(
                  left: 16,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: AnimatedContainer(
                      duration: AppAnimations.fastDuration,
                      child: Icon(
                        widget.prefixIcon,
                        color: _iconColor,
                        size: 22,
                      ),
                    ),
                  ),
                ),

              // Suffix Icon / Obscure Toggle
              Positioned(
                right: 8,
                top: 0,
                bottom: 0,
                child: Center(
                  child: _buildSuffixWidget(),
                ),
              ),
            ],
          ),
        ),

        // Helper / Error Text
        if (_displayError != null || widget.helperText != null) ...[
          AppSpacing.gapXXS,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: AnimatedSwitcher(
              duration: AppAnimations.fastDuration,
              child: Text(
                _displayError ?? widget.helperText!,
                key: ValueKey(_displayError ?? widget.helperText),
                style: AppTypography.bodyXS.copyWith(
                  color: _hasError ? AppColors.error : AppColors.textTertiary,
                ),
              ),
            ),
          ),
        ],

        // Character Counter
        if (widget.showCounter && widget.maxLength != null) ...[
          AppSpacing.gapXXS,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${_controller.text.length}/${widget.maxLength}',
                style: AppTypography.bodyXS.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSuffixWidget() {
    if (widget.enableObscureToggle && widget.obscureText) {
      return GestureDetector(
        onTap: _toggleObscure,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: AnimatedSwitcher(
            duration: AppAnimations.microDuration,
            child: Icon(
              _obscureText
                  ? Icons.visibility_off_rounded
                  : Icons.visibility_rounded,
              key: ValueKey(_obscureText),
              color: _iconColor,
              size: 22,
            ),
          ),
        ),
      );
    }

    if (widget.suffixIcon != null) {
      return GestureDetector(
        onTap: widget.onSuffixTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: widget.suffixIcon,
        ),
      );
    }

    if (_hasText && !widget.readOnly) {
      return GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          _controller.clear();
          _handleTextChange('');
          _animationController.reverse();
        },
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: AnimatedOpacity(
            duration: AppAnimations.microDuration,
            opacity: _isFocused ? 1.0 : 0.0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.textTertiary.withAlpha((0.2 * 255).round()),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close_rounded,
                size: 14,
                color: AppColors.textTertiary,
              ),
            ),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.label = 'Email Address',
    this.hint = 'Enter your email',
    this.onChanged,
    this.onSubmitted,
    this.errorText,
    this.textInputAction = TextInputAction.next,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String label;
  final String hint;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? errorText;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      focusNode: focusNode,
      label: label,
      hint: hint,
      prefixIcon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      textInputAction: textInputAction,
      autocorrect: false,
      enableSuggestions: false,
      autofillHints: const [AutofillHints.email],
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      errorText: errorText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email is required';
        }
        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
        if (!emailRegex.hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.label = 'Password',
    this.hint = 'Enter your password',
    this.onChanged,
    this.onSubmitted,
    this.errorText,
    this.textInputAction = TextInputAction.done,
    this.showStrengthIndicator = false,
    this.validator,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String label;
  final String hint;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? errorText;
  final TextInputAction textInputAction;
  final bool showStrengthIndicator;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      focusNode: focusNode,
      label: label,
      hint: hint,
      prefixIcon: Icons.lock_outline_rounded,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: textInputAction,
      obscureText: true,
      enableObscureToggle: true,
      autocorrect: false,
      enableSuggestions: false,
      autofillHints: const [AutofillHints.password],
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      errorText: errorText,
      validator: validator,
    );
  }
}

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.hint = 'Search...',
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.autofocus = false,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String hint;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      focusNode: focusNode,
      hint: hint,
      prefixIcon: Icons.search_rounded,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      autofocus: autofocus,
      autocorrect: false,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      fillColor: AppColors.surface,
      borderColor: AppColors.border,
    );
  }
}

class NameTextField extends StatelessWidget {
  const NameTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.label = 'Full Name',
    this.hint = 'Enter your name',
    this.onChanged,
    this.onSubmitted,
    this.errorText,
    this.textInputAction = TextInputAction.next,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String label;
  final String hint;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? errorText;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      focusNode: focusNode,
      label: label,
      hint: hint,
      prefixIcon: Icons.person_outline_rounded,
      keyboardType: TextInputType.name,
      textInputAction: textInputAction,
      textCapitalization: TextCapitalization.words,
      autofillHints: const [AutofillHints.name],
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      errorText: errorText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Name is required';
        }
        if (value.length < 2) {
          return 'Name is too short';
        }
        return null;
      },
    );
  }
}
