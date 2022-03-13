import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloctemplate/constants/database_path.dart';
import 'package:bloctemplate/utils/services/firestore_service.dart';

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
