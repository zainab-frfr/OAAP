part of 'access_bloc.dart';

sealed class AccessEvent{
  const AccessEvent();
}
class FetchAccessInformation extends AccessEvent{
  const FetchAccessInformation();
}
class GrantAccess extends AccessEvent{
  final String client;
  final String category;
  final String email;
  const GrantAccess({required this.client, required this.category, required this.email});
}
class RevokeAccess extends AccessEvent{
  final String client;
  final String category;
  final String email;
  const RevokeAccess({required this.client, required this.category, required this.email});
}

class FetchEmployeesAndAccessInformation extends AccessEvent{
  const FetchEmployeesAndAccessInformation();
}