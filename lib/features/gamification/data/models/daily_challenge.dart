class ChallengeChoice {
  final int id;
  final String text;

  ChallengeChoice({required this.id, required this.text});

  factory ChallengeChoice.fromJson(Map<String, dynamic> json) {
    return ChallengeChoice(id: json['id'] as int, text: json['text'] as String);
  }
}

class DailyChallenge {
  final int id;
  final String challengeDate;
  final String assetSymbol;
  final String timeframe;
  final String scenarioText;
  final List<ChallengeChoice> choices;
  final List<double>? chartData;

  // Progress variables
  final bool isCompleted;
  final bool? wasCorrect;
  final String? explanation;
  final int? correctChoiceId;

  DailyChallenge({
    required this.id,
    required this.challengeDate,
    required this.assetSymbol,
    required this.timeframe,
    required this.scenarioText,
    required this.choices,
    this.chartData,
    required this.isCompleted,
    this.wasCorrect,
    this.explanation,
    this.correctChoiceId,
  });

  factory DailyChallenge.fromJson(Map<String, dynamic> json) {
    return DailyChallenge(
      id: json['id'] as int,
      challengeDate: json['challenge_date'] as String,
      assetSymbol: json['asset_symbol'] as String,
      timeframe: json['timeframe'] as String,
      scenarioText: json['scenario_text'] as String,
      choices: (json['choices'] as List)
          .map((e) => ChallengeChoice.fromJson(e as Map<String, dynamic>))
          .toList(),
      chartData: json['chart_data'] != null
          ? (json['chart_data'] as List)
              .map((e) => (e as num).toDouble())
              .toList()
          : null,
      isCompleted: json['is_completed'] as bool? ?? false,
      wasCorrect: json['was_correct'] as bool?,
      explanation: json['explanation'] as String?,
      correctChoiceId: json['correct_choice_id'] as int?,
    );
  }
}

class ChallengeSubmissionResult {
  final bool isCorrect;
  final String explanation;
  final int xpAwarded;
  final bool streakUpdated;
  final int currentStreak;
  final int correctChoiceId;

  ChallengeSubmissionResult({
    required this.isCorrect,
    required this.explanation,
    required this.xpAwarded,
    required this.streakUpdated,
    required this.currentStreak,
    required this.correctChoiceId,
  });

  factory ChallengeSubmissionResult.fromJson(Map<String, dynamic> json) {
    return ChallengeSubmissionResult(
      isCorrect: json['is_correct'] as bool,
      explanation: json['explanation'] as String,
      xpAwarded: json['xp_awarded'] as int,
      streakUpdated: json['streak_updated'] as bool,
      currentStreak: json['current_streak'] as int,
      correctChoiceId: json['correct_choice_id'] as int,
    );
  }
}
