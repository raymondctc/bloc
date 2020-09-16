import 'package:bloc/bloc.dart';
import 'package:mockito/mockito.dart';

class MockBlocObserver extends Mock implements BlocObserver {
  @override
  void onChange(Cubit cubit, Change change) {
    super.noSuchMethod(Invocation.method(#onChange, [cubit, change]));
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.noSuchMethod(Invocation.method(#onTransition, [bloc, transition]));
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.noSuchMethod(Invocation.method(#onEvent, [bloc, event]));
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace? stackTrace) {
    super.noSuchMethod(Invocation.method(#onError, [cubit, error, stackTrace]));
  }
}
