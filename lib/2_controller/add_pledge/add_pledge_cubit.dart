import 'package:bloc/bloc.dart';
import 'package:hediety/3_data_layer/models/notification.dart';
import 'package:hediety/3_data_layer/repo/notifications_repo.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../3_data_layer/models/pledge.dart';
import '../../3_data_layer/repo/pledges_repo.dart';

part 'add_pledge_state.dart';

class AddPledgeCubit extends Cubit<AddPledgeState> {
  AddPledgeCubit() : super(AddPledgeInitial());
  final PledgesRepo _pledgesRepo = PledgesRepo();
  final NotificationsRepo _notificationsRepo = NotificationsRepo();
  void addPledge({required Pledge pledge}) async {
    emit(AddPledgeLoading());
    try {
      await _pledgesRepo.setPledge(pledge: pledge);
      await _notificationsRepo.setNotification(
          userId: pledge.giftOwnerId,
          notification: Notification(
            id: const Uuid().v4(),
            title: 'New Pledge!',
            body: 'You have a new pledge',
            createdAt: DateTime.now(),
          ));
      emit(AddPledgeSuccess());
    } catch (e) {
      emit(AddPledgeError());
    }
  }
}
