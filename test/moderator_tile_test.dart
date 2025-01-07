//widget test
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oaap/access_management/data/user_model.dart';
import 'package:oaap/moderator_management/ui/widgets/moderator_tile.dart';

void main() {
  group('MyModeratorTile Widget Tests', () {
    testWidgets('Data displayed correctly in Moderator Tile', (tester) async {
      final testUser = User(
        role: 'Moderator',
        username: 'testUser',
        email: 'test@email.com',
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MyModeratorTile(user: testUser),
          ),
        ),
      );
      expect(find.text('testUser'), findsOneWidget);
      expect(find.text('test@email.com'), findsOneWidget);
      expect(find.text('Moderator'), findsOneWidget);
    });

    testWidgets('Overflow handled correctly in Moderator Tile', (tester) async {
      // test user with lumbi username and email
      final testUser = User(
        role: 'Moderator',
        username: 'ThisIsAVeryLongUsernameThatShouldOverflowInTheTile',
        email: 'thisisaverylongemailaddress@example.com',
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MyModeratorTile(user: testUser),
          ),
        ),
      );
      expect(find.text('ThisIsAVeryLongUsernameThatShouldOverflowInTheTile'), findsOneWidget);
      expect(find.text('thisisaverylongemailaddress@example.com'), findsOneWidget);
    });
  });
}