class UserData {
  final String uid;
  final String userName;
  String? description;
  int? age;
  List<String>? interest;
  int followerCount;
  int followingCount;

  UserData({
    required this.uid,
    required this.userName,
    this.age,
    this.description,
    this.interest,
    this.followerCount = 0,
    this.followingCount = 0,
  });
}
