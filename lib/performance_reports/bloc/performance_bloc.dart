import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:oaap/access_management/data/user_model.dart';
import 'package:oaap/authentication/data/curr_user.dart';
import 'package:oaap/performance_reports/data/completed_task.dart';
import 'package:oaap/performance_reports/data/performance.dart';
import 'package:oaap/task_management/data/task.dart';

part 'performance_event.dart';
part 'performance_state.dart';

class PerformanceBloc extends Bloc<PerformanceEvent, PerformanceState>{
  final FirebaseFirestore store = FirebaseFirestore.instance;
  
  PerformanceBloc():super(PerformanceLoadingState()){
    on<FetchPerformanceInformation>(_fetchPerformanceInformation);
  }

  Future<void> _fetchPerformanceInformation(FetchPerformanceInformation event, Emitter<PerformanceState> emit) async{
    emit(PerformanceLoadingState());
    try{
      List<CompletedTask> completedTasks =[];
      List<Task> incompleteTasks =[];

      //getting saray completed tasks of current user
      QuerySnapshot snapshotComplete = await store.collection('CompletedTasks').where('responsibleUser', isEqualTo:event.email ).get();
      completedTasks = snapshotComplete.docs.map((doc) {
        return CompletedTask.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      //getting saray incomplete tasks of current user
      QuerySnapshot snapshotIncomplete = await store.collection('Tasks').where('responsibleUser', isEqualTo:event.email ).get();
      incompleteTasks = snapshotIncomplete.docs.map((doc) {
        return Task.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      Performance performance = calculatePerformance(completedTasks, incompleteTasks);

      emit(FetchedPerformance(performance: performance));
    }catch (e){
      emit(PerformanceErrorState(error: e.toString()));
    }
  }

  Performance calculatePerformance(List<CompletedTask> completedTasksList,  List<Task> incompleteTasksList){
    double onTimeRate = 0;
    double lateTaskRate = 0;

    int completedTasks = completedTasksList.length; 
    int totalTasks = completedTasksList.length + incompleteTasksList.length;

    int onTime = 0;
    int late = 0;

    DateFormat inputFormat = DateFormat("MMMM d, yyyy");
    
    for (CompletedTask task in completedTasksList){
      DateTime dateCompleted = inputFormat.parse(task.dateCompleted);
      DateTime dateDue = inputFormat.parse(task.dateDue);
      if(dateCompleted.isAfter(dateDue)){ // late task
        late++;
      }else{
        onTime++;
      }
    }

    onTimeRate = onTime/completedTasks; 
    lateTaskRate = late/completedTasks;

    int overdueTasks = 0;
    int pendingTasks = 0; 

    DateTime currDate = DateTime.now();
    for (Task task in incompleteTasksList){
      DateTime dateDue = inputFormat.parse(task.dateDue);
      if(currDate.isAfter(dateDue)){ // late task
        overdueTasks++;
      }else{
        pendingTasks++;
      }
    }

    return Performance.fromJson({
      'onTimeRate': onTimeRate,
      'lateTaskRate': lateTaskRate,
      'overdueTasks': overdueTasks, 
      'pendingTasks': pendingTasks, 
      'completedTasks': completedTasks,
      'totalTasks': totalTasks,
    });
    
  }
}