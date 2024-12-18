import 'package:bloc/bloc.dart';
import 'package:hediety/3_data_layer/repo/appuser_firestore_repo.dart';
import 'package:meta/meta.dart';

import '../../3_data_layer/models/app_user.dart';

part 'get_all_users_state.dart';

class GetAllUsersCubit extends Cubit<GetAllUsersState> {
  GetAllUsersCubit() : super(GetAllUsersInitial());
  final AppUserRepo _appUserRepo = AppUserRepo();
  void getAllUsers() async {
    emit(GetAllUsersLoading());
    try {
      List<AppUser> users = await _appUserRepo.getAllAppUsers();
      emit(GetAllUsersLoaded(users: users));
    } catch (e) {
      print(e);
      emit(GetAllUsersError());
    }
  }
}
