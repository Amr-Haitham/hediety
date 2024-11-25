import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  GetUserCubit() : super(GetUserInitial());
}
