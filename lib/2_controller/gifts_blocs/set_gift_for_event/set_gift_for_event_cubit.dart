import 'package:bloc/bloc.dart';
import 'package:hediety/3_data_layer/models/gift.dart';
import 'package:hediety/3_data_layer/repo/gifts_repo.dart';
import 'package:meta/meta.dart';

part 'set_gift_for_event_state.dart';

class SetGiftForEventCubit extends Cubit<SetGiftForEventState> {
  SetGiftForEventCubit() : super(SetGiftForEventInitial());
  final GiftsRepo _giftsRepo = GiftsRepo();

  void setGift({required Gift gift}) async {
    emit(SetGiftForEventLoading());
    try {
      await _giftsRepo.setGift(gift: gift);
      emit(SetGiftForEventLoaded());
    } catch (e) {
      emit(SetGiftForEventError());
    }

  }
}
