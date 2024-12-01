import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hediety/3_model/models/event.dart';
import 'package:meta/meta.dart';

import '../../../3_model/repo/events_repo.dart';

part 'get_user_events_state.dart';

class GetUserEventsCubit extends Cubit<GetUserEventsState> {
  GetUserEventsCubit() : super(GetUserEventsInitial());
  final EventsRepo _eventsRepo = EventsRepo();
  void getUserEvents({required String uid}) async{
    emit(GetUserEventsLoading());
    try {
      List<Event> events = [];
      events = await _eventsRepo .getAllEventsForAppUser(uid: uid);
      emit(GetUserEventsLoaded(events: events));
    } catch (e) {
      emit(GetUserEventsError());
    }
  }
}
