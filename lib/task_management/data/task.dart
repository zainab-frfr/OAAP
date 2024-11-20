
class Task{
  final String title;
  final String description;
  final String client;
  final String category;
  final String dateInitiated;
  final String dateDue;
  final String responsibleUser;

  const Task({
    required this.title,
    required this.description,
    required this.client,
    required this.category,
    required this.dateInitiated,
    required this.dateDue,
    required this.responsibleUser,
  });

  factory Task.fromJson(Map<String, dynamic> fetchedTask){
    return Task(
      title: fetchedTask['title'],
      description: fetchedTask['description'],
      client: fetchedTask['client'],
      category: fetchedTask['category'],
      dateInitiated: fetchedTask['dateInitiated'],
      dateDue: fetchedTask['dateDue'],
      responsibleUser: fetchedTask['responsibleUser']
    );
  }
}