part of 'user_bloc.dart';

sealed class UserState{
  const UserState();
}

final class UserLoadingState extends UserState{}

final class FetchedUsers extends UserState{
  final List<User> users;
  const FetchedUsers({required this.users});
}

final class UserErrorState extends UserState{
  final String error;
  const UserErrorState({required this.error});
}