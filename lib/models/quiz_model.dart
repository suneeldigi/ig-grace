// lib/models/quiz_model.dart
// Quiz question and answer models for the Love Quiz section

class QuizQuestion {
  final int id;
  final String question;
  final List<QuizOption> options;
  final List<int> correctOptionIndices; // supports multiple correct answers

  const QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctOptionIndices,
  });

  bool isCorrect(int selectedIndex) => correctOptionIndices.contains(selectedIndex);
}

class QuizOption {
  final String text;
  final String? emoji;

  const QuizOption({required this.text, this.emoji});
}

/// All quiz questions for My Wifeu My Grace
class QuizData {
  QuizData._();

  static final List<QuizQuestion> questions = [
    // Q1 — Grey's birthday
    QuizQuestion(
      id: 1,
      question: "When is Grey's birthday? 🎂",
      options: const [
        QuizOption(text: '9 Sep', emoji: '🌸'),
        QuizOption(text: '14 Sep', emoji: '🌼'),
        QuizOption(text: '4 Jan', emoji: '❄️'),
        QuizOption(text: '12 Dec', emoji: '🎄'),
      ],
      correctOptionIndices: const [0], // 9 Sep
    ),

    // Q2 — Grey's favorite color
    QuizQuestion(
      id: 2,
      question: "What is Grey's favorite color? 🎨",
      options: const [
        QuizOption(text: 'Black', emoji: '🖤'),
        QuizOption(text: 'Maroon', emoji: '❤️'),
        QuizOption(text: 'All colors', emoji: '🌈'),
        QuizOption(text: 'Whatever my wife wears', emoji: '👗'),
      ],
      correctOptionIndices: const [3], // Whatever my wife wears
    ),

    // Q3 — Wife's favorite food
    QuizQuestion(
      id: 3,
      question: "What is wifeu's favorite food? 😋",
      options: const [
        QuizOption(text: 'Golgappe', emoji: '🫧'),
        QuizOption(text: 'Momos', emoji: '🥟'),
        QuizOption(text: 'Pasta', emoji: '🍝'),
        QuizOption(text: 'Pizza', emoji: '🍕'),
      ],
      correctOptionIndices: const [0], // Golgappe
    ),

    // Q4 — What hubby wants to eat from wife
    QuizQuestion(
      id: 4,
      question: "What does hubby want to eat from wifeu when they meet? 🥺",
      options: const [
        QuizOption(text: 'Pasta', emoji: '🍝'),
        QuizOption(text: 'Egg Roll', emoji: '🌯'),
        QuizOption(text: 'Aloo Paratha', emoji: '🫓'),
        QuizOption(text: 'Your Lips 🫦', emoji: '💋'),
      ],
      correctOptionIndices: const [1, 3], // Egg Roll OR Lips
    ),

    // Q5 — What hubby loves most
    QuizQuestion(
      id: 5,
      question: "What does hubby love most about wifeu? ❤️",
      options: const [
        QuizOption(text: 'Eyes', emoji: '👀'),
        QuizOption(text: 'Lips', emoji: '💋'),
        QuizOption(text: 'Neck', emoji: '✨'),
        QuizOption(text: 'Hair', emoji: '💫'),
      ],
      correctOptionIndices: const [0], // Eyes
    ),

    // Q6 — How wife feels since meeting hubby
    QuizQuestion(
      id: 6,
      question: "Since meeting hubby, how does wifeu feel? 🥹",
      options: const [
        QuizOption(text: 'Good', emoji: '😊'),
        QuizOption(text: 'Very Good', emoji: '😄'),
        QuizOption(text: 'Bad', emoji: '😔'),
        QuizOption(text: 'I feel shy to tell', emoji: '🙈'),
      ],
      correctOptionIndices: const [3], // Shy to tell
    ),

    // Q7 — Happiest moment
    QuizQuestion(
      id: 7,
      question: "What is wifeu's most happiest moment? 🌸",
      options: const [
        QuizOption(text: 'When hubby comes and I hug him', emoji: '🤗'),
        QuizOption(text: 'Video call', emoji: '📞'),
        QuizOption(text: 'Gifts', emoji: '🎁'),
        QuizOption(text: 'Forehead kiss', emoji: '💕'),
      ],
      correctOptionIndices: const [0, 3], // Hug OR Forehead kiss
    ),

    // Q8 — When hubby says Love You More
    QuizQuestion(
      id: 8,
      question: "What happens when hubby says 'Love You More Than You'? 💗",
      options: const [
        QuizOption(text: 'Happy', emoji: '😊'),
        QuizOption(text: 'Peace', emoji: '☮️'),
        QuizOption(text: 'Gud Gud in tummy', emoji: '🦋'),
        QuizOption(text: 'Butterflies', emoji: '🦋'),
      ],
      correctOptionIndices: const [0, 1, 2, 3], // All accepted
    ),
  ];
}
