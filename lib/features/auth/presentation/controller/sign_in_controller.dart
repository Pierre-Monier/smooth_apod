import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/auth_repository.dart';

enum SignInForm {
  github,
  google,
  email,
  anonymous,
}

class SignInState {
  const SignInState({
    required this.formState,
  });

  factory SignInState.initial() => const SignInState(
        formState: {
          SignInForm.github: AsyncValue.data(null),
          SignInForm.google: AsyncValue.data(null),
          SignInForm.email: AsyncValue.data(null),
          SignInForm.anonymous: AsyncValue.data(null),
        },
      );

  final Map<SignInForm, AsyncValue> formState;

  SignInState copyWith({Map<SignInForm, AsyncValue<void>>? formState}) =>
      SignInState(formState: formState ?? this.formState);

  bool isThisFormLoading(SignInForm form) {
    final asyncValue = formState[form];

    if (asyncValue == null) {
      return false;
    }

    return asyncValue.isLoading;
  }
}

class SignInController extends StateNotifier<SignInState> {
  SignInController(
    SignInState initial, {
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(initial);

  final AuthRepository _authRepository;

  Future<void> signIn(SignInForm form) async {
    final currentFormState = state.formState;

    final newFormState = {
      ...currentFormState,
      ...{form: const AsyncValue.loading()}
    };

    state = state.copyWith(formState: newFormState);

    if (form == SignInForm.anonymous) {
      final newAnonymouseState =
          await AsyncValue.guard(_authRepository.signUserAnonymously);

      final newFormState = {
        ...currentFormState,
        ...{form: newAnonymouseState}
      };
      state = state.copyWith(formState: newFormState);
    } else if (form == SignInForm.github) {
      final newGithubState =
          await AsyncValue.guard(_authRepository.signUserWithGithub);

      // TODO refacto duplicate
      final newFormState = {
        ...currentFormState,
        ...{form: newGithubState}
      };
      state = state.copyWith(formState: newFormState);
    }
  }
}

final signInControllerProvider =
    StateNotifierProvider<SignInController, SignInState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);

  return SignInController(
    SignInState.initial(),
    authRepository: authRepository,
  );
});
