import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:myapp/src/network/data/sign/sign_repository.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/common/error_code.dart';
import 'package:myapp/src/network/model/social_user/social_user.dart';
import 'package:myapp/src/network/model/user/user.dart';
import 'package:myapp/src/services/firebase_message.dart';
import 'package:myapp/src/services/firebase_storage.dart';

import '../../model/common/result.dart';

class SignRepositoryImpl extends SignRepository {
  static const String avatarDefault =
      "https://firebasestorage.googleapis.com/v0/b/see-joy-3f334.appspot.com/o/avatar%2Fnot_avatar%2Favatar_default.png?alt=media&token=c4453031-ccc3-449f-a267-aaed55782701";

  @override
  Future<MResult<MUser>> connectBEWithApple(MSocialUser user) {
    throw UnimplementedError();
  }

  @override
  Future<MResult<MUser>> connectBEWithFacebook(MSocialUser user) async {
    try {
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(user.accessToken!);
      final UserCredential result = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      final firebaseUser = result.user;

      final newUser = MUser(
        id: firebaseUser?.uid ?? '',
        email: firebaseUser?.email,
        name: firebaseUser?.displayName,
        avatar: firebaseUser?.photoURL,
        followers: [],
        followed: [],
      );
      final userResult = await DomainManager().user.getOrAddUser(newUser);
      if (userResult.isSuccess) {
        if (!userResult.data!.fcmToken
            .contains(XFirebaseMessage.instance.currentToken)) {
          await DomainManager().user.updateFCMTokenUser(newUser.id);
          final List<String> newTokens = [
            ...userResult.data!.fcmToken,
            XFirebaseMessage.instance.currentToken ?? ""
          ];
          return MResult.success(
              userResult.data!.copyWith(fcmToken: newTokens));
        }
      }
      return MResult.success(userResult.data ?? newUser);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  @override
  Future<MResult<MUser>> connectBEWithGoogle(MSocialUser user) async {
    try {
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
          accessToken: user.accessToken, idToken: user.idToken);
      // Once signed in, return the UserCredential
      final UserCredential result =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final firebaseUser = result.user;
      final newUser = MUser(
        id: firebaseUser?.uid ?? '',
        email: user.email,
        name: firebaseUser?.displayName ?? user.fullName,
        avatar: firebaseUser?.photoURL ?? user.avatar,
        followers: [],
        followed: [],
      );

      final userResult = await DomainManager().user.getOrAddUser(newUser);
      if (userResult.isSuccess) {
        if (!userResult.data!.fcmToken
            .contains(XFirebaseMessage.instance.currentToken)) {
          await DomainManager().user.updateFCMTokenUser(newUser.id);
          final List<String> newTokens = [
            ...userResult.data!.fcmToken,
            XFirebaseMessage.instance.currentToken ?? ""
          ];
          return MResult.success(
              userResult.data!.copyWith(fcmToken: newTokens));
        }
      }

      return MResult.success(userResult.data ?? newUser);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  @override
  Future<MResult<String>> forgotPassword(String email) {
    throw UnimplementedError();
  }

  @override
  Future<MResult> logOut(MUser user) async {
    try {
      await DomainManager().user.removeFCMTokenUser(user.id);
      await XFirebaseMessage.instance.unregisterTokenFCM();
      await FirebaseAuth.instance.signOut();
      return MResult.success(user);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  @override
  Future<MResult<MSocialUser>> loginWithApple() {
    throw UnimplementedError();
  }

  @override
  Future<MResult<MUser>> loginWithEmail(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final firebaseUser = credential.user;

      final newUser = MUser(
        id: firebaseUser?.uid ?? '',
        email: firebaseUser?.email,
        name: firebaseUser?.displayName,
        avatar: firebaseUser?.photoURL,
        followers: [],
        followed: [],
      );
      final userResult = await DomainManager().user.getOrAddUser(newUser);
      if (userResult.isSuccess) {
        if (!userResult.data!.fcmToken
            .contains(XFirebaseMessage.instance.currentToken)) {
          await DomainManager().user.updateFCMTokenUser(newUser.id);
          final List<String> newTokens = [
            ...userResult.data!.fcmToken,
            XFirebaseMessage.instance.currentToken ?? ""
          ];
          return MResult.success(
              userResult.data!.copyWith(fcmToken: newTokens));
        }
      }
      return MResult.success(userResult.data ?? newUser);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return MResult.exception(e.code);
    }
  }

  @override
  Future<MResult<MSocialUser>> loginWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance
          .login(permissions: ['email', 'public_profile']);

      return MResult.success(
          MSocialUser.fromFacebookAccount({}, loginResult.accessToken!));
    } catch (e) {
      return MResult.exception(e);
    }
  }

  @override
  Future<MResult<MSocialUser>> loginWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final bool isSignedIn = await googleSignIn.isSignedIn();
      if (isSignedIn) {
        await googleSignIn.signOut();
      }
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      if (googleUser != null && googleAuth != null) {
        return MResult.success(
            MSocialUser.fromGoogleAccount(googleUser, googleAuth));
      } else {
        return MResult.error(MErrorCode.unknown);
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }

  @override
  Future<MResult> removeAccount(MUser user) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      user?.delete();
      return MResult.success(user);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  @override
  Future<MResult<MUser>> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user?.updateDisplayName(name);
      await credential.user?.updatePhotoURL(avatarDefault);

      final firebaseUser = credential.user;
      final newUser = MUser(
        id: firebaseUser?.uid ?? '',
        email: firebaseUser?.email,
        name: name,
        avatar: avatarDefault,
        followers: [],
        followed: [],
      );
      final userResult = await DomainManager().user.getOrAddUser(newUser);
      if (userResult.isSuccess) {
        if (!userResult.data!.fcmToken
            .contains(XFirebaseMessage.instance.currentToken)) {
          await DomainManager().user.updateFCMTokenUser(newUser.id);
          final List<String> newTokens = [
            ...userResult.data!.fcmToken,
            XFirebaseMessage.instance.currentToken ?? ""
          ];
          return MResult.success(
              userResult.data!.copyWith(fcmToken: newTokens));
        }
      }
      return MResult.success(userResult.data ?? newUser);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return MResult.exception(e.code);
    } catch (e) {
      print(e);
      return MResult.exception(e);
    }
  }

  Future<MResult> updateProfile([String? image, String? name]) async {
    try {
      if (name != null) {
        await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
      }
      String? imageUrl;
      if (image != null) {
        XFirebaseStorage firebaseStorage = XFirebaseStorage();
        imageUrl = await firebaseStorage.uploadImage(
            image, 'avatar/${FirebaseAuth.instance.currentUser?.uid}');
        await FirebaseAuth.instance.currentUser?.updatePhotoURL(imageUrl);
      }
      final userResult = await DomainManager().user.updateUser(
          FirebaseAuth.instance.currentUser?.uid ?? "", imageUrl, name);

      if (userResult.isSuccess) {
        return MResult.success(imageUrl);
      }
      return userResult;
    } catch (e) {
      return MResult.exception(e);
    }
  }
}
