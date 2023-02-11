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

  Future<FirebaseResult> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await populateCurrentUser(authResult.user!.uid);
      return FirebaseResult(data: authResult.user);
    } on FirebaseAuthException catch (e) {
      var msg = 'Sorry! Please try again later';
      if (e.code == 'user-not-found') {
        msg = 'No user found for the email.';
      } else if (e.code == 'wrong-password') {
        msg = 'Wrong password provided';
      }
      return FirebaseResult.error(errorMessage: msg);
    }
  }

  Future<FirebaseResult> sendEmailVerification(email, password) async {
    try {
      var user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user.user?.emailVerified ?? false) {
        await user.user?.sendEmailVerification();
      }

      return FirebaseResult(data: true);
    } catch (e) {
      return FirebaseResult.error(errorMessage: e.toString());
    }
  }

  Future<FirebaseResult> resendEmailVerification() async {
    try {
      User? user = _firebaseAuth.currentUser;

      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }

      return FirebaseResult(data: true);
    } catch (e) {
      return FirebaseResult.error(errorMessage: e.toString());
    }
  }

  Future<FirebaseResult> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return FirebaseResult(data: true);
    } catch (e) {
      return FirebaseResult.error(errorMessage: e.toString());
    }
  }

  Future<FirebaseResult> signUpUserWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return await createNewUserForEmail(UserModel(
          name: email,
          email: email,
          isAdmin:true,
          userId: authResult.user!.uid,
          createdDate: Timestamp.now(),
          address: null,
          role: null));
    } on FirebaseAuthException catch (e) {
      var msg = 'Sorry! Please try again later';
      if (e.code == 'weak-password') {
        msg = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        msg = 'The account already exists for that email.';
      }
      return FirebaseResult.error(errorMessage: msg);
    }
  }

  Future<FirebaseResult> sendEmailLink() async {
    try {
      User? user = _firebaseAuth.currentUser;

      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
      return FirebaseResult(data: true);
    } on FirebaseAuthException catch (e) {
      return FirebaseResult.error(errorMessage: e.message ?? '');
    }
  }

  Future<bool> isEmailVerified() async {
    try {
      await _firebaseAuth.currentUser?.reload();
      return _firebaseAuth.currentUser?.emailVerified ?? false;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }



  Future<FirebaseResult> isUserLoggedIn() async {
    try {
      var user = _firebaseAuth.currentUser;
      return FirebaseResult(data: user!=null);
    } catch (e) {
      return FirebaseResult.error(errorMessage: e.toString());
    }
  }

  Future<FirebaseResult> populateCurrentUser(String uid) async {
    await updateUserPlayerId(uid);
    var result = await _fireService.getUser(uid);
    if (!result.hasError) {
      _currentUser = result.data;
      baseController.appUser = _currentUser;
      return FirebaseResult(data: result);
    } else {
      return FirebaseResult(data: null);
    }
  }

  Future updateUserPlayerId(uid) async {
    // var playerId = await _notificationService.getPlayerId();
    // awaitit _fireService.updatePlayerId(playerId: playerId, uid: uid);
  }

  Future<FirebaseResult> createNewUserForEmail(UserModel userModel) async {
    var result = await _fireService.createUser(userModel);
    if (result is bool) {
      _currentUser = userModel;
      baseController.appUser = _currentUser;
      return FirebaseResult(data: userModel);
    } else {
      return FirebaseResult.error(errorMessage: 'error_common'.tr);
    }
  }

  Future signOut() async {
    localStorage.userToken = '';
    baseController.appUser = null;
    await _firebaseAuth.signOut();
  }

  Future deleteUserProfile() async {
    await _fireService.deleteCurrentUser(baseController.appUser?.userId ?? '');
    localStorage.userToken = '';
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
