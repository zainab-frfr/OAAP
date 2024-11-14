part of 'cc_bloc.dart';

sealed class ClientCategoryState{}

final class LoadingClientCategory extends ClientCategoryState{}

final class FetchedClientCategory extends ClientCategoryState{
  final List<ClientCategoryModel> clientsAndCategories;
  FetchedClientCategory({required this.clientsAndCategories});
}

final class ClientCategoryError extends ClientCategoryState{
  final String error;
  ClientCategoryError({required this.error});
}

final class ClientCategoryPopUpMessage extends ClientCategoryState{
  final String message;
  ClientCategoryPopUpMessage({required this.message});
}