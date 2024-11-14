part of 'access_bloc.dart';

sealed class AccessState{}

class LoadingState extends AccessState{}

class FetchedAccessInformation extends AccessState{
  final  List<ClientCategoryAccess> accessList;
  FetchedAccessInformation({required this.accessList});
}

class FetchedEmployeesAndAccessInformation extends AccessState{
  final List<User> allUsers;
  final  List<ClientCategoryAccess> accessList;
  FetchedEmployeesAndAccessInformation({required this.allUsers, required this.accessList});
}

final class AccessPopUpMessage extends AccessState{
  final String message;
  AccessPopUpMessage({required this.message});
}

final class AccessError extends AccessState{
  final String error; 
  AccessError({required this.error});
}