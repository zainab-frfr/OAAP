class ClientCategoryModel {

  final String client;
  final List<String> categories;

  ClientCategoryModel({
    required this.client,
    required this.categories
  });

  factory ClientCategoryModel.fromJson(String client, List<String> categories) {
    return ClientCategoryModel(
      client: client,
      categories: categories,
    );
  }
}