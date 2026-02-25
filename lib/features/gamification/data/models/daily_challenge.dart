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

  // Progress variables
  final bool isCompleted;
  final bool? wasCorrect;
  final String? explanation;

  DailyChallenge({
    required this.id,
    required this.challengeDate,
    required this.assetSymbol,
    required this.timeframe,
    required this.scenarioText,
    required this.choices,
    required this.isCompleted,
    this.wasCorrect,
    this.explanation,
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
      isCompleted: json['is_completed'] as bool? ?? false,
      wasCorrect: json['was_correct'] as bool?,
      explanation: json['explanation'] as String?,
    );
  }
}

class ChallengeSubmissionResult {
  final bool isCorrect;
  final String explanation;
  final int xpAwarded;
  final bool streakUpdated;

  ChallengeSubmissionResult({
    required this.isCorrect,
    required this.explanation,
    required this.xpAwarded,
    required this.streakUpdated,
  });

  factory ChallengeSubmissionResult.fromJson(Map<String, dynamic> json) {
    return ChallengeSubmissionResult(
      isCorrect: json['is_correct'] as bool,
      explanation: json['explanation'] as String,
      xpAwarded: json['xp_awarded'] as int,
      streakUpdated: json['streak_updated'] as bool,
    );
  }
}
