import 'package:souqna/features/profile/data/models/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRepository {
  final _client = Supabase.instance.client;
  Future<ProfileModel> getProfile() async {
    final userId = _client.auth.currentUser!.id;
    final response = await _client.from('profiles').select().eq('id', userId).single();
    return ProfileModel.fromJson(response);
  }
}
