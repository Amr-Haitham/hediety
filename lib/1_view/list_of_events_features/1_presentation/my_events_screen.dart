import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hediety/2_controller/events/delete_event/delete_event_cubit.dart';
import 'package:hediety/2_controller/events/get_user_events/get_user_events_cubit.dart';
import 'package:hediety/2_controller/events/set_event/set_event_cubit.dart';
import 'package:hediety/core/config/app_router.dart';

import '../../../core/utils/auth_utils.dart';

class MyEventsScreen extends StatefulWidget {
  @override
  State<MyEventsScreen> createState() => _MyEventsScreenState();
}

class _MyEventsScreenState extends State<MyEventsScreen> {
  @override
  void initState() {
    BlocProvider.of<GetUserEventsCubit>(context)
        .getUserEvents(uid: AuthUtils.getCurrentUserUid());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SetEventCubit, SetEventState>(
          listener: (context, state) {
            BlocProvider.of<GetUserEventsCubit>(context)
                .getUserEvents(uid: AuthUtils.getCurrentUserUid());
          },
        ),
        BlocListener<DeleteEventCubit, DeleteEventState>(
          listener: (context, state) {
            BlocProvider.of<GetUserEventsCubit>(context)
                .getUserEvents(uid: AuthUtils.getCurrentUserUid());
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous screen
            },
          ),
          title: const Text(
            "My events",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: BlocBuilder<GetUserEventsCubit, GetUserEventsState>(
                builder: (context, state) {
                  if (state is GetUserEventsError) {
                    return Text("error");
                  } else if (state is GetUserEventsLoaded) {
                    if (state.events.isEmpty) {
                      return const Center(child: Text("No events yet"));
                    }

                    return ListView.separated(
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      itemCount: state.events.length,
                      itemBuilder: (context, index) {
                        return ListButton(
                          label: state.events[index].name,
                          onDelete: () {
                            BlocProvider.of<DeleteEventCubit>(context)
                                .deleteEvent(eventId: state.events[index].id);
                          },
                          onEdit: () {
                            Navigator.pushNamed(
                                context, Routes.eventFormScreenRoute,
                                arguments: state.events[index]);
                          },
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Routes.giftsListScreenRoute,
                                arguments: state.events[index]);
                          },
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: AddButton(),
            ),
          ],
        ),
      ),
    );
  }
}

class ListButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final Function() onDelete;
  final Function() onEdit;

  const ListButton({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.red,
              ),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, Routes.eventFormScreenRoute);
        },
        child: const Text(
          "Add",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
