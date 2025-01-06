part of 'user_bloc.dart';

sealed class UserEvent{
  const UserEvent();
}

final class FetchUsers extends UserEvent{
  const FetchUsers();
} 

final class MakeModerator extends UserEvent{
  final String userEmail;
  const MakeModerator({required this.userEmail});
}

final class RemoveModerator extends UserEvent{
  final String userEmail;
  const RemoveModerator({required this.userEmail});
}