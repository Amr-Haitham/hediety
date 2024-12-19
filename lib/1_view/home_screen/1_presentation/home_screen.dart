import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hediety/2_controller/get_all_friends/get_all_friends_cubit.dart';
import 'package:hediety/1_view/authentication/presentation/manager/authentication_op/authentication_op_cubit.dart';
import 'package:hediety/2_controller/get_latest_events_for_friends/get_latest_events_for_friends_cubit.dart';
import 'package:hediety/2_controller/notification_cubit.dart';
import 'package:hediety/3_data_layer/models/app_user.dart';
import '../../../../core/config/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/buttons/button_widget.dart';
import '../../../../core/widgets/text_fields/text_field.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import '../../../3_data_layer/models/notification.dart' as CustomNotifications;

import '../../../3_data_layer/models/event.dart';
import '../../../gen/assets.gen.dart';
import '../../../2_controller/get_single_app_user/get_single_appuser_cubit.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<GetLatestEventsForFriendsCubit>(context)
        .getLatestEventsForFriends();
    BlocProvider.of<GetSingleAppuserCubit>(context)
        .getSingleAppUser(); // Call the cubit to fetch the user data
    BlocProvider.of<NotificationCubit>(context).startListening();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationCubit, CustomNotifications.Notification?>(
      listener: (context, notification) {
        if (notification != null) {
          showNotificationDialog(context, notification);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: BlocBuilder<GetSingleAppuserCubit, GetSingleAppuserState>(
            builder: (context, state) {
              if (state is GetSingleAppuserLoading) {
                return const CircularProgressIndicator();
              } else if (state is GetSingleAppuserError) {
                return const Text('Error');
              }
              var appUser = (state as GetSingleAppuserLoaded).appUser;
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.profileScreenRoute);
                },
                child: Text(
                  appUser.name,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
          leading: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.transparent,
            backgroundImage: Assets.images.manSmiling1
                .provider(), // Replace with your image URL
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.red),
              onPressed: () {
                Navigator.pushNamed(context, Routes.notificationsScreenRoute);
              },
            ),
          ],
        ),
        body: Center(
          child: BlocBuilder<GetLatestEventsForFriendsCubit,
              GetLatestEventsForFriendsState>(
            builder: (context, state) {
              if (state is GetLatestEventsForFriendsLoading ||
                  state is GetLatestEventsForFriendsInitial) {
                return const CircularProgressIndicator();
              }
              if (state is GetLatestEventsForFriendsError) {
                return const Text('Error');
              }
              var loadedState = state as GetLatestEventsForFriendsLoaded;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SearchBar(),
                  const SizedBox(height: 20),
                  Expanded(
                    child: CardList(
                      cardsData: loadedState.friendToEvent,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // FloatingActionButton(
            //   onPressed: () {
            //     Navigator.pushNamed(context, Routes.eventFormScreenRoute);
            //   },
            //   child:  Icon(Icons.),
            // ),
            const SizedBox(width: 16),
            FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.allUsersScreenRoute);
              },
              child: const Icon(Icons.contacts),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search by name or email",
          prefixIcon: const Icon(Icons.search, color: Colors.black54),
          filled: true,
          fillColor: Colors.pink[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class CardList extends StatefulWidget {
  final Map<AppUser, Event> cardsData;

  const CardList({Key? key, required this.cardsData}) : super(key: key);

  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  @override
  Widget build(BuildContext context) {
    var allData = widget.cardsData.entries.toList();
    allData.removeWhere(
        (element) => element.key.id == FirebaseAuth.instance.currentUser!.uid);
    return ListView.separated(
        separatorBuilder: (context, index) => const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
        itemCount: allData.length,
        itemBuilder: (context, index) {
          final cardData = allData.elementAt(index);

          return EventCard(
            onTap: () {
              Navigator.pushNamed(context, Routes.giftsListScreenRoute,
                  arguments: cardData.value);
            },
            title: cardData.key.name,
            name: cardData.key.phoneNumber,
            date: cardData.value.date.toDate().toString().substring(0, 10),
            imageUrl: cardData.key.imageUrl,
            eventName: cardData.value.name,
          );
        });
  }
}

class EventCard extends StatefulWidget {
  final String title;
  final String name;
  final String date;
  final String? imageUrl;
  final String eventName;
  final Function()? onTap;

  const EventCard({
    Key? key,
    required this.title,
    required this.name,
    required this.onTap,
    required this.eventName,
    required this.date,
    this.imageUrl,
  }) : super(key: key);

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          color: Colors.pink[50],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                if (widget.imageUrl != null)
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.imageUrl!),
                    radius: 30,
                  )
                else
                  const CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 30,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.name,
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        widget.eventName,
                        style: const TextStyle(color: Colors.black54),
                      ),
                      Text(
                        widget.date,
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.card_giftcard, color: Colors.red, size: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
