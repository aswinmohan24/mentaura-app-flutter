import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mentaura_app/features/auth/models/user.details.model.dart';
import 'package:mentaura_app/features/auth/repositories/firebase_auth_repository.dart';
import 'package:mentaura_app/features/auth/repositories/google_auth_repository.dart';
import 'package:mentaura_app/features/auth/repositories/user.auth.repository.dart';

final firebaseAuthRepoProvider =
    Provider((ref) => FirebaseAuthRepository(auth: FirebaseAuth.instance));

final googleAuthRepoProvider = Provider<GoogleAuthRepository>((ref) {
  return GoogleAuthRepository(
      auth: FirebaseAuth.instance, googleSignIn: GoogleSignIn());
});

final userAuthRepositoryProvider = Provider((ref) => UserAuthRepository());

// Stream provider for auth state changes
final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthRepoProvider).authStateChanges;
});

// FirebaseAuth instance provider
final firebaseAuthInstanceProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

//Independent Providers -------------------------------------

final googleEmailIdProvider = StateProvider<String?>((ref) {
  return null;
});

final userPhoneNumberProvider = StateProvider<String?>((ref) => null);

final userNameProvider = StateProvider<String?>((ref) => null);

final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

// get user provider
final getUserProvider = FutureProvider<UserDetails?>((ref) async {
  final userAuthRepository = ref.read(userAuthRepositoryProvider);
  return userAuthRepository.getUser();
});

//----- Userdetails model provider ------------------------

final userDetailsProvider =
    StateNotifierProvider<UserDetailsNotifier, UserDetails>((ref) {
  return UserDetailsNotifier();
});

class UserDetailsNotifier extends StateNotifier<UserDetails> {
  UserDetailsNotifier()
      : super(UserDetails(
          name: '',
          phoneNumber: '',
          age: '',
          email: '',
          gender: '',
        ));

  void updateUserDetails(UserDetails newUser) {
    state = newUser;
  }

  void updateName(String newName) {
    state = state.copyWith(name: newName);
  }

  void updatePhoneNumber(String newPhoneNumber) {
    state = state.copyWith(phoneNumber: newPhoneNumber);
  }

  void updateAge(String newAge) {
    state = state.copyWith(age: newAge);
  }

  void updateEmail(String newEmail) {
    state = state.copyWith(email: newEmail);
  }

  void updateGender(String newGender) {
    state = state.copyWith(gender: newGender);
  }
}
