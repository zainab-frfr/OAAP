part of 'user_bloc.dart';

sealed class UserEvent{
  const UserEvent();
}

final class FetchUsers extends UserEvent{
  const FetchUsers();
} 
