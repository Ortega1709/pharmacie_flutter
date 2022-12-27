import 'package:firedart/firestore/firestore.dart';
import 'package:firedart/firestore/models.dart';
import 'package:pharmacie/model/utilisateur_model.dart';

/// user repository
class UtilisateurRepository {
  final CollectionReference _utilisateurCollection = Firestore
      .instance.collection("utilisateur");

  UtilisateurRepository();

  /// save user
  save({required UtilisateurModel utilisateurModel}) {
    final data = UtilisateurModel(
        nom: utilisateurModel.nom,
        email: utilisateurModel.email,
        mdp: utilisateurModel.mdp,
        type: utilisateurModel.type).toJson();

    _utilisateurCollection.add(data);

  }

  /// update user with id
  update({required String id, required UtilisateurModel utilisateurModel}) {

    final data = UtilisateurModel(
        nom: utilisateurModel.nom,
        email: utilisateurModel.email,
        mdp: utilisateurModel.mdp,
        type: utilisateurModel.type)
        .toJson();

    _utilisateurCollection.document(id).update(data);

  }

  /// delete user with id
  delete({required String id})  => _utilisateurCollection.document(id).delete();

  /// get all user
  Future<List<Document>> get() async => await _utilisateurCollection.get();

}
