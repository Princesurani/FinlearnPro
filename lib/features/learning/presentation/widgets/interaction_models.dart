class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}

class Scenario {
  final String situation;
  final List<ScenarioChoice> choices;

  Scenario({required this.situation, required this.choices});
}

class ScenarioChoice {
  final String text;
  final bool isCorrect;
  final String feedback;

  ScenarioChoice({
    required this.text,
    required this.isCorrect,
    required this.feedback,
  });
}
