import 'package:bloc/bloc.dart';
import 'package:hediety/3_data_layer/models/app_user.dart';
import 'package:hediety/3_data_layer/models/gift.dart';
import 'package:hediety/3_data_layer/repo/appuser_firestore_repo.dart';
import 'package:hediety/3_data_layer/repo/gifts_repo.dart';
import 'package:meta/meta.dart';

import '../../3_data_layer/models/pledge.dart';
import '../../3_data_layer/repo/pledges_repo.dart';

part 'get_my_pledges_state.dart';

class GetMyPledgesCubit extends Cubit<GetMyPledgesState> {
  GetMyPledgesCubit() : super(GetMyPledgesInitial());
  final PledgesRepo _pledgesRepo = PledgesRepo();
  final GiftsRepo _giftsRepo = GiftsRepo();
  final AppUserRepo _appUserRepo = AppUserRepo();
  void getUserPledges({required String userId}) async {
    try {
      List<PledgeDataEntity> pledges = [];
      final pledgesDocs =
          await _pledgesRepo.getAllPledgesForUser(userId: userId);
      print(pledgesDocs.docs.length);
      // print(pledgesDocs.docs.first.data().toString());
      if (pledgesDocs.docs.isEmpty) {
        emit(GetMyPledgesSuccess(pledges: pledges));
        return;
      }
      for (var pledgeDoc in pledgesDocs.docs) {
        final pledge = Pledge.fromMap(pledgeDoc.data());
        final appUser = await _appUserRepo.getSingleAppUser(pledge.giftOwnerId);
        final gift = await _giftsRepo.getSinglegift(giftId: pledge.giftId);
        pledges.add(
            PledgeDataEntity(pledge: pledge, giftOwner: appUser, gift: gift));
      }
      emit(GetMyPledgesSuccess(pledges: pledges));
    } catch (e) {
      print(e);
      emit(GetMyPledgesError());
    }
  }
}
