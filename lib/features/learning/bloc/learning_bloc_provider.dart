import 'package:flutter/widgets.dart';
import 'learning_bloc.dart';

class LearningBlocProvider extends InheritedWidget {
  const LearningBlocProvider({
    super.key,
    required this.bloc,
    required super.child,
  });

  final LearningBloc bloc;

  static LearningBloc of(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<LearningBlocProvider>();
    if (provider == null) {
      throw Exception('No LearningBlocProvider found in context');
    }
    return provider.bloc;
  }

  @override
  bool updateShouldNotify(LearningBlocProvider oldWidget) {
    return bloc != oldWidget.bloc;
  }
}
