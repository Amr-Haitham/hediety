import 'package:bloc/bloc.dart';
import 'package:hediety/3_data_layer/repo/gifts_repo.dart';
import 'package:meta/meta.dart';

import '../../../3_data_layer/models/gift.dart';

part 'delete_gift_for_event_state.dart';

class DeleteGiftForEventCubit extends Cubit<DeleteGiftForEventState> {
  DeleteGiftForEventCubit() : super(DeleteGiftForEventInitial());
  final GiftsRepo _giftsRepo = GiftsRepo();

  void deleteGiftForEvent({required String giftId}) async {
    emit(DeleteGiftForEventLoading());
    try {
      await _giftsRepo.deleteGift(giftId: giftId);
      emit(DeleteGiftForEventLoaded());
    } catch (e) {
      emit(DeleteGiftForEventError());
    }
  }
}
