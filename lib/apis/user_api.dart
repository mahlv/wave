import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/appwrite.dart';
import 'package:fpdart/fpdart.dart';
import 'package:soundtt/constants/constants.dart';
import 'package:soundtt/core/core.dart';
import 'package:soundtt/core/providers.dart';
import 'package:soundtt/models/user_model.dart';

final userAPIProvider = Provider((ref) {
  return UserAPI(db: ref.watch(appwriteDatabaseProvider),
  );
});

abstract class IUserAPI{
  FutureEitherVoid saveUserData(UserModel userModel);
  Future<model.Document> getUserData(String uid);
}

class UserAPI implements IUserAPI {
  final Databases _db;
  UserAPI({required Databases db}) : _db = db;

  @override
  FutureEitherVoid saveUserData(UserModel userModel) async {
    try {
       await _db.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.usersCollection, 
        documentId: userModel.uid, 
        data: userModel.toMap(),
        );
        return right(null);
      } on AppwriteException catch (e, st) {
        return left(Failure(
          e.message??'Some unexpected error occurred', 
          st,
          )
        );
    } catch (e, st) {
              return left(Failure(
          e.toString(),
          st,
          )
        );

    }
  }
  
  @override
  Future<model.Document> getUserData(String uid) {
    return _db.getDocument(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.usersCollection,
      documentId: uid,
    );
  }

}