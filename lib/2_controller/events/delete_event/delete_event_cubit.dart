import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../3_model/models/event.dart';
import '../../../3_model/repo/events_repo.dart';
import '../../../3_model/repo/gifts_repo.dart';

part 'delete_event_state.dart';

class DeleteEventCubit extends Cubit<DeleteEventState> {
  DeleteEventCubit() : super(DeleteEventInitial());
  final _eventsRepo = EventsRepo();

  void deleteEvent({required String eventId})async {
    try {
      emit(DeleteEventLoading());
      await _eventsRepo.deleteEvent(eventId: eventId);
      emit(DeleteEventLoaded(eventId: eventId));
    } catch (e) {
      emit(DeleteEventError());
    }


  }
}