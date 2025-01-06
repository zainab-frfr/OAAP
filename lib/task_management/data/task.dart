
import 'package:oaap/task_management/data/note.dart';

class Task{
  final String title;
  final String description;
  final String client;
  final String category;
  final String dateInitiated;
  final String dateDue;
  final String responsibleUser;
  final List<Note> notes;

  const Task({
    required this.title,
    required this.description,
    required this.client,
    required this.category,
    required this.dateInitiated,
    required this.dateDue,
    required this.responsibleUser,
    this.notes = const [],
  });

  factory Task.fromJson(Map<String, dynamic> fetchedTask,  List<Note> notes){
    return Task(
      title: fetchedTask['title'],
      description: fetchedTask['description'],
      client: fetchedTask['client'],
      category: fetchedTask['category'],
      dateInitiated: fetchedTask['dateInitiated'],
      dateDue: fetchedTask['dateDue'],
      responsibleUser: fetchedTask['responsibleUser'], 
      notes: notes,
    );
  }
}