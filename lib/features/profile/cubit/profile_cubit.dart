import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:souqna/features/profile/data/models/profile_model.dart';
import 'package:souqna/features/profile/data/repositories/profile_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._profileRepository) : super(ProfileInitial());
  final ProfileRepository _profileRepository;
  Future<void> fetchProfile() async {
    try {
      emit(ProfileLoading());
      final profile = await _profileRepository.getProfile();
      emit(ProfileLoaded(profile: profile));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}
