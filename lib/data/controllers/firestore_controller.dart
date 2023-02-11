import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/base/base_controller.dart';
import '../model/address_model.dart';
import '../model/user_model.dart';
import 'auth_controller.dart';

class FirestoreController extends GetxController {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference _ticketCollectionReference =
      FirebaseFirestore.instance.collection(tbTicket);

  static const String tbBooking = 'booking';
  static const String tbMyReviews = 'reviews';
  static const String tbMyComments = 'comments';
  static const String tbRequests = 'request';
  static const String tbMySupplyVehicle = 'my_supply_vehicles';
  static const String tbMyServices = 'my_services';
  static const String tbNotifications = 'notifications';
  static const String tbFilteredRequest = 'my_out_request';
  static const String tbTicket = 'ticket';


  final baseController = Get.find<BaseController>();

  Future createUser(UserModel user) async {
    try {
      await _usersCollectionReference
          .doc(user.userId)
          .set(user.toJson(), SetOptions(merge: true));
      return true;
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  final usersQuery = FirebaseFirestore.instance
      .collection('users')
      .orderBy('name')
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromMap(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  Query<UserModel> userSearchQuery(String searchKey) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: searchKey)
        .where('name', isLessThan: '${searchKey}z')
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromMap(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
  }

  Future<FirebaseResult> toggleUserIsActive(
      {required String userId, required bool isActive}) async {
    try {
      await _usersCollectionReference
          .doc(userId)
          .update({'isActive': isActive});
      return FirebaseResult(data: true);
    } catch (e) {
      return FirebaseResult.error(errorMessage: e.toString());
    }
  }

  Future<FirebaseResult> toggleUserIsMember(
      {required String userId, required bool isMember}) async {
    try {
      await _usersCollectionReference
          .doc(userId)
          .update({'isMember': isMember});
      return FirebaseResult(data: true);
    } catch (e) {
      return FirebaseResult.error(errorMessage: e.toString());
    }
  }

  Future deleteCurrentUser(String uid) async {
    try {
      await _usersCollectionReference.doc(uid).delete();
      return true;
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future<FirebaseResult> updateUser(
      {required UserModel user, required List<String> phone}) async {
    try {
      await _usersCollectionReference
          .doc(user.userId)
          .set(user.toJson(), SetOptions(merge: true));
      await _usersCollectionReference
          .doc(user.userId)
          .update({'phone': FieldValue.arrayUnion(phone)});
      return FirebaseResult(data: true);
    } catch (e) {
      return FirebaseResult.error(errorMessage: e.toString());
    }
  }

  Future<bool> isUserExists(String uid) async {
    var doc = await _usersCollectionReference.doc(uid).get();
    return doc.exists;
  }

  Stream<UserModel> streamUser(String uid) {
    var snap = _usersCollectionReference.doc(uid).snapshots();
    return snap.map((doc) => UserModel.fromSnapshot(doc));
  }

  Stream<List<UserModel>> streamAppUsers() {
    Stream<QuerySnapshot> snap = _usersCollectionReference
        .where('isAdmin', isEqualTo: false)
        .snapshots();

    return snap.map((snapshot) => snapshot.docs.map((doc) {
          return UserModel.fromSnapshot(doc);
        }).toList());
  }

  Stream<List<UserModel>> streamServiceProviders() {
    Stream<QuerySnapshot> snap = _usersCollectionReference
        .where('role', isEqualTo: 1)
        .limit(10)
        .snapshots();

    return snap.map((snapshot) => snapshot.docs.map((doc) {
          return UserModel.fromSnapshot(doc);
        }).toList());
  }

  Query userQuery(bool isProvider) => _usersCollectionReference
      .where('role', isEqualTo: isProvider ? 1 : 0)
      .orderBy('fName');

  Future<List<UserModel>> getServiceProviders() async {
    var snap = await _usersCollectionReference
        .where('role', isEqualTo: 1)
        .limit(10)
        .get();

    return snap.docs.map((e) => UserModel.fromSnapshot(e)).toList();
  }

  Future<UserModel> getUserById(String uid) async {
    var userData = await _usersCollectionReference.doc(uid).get();
    return UserModel.fromSnapshot(userData);
  }

  Future<FirebaseResult> updateUserCompany(
      {required String uid,
      required String comName,
      required String jobTitle,
      required String comAddress,
      required String comPhone,
      required String profile}) async {
    try {
      await _usersCollectionReference.doc(uid).update({
        'comName': comName,
        'job': jobTitle,
        'comAddress': comAddress,
        'comPhone': comPhone,
        'comId': profile
      });
      return FirebaseResult(data: true);
    } catch (e) {
      return FirebaseResult.error(errorMessage: e.toString());
    }
  }

  Future<FirebaseResult> updateUserProfile({required String profileUrl}) async {
    try {
      await _usersCollectionReference
          .doc(baseController.appUser?.userId ?? '')
          .update({'profileUrl': profileUrl});
      return FirebaseResult(data: true);
    } catch (e) {
      return FirebaseResult.error(errorMessage: e.toString());
    }
  }

  Future<FirebaseResult> updateUserData(
      {required String fName,
      required String lName,
      required Address? address,
      required int genderIndex}) async {
    try {
      await _usersCollectionReference
          .doc(baseController.appUser?.userId ?? '')
          .update({
        'fName': fName,
        'lName': lName,
        'address': address?.toJson(),
        'gender': genderIndex
      });
      return FirebaseResult(data: true);
    } catch (e) {
      return FirebaseResult.error(errorMessage: e.toString());
    }
  }

  Future<FirebaseResult> updateUserAddress({required Address address}) async {
    try {
      await _usersCollectionReference
          .doc(baseController.appUser?.userId ?? '')
          .update({'address': address.toJson()});
      return FirebaseResult(data: true);
    } catch (e) {
      return FirebaseResult.error(errorMessage: e.toString());
    }
  }

  Future<FirebaseResult> updateActiveInactive(
      {required String userId, required bool isActive}) async {
    try {
      await _usersCollectionReference.doc(userId).update({
        'isActive': !isActive,
      });
      return FirebaseResult(data: true);
    } catch (e) {
      return FirebaseResult.error(errorMessage: e.toString());
    }
  }

  Future<FirebaseResult> getUser(String uid) async {
    try {
      var userData = await _usersCollectionReference.doc(uid).get();
      return FirebaseResult(data: UserModel.fromSnapshot(userData));
    } catch (e) {
      if (e is PlatformException) {
        return FirebaseResult.error(errorMessage: e.message.toString());
      }

      return FirebaseResult.error(errorMessage: e.toString());
    }
  }

  Stream<List<UserModel>> searchUsers(
      {int limit = 10, required String searchKey}) {
    Stream<QuerySnapshot> snap = searchKey.isNotEmpty
        ? _usersCollectionReference
            .where('name', isGreaterThanOrEqualTo: searchKey)
            .where('name', isLessThan: '${searchKey}z')
            .limit(limit)
            .snapshots()
        : _usersCollectionReference.limit(limit).snapshots();

    return snap.map((snapshot) =>
        snapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).toList());
  }

  ///bookings

  Query ticketQuery() => _ticketCollectionReference.orderBy('createdAt');
}
