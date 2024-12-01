import 'package:bloc/bloc.dart';
import 'package:hediety/3_model/models/gift.dart';
import 'package:hediety/3_model/repo/gifts_repo.dart';
import 'package:meta/meta.dart';

part 'get_gifts_for_event_state.dart';

class GetGiftsForEventCubit extends Cubit<GetGiftsForEventState> {
  GetGiftsForEventCubit() : super(GetGiftsForEventInitial());
  final GiftsRepo _giftsRepo = GiftsRepo();

  Future<void> getGiftsForEvent({required String eventId}) async {
    emit(GetGiftsForEventLoading());
    try {
      final gifts = await _giftsRepo.getAllGiftsForEvent(eventId: eventId);
      emit(GetGiftsForEventLoaded(gifts: gifts));
    } catch (e) {
      emit(GetGiftsForEventError());
    }
  }
}
