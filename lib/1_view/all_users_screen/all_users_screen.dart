import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hediety/2_controller/follow_un_follow/follow_unfollow_cubit.dart';
import 'package:hediety/2_controller/get_all_friends/get_all_friends_cubit.dart';
import 'package:hediety/1_view/authentication/presentation/manager/authentication_op/authentication_op_cubit.dart';
import 'package:hediety/3_data_layer/models/app_user.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/config/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/buttons/button_widget.dart';
import '../../../../core/widgets/text_fields/text_field.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../3_data_layer/models/friend.dart';
import '../../2_controller/get_all_users_cubit/get_all_users_cubit.dart';

class AllUsersScreen extends StatefulWidget {
  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  @override
  void initState() {
    BlocProvider.of<GetAllUsersCubit>(context).getAllUsers();
    BlocProvider.of<GetAllFriendsCubit>(context).getAllFriends();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Friends"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<GetAllUsersCubit, GetAllUsersState>(
              builder: (context, parentState) {
                if (parentState is GetAllUsersLoading) {
                  return const CircularProgressIndicator();
                }
                if (parentState is GetAllUsersError) {
                  return const Text('Error');
                }
                var users = (parentState as GetAllUsersLoaded).users;
                return BlocBuilder<GetAllFriendsCubit, GetAllFriendsState>(
                  builder: (context, state) {
                    if (state is GetAllFriendsLoading ||
                        state is GetAllFriendsInitial) {
                      return const CircularProgressIndicator();
                    }
                    if (state is GetAllFriendsError) {
                      return const Text('Error');
                    }
                    var friends = (state as GetAllFriendsLoaded).friends;
                    var allFriends = friends;

                    allFriends.removeWhere((friend) =>
                        friend.friendId ==
                        FirebaseAuth.instance.currentUser!.uid);

                    return CardList(
                      cardsData: users,
                      friends: friends,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CardList extends StatefulWidget {
  final List<AppUser> cardsData;
  final List<Friend> friends;
  const CardList({Key? key, required this.cardsData, required this.friends})
      : super(key: key);

  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  @override
  Widget build(BuildContext context) {
    widget.cardsData.removeWhere(
        (element) => element.id == FirebaseAuth.instance.currentUser!.uid);
    return BlocListener<FollowUnfollowCubit, FollowUnfollowState>(
      listener: (context, state) {
        if (state is FollowUnfollowSuccess) {
          BlocProvider.of<GetAllFriendsCubit>(context).getAllFriends();
        }
      },
      child: Column(
        children: widget.cardsData.map((cardData) {
          return EventCard(
            isFriend:
                widget.friends.map((e) => e.friendId).contains(cardData.id),
            id: cardData.id,
            onTap: (friendId) {
              if (widget.friends.map((e) => e.friendId).contains(friendId)) {
                BlocProvider.of<FollowUnfollowCubit>(context)
                    .removeFriend(friendId: friendId);
              } else {
                BlocProvider.of<FollowUnfollowCubit>(context).addFriend(
                    friend: Friend(
                        friendId: friendId,
                        userId: FirebaseAuth.instance.currentUser!.uid,
                        id: const Uuid().v1()));
              }
            },
            title: cardData.name,
            name: cardData.phoneNumber,
            date: cardData.phoneNumber,
            imageUrl: cardData.imageUrl,
          );
        }).toList(),
      ),
    );
  }
}

class EventCard extends StatefulWidget {
  final String title;
  final String name;
  final String date;
  final String? imageUrl;
  final Function(String) onTap;
  final String id;
  final bool isFriend;

  const EventCard({
    Key? key,
    required this.title,
    required this.name,
    required this.onTap,
    required this.id,
    required this.date,
    required this.isFriend,
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
                      widget.date,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
              TextButton(
                  onPressed: () => widget.onTap(widget.id),
                  child: Text(
                    widget.isFriend ? "Remove friend" : "Add friend",
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
