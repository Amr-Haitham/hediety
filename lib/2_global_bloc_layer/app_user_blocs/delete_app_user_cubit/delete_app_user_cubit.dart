import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../3_global_data_layer/repo/appuser_firestore_repo.dart';
import '../../../core/consts/constant_text.dart';

part 'delete_app_user_state.dart';

class DeleteAppUserCubit extends Cubit<DeleteAppUserState> {
  DeleteAppUserCubit() : super(DeleteAppUserInitial());
  final AppUserRepo _appUserRepo = AppUserRepo();

  void deleteAppUser({required uid}) async {
    emit(DeleteAppUserLoading());
    try {
      await _appUserRepo.deleteSingleAppUser(uid);
      emit(DeleteAppUserLoaded());
    } catch (e) {
      emit(DeleteAppUserError());
    }
  }
}
