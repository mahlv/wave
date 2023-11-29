import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:soundtt/constants/appwrite_constants.dart';
import 'package:soundtt/core/core.dart';
import 'package:soundtt/core/providers.dart';
import 'package:soundtt/models/wave_model.dart';

final waveAPIProvider = Provider((ref) {
  return WaveAPI(
    db: ref.watch(
      appwriteDatabaseProvider,
  
  ));
});

abstract class IWaveAPI {
  FutureEither<Document> shareWave(Wave wave);
}

class WaveAPI implements IWaveAPI {
  final Databases _db;
  WaveAPI({required Databases db}) : _db = db;
  @override
  FutureEither<Document> shareWave(Wave wave) async {
       try {
      final document = await _db.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.wavesCollection, 
        documentId: ID.unique(), 
        data: wave.toMap(),
        );
        return right(document);
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
}