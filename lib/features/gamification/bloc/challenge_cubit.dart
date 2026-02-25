import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/daily_challenge.dart';
import '../data/repositories/challenge_repository.dart';

abstract class ChallengeState {}

class ChallengeInitial extends ChallengeState {}

class ChallengeLoading extends ChallengeState {}

class ChallengeLoaded extends ChallengeState {
  final DailyChallenge challenge;
  final bool isSubmitted;

  ChallengeLoaded({required this.challenge, this.isSubmitted = false});
}

class ChallengeError extends ChallengeState {
  final String message;
  ChallengeError(this.message);
}

class ChallengeSubmitted extends ChallengeState {
  final DailyChallenge challenge;
  final ChallengeSubmissionResult result;

  ChallengeSubmitted({required this.challenge, required this.result});
}

class ChallengeCubit extends Cubit<ChallengeState> {
  final ChallengeRepository _repository;

  ChallengeCubit({ChallengeRepository? repository})
    : _repository = repository ?? ChallengeRepository(),
      super(ChallengeInitial());

  Future<void> fetchDailyChallenge() async {
    try {
      emit(ChallengeLoading());
      final challenge = await _repository.getDailyChallenge();

      if (challenge != null) {
        if (challenge.isCompleted) {
          // If the challenge was already completed, it comes with `wasCorrect` and `explanation`
          final dummyResult = ChallengeSubmissionResult(
            isCorrect: challenge.wasCorrect ?? false,
            explanation: challenge.explanation ?? '',
            xpAwarded: 0,
            streakUpdated: false,
          );
          emit(ChallengeSubmitted(challenge: challenge, result: dummyResult));
        } else {
          emit(ChallengeLoaded(challenge: challenge));
        }
      } else {
        emit(
          ChallengeError(
            "No daily challenge found for today. Check back tomorrow!",
          ),
        );
      }
    } catch (e) {
      emit(ChallengeError("Failed to load daily challenge. Please try again."));
    }
  }

  Future<void> submitAnswer(int choiceId) async {
    final currentState = state;
    if (currentState is ChallengeLoaded) {
      try {
        final result = await _repository.submitChallengeAnswer(
          choiceId: choiceId,
        );
        emit(
          ChallengeSubmitted(challenge: currentState.challenge, result: result),
        );
      } catch (e) {
        emit(ChallengeError("Failed to submit answer. Please try again."));
      }
    }
  }
}
