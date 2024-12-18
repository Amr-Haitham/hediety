import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../3_data_layer/models/pledge.dart';
import '../../3_data_layer/repo/pledges_repo.dart';

part 'add_pledge_state.dart';

class AddPledgeCubit extends Cubit<AddPledgeState> {
  AddPledgeCubit() : super(AddPledgeInitial());
  final PledgesRepo _pledgesRepo = PledgesRepo();
  void addPledge({required Pledge pledge}) async {
    emit(AddPledgeLoading());
    try {
      await _pledgesRepo.setPledge(pledge: pledge);
      emit(AddPledgeSuccess());
    } catch (e) {
      emit(AddPledgeError());
    }
  }
}
 