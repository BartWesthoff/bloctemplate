import 'package:bloctemplate/src/utils/constants/database_path.dart';
import 'package:firebase_auth_repository/firebase_authentication_repository.dart';
import 'package:firestore_service/firestore_service.dart';

class Database {
  Database({required this.uid});

  // UID of user
  final String uid;
  final _service = FirestoreService.instance;

  Future<void> createFriend(AppUser friend) => _service.setData(
        path: DatabasePath.user(uid),
        data: {},
      );

  Future<void> deleteFriend(AppUser friend) async {
    await _service.deleteData(path: DatabasePath.user(uid));
  }
}
