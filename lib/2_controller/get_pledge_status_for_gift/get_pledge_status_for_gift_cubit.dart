import 'package:bloc/bloc.dart';
import 'package:hediety/3_data_layer/repo/events_repo.dart';
import 'package:hediety/3_data_layer/repo/gifts_repo.dart';
import 'package:hediety/3_data_layer/repo/pledges_repo.dart';
import 'package:meta/meta.dart';

import '../../3_data_layer/models/event.dart';
import '../../3_data_layer/repo/appuser_firestore_repo.dart';

part 'get_pledge_status_for_gift_state.dart';

class GetPledgeStatusForGiftCubit extends Cubit<GetPledgeStatusForGiftState> {
  final PledgesRepo _pledgesRepo = PledgesRepo();
  final AppUserRepo _appUserRepo = AppUserRepo();
  final GiftsRepo _giftsRepo = GiftsRepo();
  final EventsRepo _eventsRepo = EventsRepo();
  GetPledgeStatusForGiftCubit() : super(GetPledgeStatusForGiftInitial());

  getPledgeStatusForGift(
      {required String giftId, required String eventId}) async {
    emit(GetPledgeStatusForGiftLoading());
    PledgeStatus pledgeStatus = PledgeStatus.unpledged;
    try {
      Event event = await _eventsRepo.getSingleEvent(eventId: eventId);
      event.userId;

      var pledge = await _pledgesRepo.getSinglePledgeFromGiftId(giftId: giftId);
      if (pledge != null) {
        pledgeStatus =
            pledge.isFulfilled ? PledgeStatus.done : PledgeStatus.pledged;
      }

      emit(GetPledgeStatusForGiftSuccess(
          pledgeStatus: pledgeStatus, giftOnwerID: event.userId));
    } catch (e) {
      emit(GetPledgeStatusForGiftError());
    }
  }
}
