// lib/widgets/typing_text.dart
// Animated typing text widget

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/app_colors.dart';

class TypingText extends StatefulWidget {
  final List<String> texts;
  final TextStyle? style;
  final int typingSpeedMs;
  final int deletingSpeedMs;
  final int pauseMs;
  final bool showCursor;

  const TypingText({
    super.key,
    required this.texts,
    this.style,
    this.typingSpeedMs = 60,
    this.deletingSpeedMs = 30,
    this.pauseMs = 2500,
    this.showCursor = true,
  });

  @override
  State<TypingText> createState() => _TypingTextState();
}

class _TypingTextState extends State<TypingText>
    with SingleTickerProviderStateMixin {
  String _displayText = '';
  int _textIndex = 0;
  bool _isTyping = true;
  Timer? _timer;
  int _charIndex = 0;

  // For cursor blink
  late AnimationController _cursorController;
  late Animation<double> _cursorOpacity;

  @override
  void initState() {
    super.initState();
    _cursorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
    _cursorOpacity = Tween<double>(begin: 0, end: 1).animate(_cursorController);
    _startTyping();
  }

  void _startTyping() {
    _timer = Timer.periodic(
      Duration(milliseconds: widget.typingSpeedMs),
      (_) => _typeNextChar(),
    );
  }

  void _typeNextChar() {
    final currentText = widget.texts[_textIndex];

    if (_isTyping) {
      if (_charIndex < currentText.length) {
        setState(() {
          _displayText = currentText.substring(0, _charIndex + 1);
          _charIndex++;
        });
      } else {
        // Done typing — pause then delete
        _timer?.cancel();
        Future.delayed(Duration(milliseconds: widget.pauseMs), () {
          if (mounted) {
            _isTyping = false;
            _timer = Timer.periodic(
              Duration(milliseconds: widget.deletingSpeedMs),
              (_) => _deleteChar(),
            );
          }
        });
      }
    }
  }

  void _deleteChar() {
    if (_displayText.isNotEmpty) {
      setState(() {
        _displayText = _displayText.substring(0, _displayText.length - 1);
      });
    } else {
      // Move to next text
      _timer?.cancel();
      _textIndex = (_textIndex + 1) % widget.texts.length;
      _charIndex = 0;
      _isTyping = true;
      Future.delayed(const Duration(milliseconds: 400), () {
        if (mounted) _startTyping();
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _cursorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultStyle = GoogleFonts.lato(
      fontSize: 20,
      color: Colors.white.withOpacity(0.9),
      height: 1.6,
      letterSpacing: 0.3,
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            _displayText,
            style: widget.style ?? defaultStyle,
            textAlign: TextAlign.center,
          ),
        ),
        if (widget.showCursor)
          AnimatedBuilder(
            animation: _cursorOpacity,
            builder: (_, __) {
              return Opacity(
                opacity: _cursorOpacity.value,
                child: Text(
                  '|',
                  style: (widget.style ?? defaultStyle).copyWith(
                    color: AppColors.hotPink,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
