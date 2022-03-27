import 'package:bloc/bloc.dart';
import 'package:notes/model/user.dart';
import 'package:notes/repo/user_repo.dart';
import 'package:notes/ui/screens/user/bloc/user_states.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _repository;

  UserCubit(this._repository) : super(UserInitialState());

  void loadUser() async {
    emit(UserLoadingState());
    try {
      final user = await _repository.getUser();
      emit(UserLoadedState(user));
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }
}
