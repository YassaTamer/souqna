import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  Future<void> signUp({
    required String fullName,
    required String phoneNumber,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      await Supabase.instance.client.auth.signUp(
        password: password,
        email: email,
        data: {"full_name": fullName, "phone_number": phoneNumber},
      );
      emit(AuthSuccess());
    } on AuthException catch (e) {
      emit(AuthError(message: e.message));
    } catch (e) {
      emit(AuthError(message: "حصل خطأ غير متوقع"));
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      await Supabase.instance.client.auth.signInWithPassword(
        password: password,
        email: email,
      );
      emit(AuthSuccess());
    } on AuthException catch (e) {
      emit(AuthError(message: e.message));
    } catch (e) {
      emit(AuthError(message: "حصل خطأ غير متوقع"));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());

    await Supabase.instance.client.auth.signOut();
    emit(AuthInitial());
  }

  Future<void> verifyOtp({required String token, required String email}) async {
    emit(AuthLoading());
    try {
      await Supabase.instance.client.auth.verifyOTP(
        type: OtpType.signup,
        email: email,
        token: token,
      );
      emit(AuthSuccess());
    } on AuthException catch (e) {
      emit(AuthError(message: e.message));
    } catch (e) {
      emit(AuthError(message: "حصل خطأ غير متوقع"));
    }
  }
}
