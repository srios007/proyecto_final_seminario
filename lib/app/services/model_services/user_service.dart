import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_final_seminario/app/services/services.dart';
import 'package:proyecto_final_seminario/app/utils/utils.dart';
import '../../models/models.dart';
import '../../models/user_model.dart';
import '../firebase_services/database_service.dart';

class UserService {
  static String userReference = firebaseReferences.clients;
  static String addressReference = firebaseReferences.addresses;

  static final UserService _instance = UserService._internal();

  factory UserService() {
    return _instance;
  }

  UserService._internal();
  var firestore = FirebaseFirestore.instance;

  //Para paginacion
  DocumentSnapshot? lastDocument;

  Future<bool> saveUser({
    required User user,
    required String customId,
  }) async {
    try {
      user.created = DateTime.now();

      await database.saveUserWithCustomIdAndSubcollection(
        user.toJson(),
        userReference,
        customId,
      );

      return true;
    } on Exception catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> delete(User user) async {
    try {
      await database.deleteDocument(user.id, userReference);
      return true;
    } on Exception catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> update(User user) async {
    try {
      DocumentReference docRef = database.getDocumentReference(
        collection: userReference,
        documentId: user.id!,
      );

      await docRef.update(user.toJson());
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<User?> getUserDocumentById(
    String documentId,
  ) async {
    try {
      print(documentId);
      var querySnapshot = await database.getDocument(
        collection: 'clients',
        documentId: documentId,
      );

      if (!querySnapshot.exists) {
        await auth.signOut();
        return User();
      }

      return User.fromJson(
        querySnapshot.data() as Map<String, dynamic>,
      );
    } catch (e) {
      print(e);
    }
  }

  Future<User?> getUserDocumentByPhoneNumber(
    String phoneNumber,
  ) async {
    dynamic userJson;

    var querySnapshot = await database.getCollection(
      'users',
      'contactInfo.phoneNumber.basePhoneNumber',
      phoneNumber,
    );
    if (querySnapshot.docs.isEmpty) return null;
    for (var user in querySnapshot.docs) {
      userJson = user.data();
    }
    return User.fromJson(
      userJson as Map<String, dynamic>,
    );
  }

  Future<User?> getCurrentUser() async {
    try {
      var currentFirebaseUser = auth.getCurrentUser();
      print('UID: ${currentFirebaseUser!.uid}');
      var user = await getUserDocumentById(
        currentFirebaseUser.uid,
      );
      if (user == null) {
        return User();
      } else {
        return user;
      }
    } catch (e) {
      print(e);
    }
  }
}

UserService userService = UserService();
