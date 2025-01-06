import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:oaap/access_management/data/user_model.dart';
import 'package:oaap/authentication/data/curr_user.dart';
import 'package:oaap/task_management/data/note.dart';
import 'package:oaap/task_management/data/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent,TaskState>{
  final FirebaseFirestore store = FirebaseFirestore.instance;
  
  TaskBloc():super(DoNothingState()){
    on<AddTask>(_addTask);
    on<RetrieveTasks>(_retrieveTasks);
    on<EditTask>(_editTask);
    on<MarkTaskComplete>(_markComplete);
    on<AddNote>(_addNote);
  }

  Future<void> _addTask(AddTask event, Emitter<TaskState> emit) async{
    emit(TaskLoadingState());
    try{
      store.collection('Tasks').add({
          'title': event.task.title,
          'description': event.task.description,
          'client': event.task.client,
          'category': event.task.category,
          'dateInitiated': event.task.dateInitiated,
          'dateDue': event.task.dateDue,
          'responsibleUser': event.task.responsibleUser
        }
      );
      emit(const PopUpMessageState(message: 'Task Added successfully.'));
    }catch (e){
      emit(PopUpMessageState(message: 'Error adding task: ${e.toString()}'));
    }
  }

  Future<void> _editTask(EditTask event, Emitter<TaskState> emit) async {

    QuerySnapshot querySnapshot = await store.collection('tasks').where('title', isEqualTo: event.task.title).get();

    if (querySnapshot.docs.isNotEmpty) {
      for (QueryDocumentSnapshot doc in querySnapshot.docs) { // task titles are unique so only one match
        await doc.reference.update({ //only due date and responsible user are editable. 
          'dateDue': event.task.dateDue,
          'responsibleUser': event.task.responsibleUser,
        });
      }
    } else {
      emit(const PopUpMessageState(message: 'No such task found'));
    }
  }

  Future<void> _markComplete(MarkTaskComplete event, Emitter<TaskState> emit) async{
    Task task = event.task; 
    bool addedToCompletedTasks = false;

    emit(TaskLoadingState());
    try{
      store.collection('CompletedTasks').add({
          'title': event.task.title,
          'description': event.task.description,
          'client': event.task.client,
          'category': event.task.category,
          'dateInitiated': event.task.dateInitiated,
          'dateDue': event.task.dateDue,
          'responsibleUser': event.task.responsibleUser,
          'dateCompleted': DateFormat.yMMMMd('en_US').format(DateTime.now())
        }
      );
      addedToCompletedTasks = true;
      //emit(const PopUpMessageState(message: 'Task Added successfully.'));
    }catch (e){
      //emit(PopUpMessageState(message: 'Error adding task: ${e.toString()}'));
    }

    if(addedToCompletedTasks){
      debugPrint(task.title);
      debugPrint(task.category);
      debugPrint(task.client);
      debugPrint(task.responsibleUser);
      debugPrint(task.description);
      debugPrint(task.dateInitiated);
      debugPrint(task.dateDue);

      try{
        QuerySnapshot snapshot = await store.collection('Tasks')
          .where('title', isEqualTo: task.title)
          .where('category', isEqualTo: task.category)
          .where('client', isEqualTo: task.client)
          .where('responsibleUser', isEqualTo: task.responsibleUser)
          .where('description', isEqualTo: task.description)
          .where('dateDue', isEqualTo: task.dateDue)
          .where('dateInitiated', isEqualTo: task.dateInitiated)
        .get();
    
        if(snapshot.docs.isNotEmpty){
          for(var doc in snapshot.docs){
            await doc.reference.delete();
          }
          debugPrint('Deleted Successfully');
        }else{
          debugPrint('found nothing');
        }
        add(const RetrieveTasks()); // retrieving tasks after successful deletion
      }catch (e){
        emit(PopUpMessageState(message: 'Error marking complete: ${e.toString()}'));
      }
    }else{
      emit(const PopUpMessageState(message: 'Error marking task complete.'));
    }
  }

  Future<void> _retrieveTasks(RetrieveTasks event, Emitter<TaskState> emit) async{
    emit(TaskLoadingState());
    try{

      User currUser = await CurrentUser().getCurrentUser();
      List<Task> tasks =[];

      if (currUser.role == 'admin' || currUser.role == 'moderator' ){

        
        QuerySnapshot snapshot = await store.collection('Tasks').get();

        for (var doc in snapshot.docs) {
          List<Note> notes = [];
          QuerySnapshot notesSnapshot = await doc.reference.collection('Notes').get();
          notes = notesSnapshot.docs.map((noteDoc) {
            return Note.fromJson(noteDoc.data() as Map<String, dynamic>);
          }).toList();
          tasks.add(Task.fromJson(doc.data() as Map<String, dynamic>, notes));
        }

      }else{ //employee
        // need to retrieve only those tasks jis ki clients and categories ka access ho current employee k pass
        tasks = await getTasksFromFirestore();
      }
      

      emit(FetchedTasks(tasks: tasks));
    }catch (e){
      emit(TaskErrorState(error: e.toString()));
    }
  }

  Future<List<Task>> getTasksFromFirestore() async {
    List<Task> accessibleTasks = [];

    User currUser = await CurrentUser().getCurrentUser();

    try {
      CollectionReference tasks = store.collection('Tasks'); // Fetch all tasks from Firestore
      QuerySnapshot querySnapshot = await tasks.get();

      for (var doc in querySnapshot.docs) { // Iterate through each task document
        String client = doc['client'] as String;
        String category = doc['category'] as String;

        // Check if the current user has access to this client and category
        List<String> usersWithAccess = await getUsersWithAccess(client, category);

        if (usersWithAccess.contains(currUser.email)) {
          // Add task to accessibleTasks list if the user has access
          List<Note> notes = [];
          QuerySnapshot notesSnapshot = await doc.reference.collection('Notes').get();
          notes = notesSnapshot.docs.map((noteDoc) {
            return Note.fromJson(noteDoc.data() as Map<String, dynamic>);
          }).toList();
          accessibleTasks.add(Task.fromJson(doc.data() as Map<String, dynamic>, notes));
        }
      }
    } catch (e) {
      // Handle any errors
      debugPrint('Error fetching tasks ${e.toString()}');
    }

    return accessibleTasks;
  }

  Future<List<String>> getUsersWithAccess(String client, String category) async {
    List<String> useremails = [];

    try {
      // Reference to the usersWithAccess sub-collection for the given client and category
      final CollectionReference usersRef = store
          .collection('Clients')
          .doc(client)
          .collection('Categories')
          .doc(category)
          .collection('Access');

      // Fetch all documents in the usersWithAccess sub-collection
      final QuerySnapshot userSnapshot = await usersRef.get();

      // Iterate through each document and add the document ID (email) to the list
      for (var userDoc in userSnapshot.docs) {
        useremails.add(userDoc.id);
      }

      return useremails;
    } catch (e) {
      //print(e);
      return [];
    }
  }

  Future<void> _addNote(AddNote event, Emitter<TaskState> emit) async {
  try {
    emit(TaskLoadingState());

    // Find the task document
    QuerySnapshot snapshot = await store.collection('Tasks')
        .where('title', isEqualTo: event.task.title)
        .where('category', isEqualTo: event.task.category)
        .where('client', isEqualTo: event.task.client)
        .where('responsibleUser', isEqualTo: event.task.responsibleUser)
        .where('description', isEqualTo: event.task.description)
        .where('dateDue', isEqualTo: event.task.dateDue)
        .where('dateInitiated', isEqualTo: event.task.dateInitiated)
        .get();

    if (snapshot.docs.isNotEmpty) {
      // Add the note to the Notes subcollection of the task document
      await snapshot.docs.first.reference.collection('Notes').add({
        'comment': event.note.comment,
        'username': event.note.username,
        'date': event.note.date,
      });

      add(const RetrieveTasks());
    } else {
      emit(const TaskErrorState(error: 'Task not found'));
    }
  } catch (e) {
    emit(TaskErrorState(error: e.toString()));
  }
}


}

//  final String title;
//   final String description;
//   final String client;
//   final String category;
//   final String dateInitiated;
//   final String dateDue;
//   final String responsibleUser;