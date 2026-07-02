// lib/screens/quiz/quiz_screen.dart
// Premium Love Quiz with glass cards, shake animation, and confetti

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../models/quiz_model.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/section_title.dart';

class QuizSection extends StatefulWidget {
  const QuizSection({super.key});

  @override
  State<QuizSection> createState() => _QuizSectionState();
}

class _QuizSectionState extends State<QuizSection>
    with SingleTickerProviderStateMixin {
  int _currentQuestion = 0;
  int? _selectedAnswer;
  bool _answered = false;
  bool _isCorrect = false;
  int _score = 0;
  bool _quizComplete = false;

  // Shake for wrong answer
  late AnimationController _shakeController;
  late Animation<double> _shakeAnim;

  // Confetti for correct answers
  late ConfettiController _confettiController;

  // Pop-up state
  bool _showPopup = false;
  String _popupMessage = '';
  bool _popupIsCorrect = false;

  @override
  void initState() {
    super.initState();

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _shakeAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -10), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -10, end: 10), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 10, end: -6), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -6, end: 6), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 6, end: 0), weight: 1),
    ]).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.easeInOut),
    );

    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _handleAnswer(int optionIndex) {
    if (_answered) return;

    final question = QuizData.questions[_currentQuestion];
    final correct = question.isCorrect(optionIndex);

    setState(() {
      _selectedAnswer = optionIndex;
      _answered = true;
      _isCorrect = correct;
      _showPopup = true;
      _popupIsCorrect = correct;
      _popupMessage = correct
          ? AppStrings.quizCorrectMessage
          : AppStrings.quizWrongMessage;

      if (correct) _score++;
    });

    if (correct) {
      _confettiController.play();
    } else {
      _shakeController.forward(from: 0);
    }

    // Auto-hide popup and move to next
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _showPopup = false);
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) _nextQuestion();
        });
      }
    });
  }

  void _nextQuestion() {
    if (_currentQuestion < QuizData.questions.length - 1) {
      setState(() {
        _currentQuestion++;
        _selectedAnswer = null;
        _answered = false;
        _isCorrect = false;
      });
    } else {
      setState(() => _quizComplete = true);
    }
  }

  void _resetQuiz() {
    setState(() {
      _currentQuestion = 0;
      _selectedAnswer = null;
      _answered = false;
      _isCorrect = false;
      _score = 0;
      _quizComplete = false;
      _showPopup = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 700;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 60 : 20,
        vertical: 60,
      ),
      child: Stack(
        children: [
          // Confetti
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              colors: const [
                AppColors.hotPink,
                AppColors.softPink,
                AppColors.roseGold,
                Colors.white,
                AppColors.lilac,
              ],
              numberOfParticles: 30,
              maxBlastForce: 15,
              minBlastForce: 5,
            ),
          ),

          Column(
            children: [
              const SectionTitle(
                title: 'Love Quiz',
                subtitle: 'How well do you know your hubby? 💕',
                emoji: '💝',
              ),

              const Gap(40),

              if (!_quizComplete) ...[
                _buildProgressBar(),
                const Gap(24),
                _buildQuestionCard(isWide),
              ] else
                _buildResultCard(isWide),
            ],
          ),

          // Answer Popup
          if (_showPopup) _buildAnswerPopup(),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    final progress = (_currentQuestion + 1) / QuizData.questions.length;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Question ${_currentQuestion + 1} of ${QuizData.questions.length}',
              style: GoogleFonts.lato(
                fontSize: 14,
                color: AppColors.softPink.withOpacity(0.8),
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                const Text('⭐', style: TextStyle(fontSize: 16)),
                const Gap(4),
                Text(
                  'Score: $_score',
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    color: AppColors.roseGold,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),

        const Gap(10),

        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.glassWhite,
            valueColor: const AlwaysStoppedAnimation(AppColors.hotPink),
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionCard(bool isWide) {
    final question = QuizData.questions[_currentQuestion];

    return AnimatedBuilder(
      animation: _shakeAnim,
      builder: (_, child) {
        return Transform.translate(
          offset: Offset(_shakeAnim.value, 0),
          child: child,
        );
      },
      child: GlassCard(
        padding: const EdgeInsets.all(32),
        borderRadius: 28,
        borderColor: AppColors.hotPink.withOpacity(0.3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question text
            Text(
              question.question,
              style: GoogleFonts.dancingScript(
                fontSize: isWide ? 28 : 22,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                height: 1.4,
              ),
            ),

            const Gap(28),

            // Options
            ...question.options.asMap().entries.map((entry) {
              return _buildOption(
                index: entry.key,
                option: entry.value,
                question: question,
              );
            }),
          ],
        ),
      )
          .animate(key: ValueKey(_currentQuestion))
          .fadeIn(duration: 400.ms)
          .slideX(begin: 0.2, curve: Curves.easeOut),
    );
  }

  Widget _buildOption({
    required int index,
    required QuizOption option,
    required QuizQuestion question,
  }) {
    Color? bgColor;
    Color? borderColor;
    Color? textColor = Colors.white;

    if (_answered && _selectedAnswer == index) {
      if (_isCorrect || question.isCorrect(index)) {
        bgColor = Colors.green.withOpacity(0.2);
        borderColor = Colors.green;
      } else {
        bgColor = AppColors.crimson.withOpacity(0.2);
        borderColor = AppColors.crimson;
        textColor = Colors.redAccent;
      }
    } else if (_answered && question.isCorrect(index)) {
      bgColor = Colors.green.withOpacity(0.15);
      borderColor = Colors.green.withOpacity(0.5);
    }

    return GestureDetector(
      onTap: () => _handleAnswer(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: bgColor ?? AppColors.glassWhite,
          border: Border.all(
            color: borderColor ?? AppColors.glassBorder,
            width: bgColor != null ? 1.5 : 1,
          ),
          boxShadow: bgColor != null
              ? [
                  BoxShadow(
                    color: (borderColor ?? Colors.transparent).withOpacity(0.3),
                    blurRadius: 12,
                    spreadRadius: 2,
                  )
                ]
              : null,
        ),
        child: Row(
          children: [
            // Option letter
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (borderColor ?? AppColors.hotPink).withOpacity(0.2),
                border: Border.all(
                  color: borderColor ?? AppColors.hotPink.withOpacity(0.4),
                ),
              ),
              child: Text(
                String.fromCharCode(65 + index), // A, B, C, D
                style: GoogleFonts.lato(
                  fontSize: 13,
                  color: borderColor ?? AppColors.softPink,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            const Gap(14),

            if (option.emoji != null) ...[
              Text(option.emoji!, style: const TextStyle(fontSize: 18)),
              const Gap(8),
            ],

            Expanded(
              child: Text(
                option.text,
                style: GoogleFonts.lato(
                  fontSize: 16,
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            // Correct / wrong icon
            if (_answered && _selectedAnswer == index)
              Icon(
                _isCorrect
                    ? Icons.check_circle_rounded
                    : Icons.cancel_rounded,
                color: _isCorrect ? Colors.green : Colors.redAccent,
                size: 22,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerPopup() {
    return Positioned(
      top: 100,
      left: 0,
      right: 0,
      child: Center(
        child: GlassCard(
          width: 300,
          padding: const EdgeInsets.all(24),
          borderRadius: 24,
          borderColor: (_popupIsCorrect ? Colors.green : AppColors.crimson)
              .withOpacity(0.5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _popupIsCorrect ? '❤️' : '💔',
                style: const TextStyle(fontSize: 48),
              )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .scale(
                    begin: const Offset(1, 1),
                    end: const Offset(1.2, 1.2),
                    duration: 400.ms,
                  ),
              const Gap(12),
              Text(
                _popupMessage,
                style: GoogleFonts.dancingScript(
                  fontSize: 22,
                  color: _popupIsCorrect
                      ? AppColors.softPink
                      : Colors.redAccent.shade100,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ).animate().scale(
              begin: const Offset(0.5, 0.5),
              duration: 300.ms,
              curve: Curves.elasticOut,
            ),
      ),
    );
  }

  Widget _buildResultCard(bool isWide) {
    final percentage = (_score / QuizData.questions.length * 100).round();
    final message = percentage == 100
        ? 'Perfect Score! You know me so well! 😍❤️'
        : percentage >= 75
            ? 'Masha Allah! You know me so well! 🥰'
            : percentage >= 50
                ? 'Good! But study more about hubby! 😄'
                : 'Wifeu... Dobara Socho! 🥺❤️';

    return GlowCard(
      glowColor: AppColors.hotPink,
      borderRadius: 28,
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Text('🎉', style: const TextStyle(fontSize: 60))
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scale(
                begin: const Offset(1, 1),
                end: const Offset(1.2, 1.2),
                duration: 600.ms,
              ),

          const Gap(16),

          Text(
            'Quiz Complete!',
            style: GoogleFonts.greatVibes(
              fontSize: 48,
              color: AppColors.softPink,
            ),
          ),

          const Gap(12),

          Text(
            'You scored $_score out of ${QuizData.questions.length}',
            style: GoogleFonts.dancingScript(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),

          const Gap(8),

          Text(
            '$percentage% ❤️',
            style: GoogleFonts.lato(
              fontSize: 52,
              color: AppColors.hotPink,
              fontWeight: FontWeight.w700,
              shadows: [
                Shadow(
                  color: AppColors.hotPink.withOpacity(0.5),
                  blurRadius: 20,
                ),
              ],
            ),
          ),

          const Gap(16),

          Text(
            message,
            style: GoogleFonts.lato(
              fontSize: 18,
              color: AppColors.blushPink,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),

          const Gap(28),

          ElevatedButton.icon(
            onPressed: () {
              _confettiController.play();
              _resetQuiz();
            },
            icon: const Text('💝'),
            label: Text(
              'Play Again',
              style: GoogleFonts.dancingScript(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    ).animate().scale(duration: 800.ms, curve: Curves.elasticOut).fadeIn();
  }
}
