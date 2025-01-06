import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oaap/access_management/data/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState>{
  final FirebaseFirestore store = FirebaseFirestore.instance;
  
  UserBloc():super(UserLoadingState()){
    on<FetchUsers>(_fetchUsers);
  }

  Future<void> _fetchUsers(FetchUsers event, Emitter<UserState> emit) async{
    emit(UserLoadingState());
    try{
      List<User> users =[];

      //getting saray completed tasks of current user
      QuerySnapshot snapshotComplete = await store.collection('users').get();
      users = snapshotComplete.docs.map((doc) {
        return User.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();


      emit(FetchedUsers(users: users));
    }catch (e){
      emit(UserErrorState(error: e.toString()));
    }
  }
}