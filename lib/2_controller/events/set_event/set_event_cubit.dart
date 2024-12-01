import 'package:bloc/bloc.dart';
import 'package:hediety/3_model/repo/events_repo.dart';
import 'package:meta/meta.dart';

import '../../../3_model/models/event.dart';

part 'set_event_state.dart';

class SetEventCubit extends Cubit<SetEventState> {
  SetEventCubit() : super(SetEventInitial());
  final EventsRepo _eventsRepo = EventsRepo();
  void setEvent(Event event) async {
    emit(SetEventLoading());
    try {
      await _eventsRepo.setEvent(event: event);

      emit(SetEventLoaded(event: event));
    } catch (e) {
      emit(SetEventError());
    }
  }
}
