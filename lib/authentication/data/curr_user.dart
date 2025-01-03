import 'package:oaap/access_management/data/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentUser{
    
    Future<void> setCurrentUser(User user) async{
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', user.email);
      await prefs.setString('username', user.username);
      await prefs.setString('role', user.role);
    }

    Future<User> getCurrentUser() async{
      final prefs = await SharedPreferences.getInstance();

      String email = prefs.getString('email') ?? '';
      String username = prefs.getString('username') ?? '';
      String role = prefs.getString('role') ?? '';

      return User(role: role, username: username, email: email);
      
    }
    
}