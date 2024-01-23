import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/core/models/user_model.dart';

abstract class FollowingAndFollowersDataSource {
  Future<QuerySnapshot<Map<String, dynamic>>> getFollowersList();

  Future<QuerySnapshot<Map<String, dynamic>>> getFollowingList();

  Future<void> follow({required UserModel user});

  Future<void> unfollow({required UserModel user});

  Stream<bool> userIsFollowed({required UserModel user});
}
