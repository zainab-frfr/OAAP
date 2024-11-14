part of 'cc_bloc.dart';

sealed class ClientCategoryEvent{
  const ClientCategoryEvent();
}

final class FetchClientCategory extends ClientCategoryEvent{}

final class AddClient extends ClientCategoryEvent{
  final String client;
  AddClient({required this.client});
}
final class AddCategoryToClient extends ClientCategoryEvent{
  final String client;
  final String category;
  AddCategoryToClient({required this.client, required this.category});
}

final class RemoveClient extends ClientCategoryEvent{
  final String client;
  RemoveClient({required this.client});
}
final class RemoveCategoryFromClient extends ClientCategoryEvent{
  final String client;
  final String category;
  RemoveCategoryFromClient({required this.client, required this.category});
}