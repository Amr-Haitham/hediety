import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../3_model/models/app_user.dart';
import '../../../3_model/repo/appuser_firestore_repo.dart';
import '../../../core/consts/constant_text.dart';

part 'set_app_user_state.dart';

class SetAppUserCubit extends Cubit<SetAppUserState> {
  SetAppUserCubit() : super(SetAppUserInitial());
  final AppUserRepo _appUserRepo = AppUserRepo();
  void setAppUser(AppUser appUser) async {
    emit(SetAppUserLoading());
    try {
      await _appUserRepo.setSingleAppUser(appUser);
      emit(SetAppUserLoaded(appUser: appUser));
    } catch (e) {
      emit(SetAppUserError());
    }
  }
}
