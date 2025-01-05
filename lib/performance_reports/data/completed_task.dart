class CompletedTask{
  final String title;
  final String description;
  final String client;
  final String category;
  final String dateInitiated;
  final String dateDue;
  final String responsibleUser;
  final String dateCompleted;

  const CompletedTask({
    required this.title,
    required this.description,
    required this.client,
    required this.category,
    required this.dateInitiated,
    required this.dateDue,
    required this.responsibleUser,
    required this.dateCompleted,
  });

  factory CompletedTask.fromJson(Map<String, dynamic> fetchedTask){
    return CompletedTask(
      title: fetchedTask['title'],
      description: fetchedTask['description'],
      client: fetchedTask['client'],
      category: fetchedTask['category'],
      dateInitiated: fetchedTask['dateInitiated'],
      dateDue: fetchedTask['dateDue'],
      responsibleUser: fetchedTask['responsibleUser'], 
      dateCompleted: fetchedTask['dateCompleted']
    );
  }
}