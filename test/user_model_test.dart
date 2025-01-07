import 'package:flutter/material.dart';
import 'package:oaap/access_management/data/user_model.dart';
import 'package:test/test.dart';

void main() {
  group('User Model Tests', () {
    test('User instance creation', () {
      // Arrange
      const role = 'admin';
      const username = 'zainab';
      const email = 'zainab@example.com';

      // Act
      final user = User(role: role, username: username, email: email);

      // Assert
      debugPrint('User instance creation test');
      debugPrint('Role: ${user.role}, Username: ${user.username}, Email: ${user.email}');
      
      expect(user.role, equals(role));
      expect(user.username, equals(username));
      expect(user.email, equals(email));
    });

    test('User.fromJson creates a User instance correctly', () {
      // Arrange
      final fetchedUser = {
        'role': 'moderator',
        'email': 'testuser@example.com',
      };

      // Act
      final user = User.fromJson(fetchedUser);

      // Assert
      debugPrint('User.fromJson test');
      debugPrint('Role: ${user.role}, Username: ${user.username}, Email: ${user.email}');

      expect(user.role, equals('moderator'));
      expect(user.username, equals('testuser')); // Derived from email
      expect(user.email, equals('testuser@example.com'));
    });

    test('User.fromJson handles invalid data gracefully', () {
      // Arrange
      final incompleteUser = {
        'email': 'invalid@example.com',
      };

      // Act & Assert
      debugPrint('User.fromJson invalid data test');
      try {
        final user = User.fromJson(incompleteUser);
        debugPrint('User created: ${user.role}, ${user.username}, ${user.email}');
      } catch (e) {
        debugPrint('Error caught: $e');
      }

      expect(
        () => User.fromJson(incompleteUser),
        throwsA(isA<TypeError>()), // Fails because 'role' is missing
      );
    });
  });
}
