import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../core/base/base_controller.dart';
import '../model/user_model.dart';
import 'firestore_controller.dart';
import 'local_storage_controller.dart';

class AuthenticationController extends GetxController {
  static const String isLogged = 'is_logged';
  static const String token = 'token';

  final localStorage = Get.find<LocalStorageController>();
  final  _firebaseAuth = FirebaseAuth.instance;
  final  _fireService = Get.find<FirestoreController>();
  final baseController = Get.find<BaseController>();

  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  bool isUserLogged() => localStorage.isUserLogged;

  Future saveUserToken(String token) async {}



  Future<FirebaseResult> isUserLoggedIn() async {
    try {
      var user = _firebaseAuth.currentUser;
      return FirebaseResult(data: user!=null);
    } catch (e) {
      return FirebaseResult.error(errorMessage: e.toString());
    }
  }

  Future<FirebaseResult> populateCurrentUser(String uid) async {
    var result = await _fireService.getUser(uid);
    if (!result.hasError) {
      _currentUser = result.data;
      baseController.appUser = _currentUser;
      return FirebaseResult(data: result);
    } else {
      return FirebaseResult(data: null);
    }
  }


  Future<FirebaseResult> createNewUserForEmail(String name) async {
    //create-user in firestore after sign up with firebase
    final firebaseUser = _firebaseAuth.currentUser;
    final user = UserModel(
        name: name,
        email: firebaseUser?.email??'',
        userId: firebaseUser?.uid??'',
        createdDate: Timestamp.now());

    var result = await _fireService.createUser(user);

    if (result is bool) {
      _currentUser = user;
      //assign user to base controller user variable to use across the app
      baseController.appUser = _currentUser;
      return FirebaseResult(data: true);
    } else {
      return FirebaseResult.error(errorMessage: 'text001'.tr);
    }
  }

  Future signOut() async {
    localStorage.userToken = '';
    baseController.appUser = null;
    await _firebaseAuth.signOut();
  }

  Future deleteUserProfile() async {
    await _fireService.deleteCurrentUser(baseController.appUser?.userId ?? '');
    baseController.appUser = null;
    await _firebaseAuth.currentUser?.delete();
    // Get.offAll(() => const SignInView());
  }
}

class FirebaseResult {
  final dynamic data;

  /// Contains the error message for the request
  final String errorMessage;

  FirebaseResult({this.data}) : errorMessage = '';

  FirebaseResult.error({required this.errorMessage}) : data = null;

  /// Returns true if the response has an error associated with it
  bool get hasError => errorMessage.isNotEmpty;
}
