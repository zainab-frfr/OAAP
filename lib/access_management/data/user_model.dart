class User {

  final String role; // can be admin, moderator, or employee
  final String username;
  final String email;

  User({
    required this.role,
    required this.username,
    required this.email
  });

  factory User.fromJson(Map<String, dynamic> fetchedUser){
    return User(
      role: fetchedUser['role'], 
      username: fetchedUser['email'].toString().split('@')[0], //takes email ka shuru ka part as user name 
      email: fetchedUser['email']
    );
  }
}