import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../3_global_data_layer/models/app_user.dart';
import '../../../3_global_data_layer/repo/appuser_firestore_repo.dart';
import '../../../core/consts/constant_text.dart';
part 'get_app_user_state.dart';

class GetAppUserCubit extends Cubit<GetAppUserState> {
  GetAppUserCubit() : super(GetAppUserInitial());

  final AppUserRepo _appUserRepo = AppUserRepo();


  void getAppUser({required uid}) async {
    emit(GetAppUserLoading());
    try {
      AppUser appUser = await _appUserRepo.getSingleAppUser(uid);
      emit(GetAppUserLoaded(appUser: appUser));
    } catch (e) {
      print("$e the errror");
      emit(GetAppUserError());
    }
  }
}
