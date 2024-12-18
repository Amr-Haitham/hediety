import 'package:bloc/bloc.dart';
import 'package:hediety/3_data_layer/models/app_user.dart';
import 'package:hediety/3_data_layer/repo/appuser_firestore_repo.dart';
import 'package:hediety/core/utils/auth_utils.dart';
import 'package:meta/meta.dart';

part 'get_single_appuser_state.dart';

class GetSingleAppuserCubit extends Cubit<GetSingleAppuserState> {
  GetSingleAppuserCubit() : super(GetSingleAppuserInitial());
  final AppUserRepo _appUserRepository = AppUserRepo();
  void getSingleAppUser() async {
    emit(GetSingleAppuserLoading());
    try {
      var appUser = await _appUserRepository
          .getSingleAppUser(AuthUtils.getCurrentUserUid());
      emit(GetSingleAppuserLoaded(appUser: appUser));
    } catch (e) {
      print(e);
      emit(GetSingleAppuserError());
    }
  }
}
