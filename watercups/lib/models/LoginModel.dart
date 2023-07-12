import 'package:firebase_auth/firebase_auth.dart';

class AuthManage {
  Future<bool> createUser(String email, String pw) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pw);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print("The account already exists for that email.");
      }
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  Future<bool> signIn(String email, String pw) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pw);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print("Wrong password provided for that user.");
      }
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  //회원가입, 로그인시 사용자 영속
  void authPersistence() async {
    await FirebaseAuth.instance.setPersistence(Persistence.NONE);
  }

  //유저 삭제
  Future<void> deleteUser(String email) async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.delete();
  }

  //현재 유저 정보 조회
  User? getUser() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final name = user.displayName;
      final email = user.email;
      final photoUrl = user.photoURL;

      final emailVerified = user.emailVerified;
      final uid = user.uid;
    }
    return user;
  }

  //공급자로부터 유저 정보 조회
  User? getUserFromSocial() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      for (final providerProfile in user.providerData) {
        final provider = providerProfile.providerId;
        final uid = providerProfile.uid;
        final name = providerProfile.displayName;
        final emailAddress = providerProfile.email;
        final profilePhoto = providerProfile.photoURL;
      }
    }
    return user;
  }

  /// 유저 url 업데이트
  Future<void> updateProfileUrl(String url) async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.updatePhotoURL(url);
  }

  /// 비밀번호 초기화 메일보내기
  Future<void> sendPasswordResetEmail(String email) async {
    await FirebaseAuth.instance.setLanguageCode("kr");
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
