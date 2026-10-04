class ProfileModel {
  final String id;
  final String? fullName;
  final String? bio;
  final String? address;
  final String? avatarUrl;
  final String? phoneNumber;
  final DateTime? createsAt;

  ProfileModel({
    required this.id,
    this.fullName,
    this.bio,
    this.address,
    this.avatarUrl,
    this.phoneNumber,
    this.createsAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      fullName: json['full_name'],
      bio: json['bio'],
      address: json['address'],
      avatarUrl: json['avatar_url'],
      phoneNumber: json['phone_number'],
      createsAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }
}
