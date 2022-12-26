import 'package:firedart/firestore/firestore.dart';
import 'package:firedart/firestore/models.dart';
import 'package:pharmacie/model/utilisateur_model.dart';

/// user repository
class UtilisateurRepository {
  late CollectionReference utilisateurCollection =
  Firestore.instance.collection("utilisateur");

  UtilisateurRepository();

  /// save user
  save({required UtilisateurModel utilisateurModel}) {
    final data = UtilisateurModel(
        nom: utilisateurModel.nom,
        email: utilisateurModel.email,
        mdp: utilisateurModel.mdp,
        type: utilisateurModel.type)
        .toJson();

    utilisateurCollection.add(data);

  }

  /// update user with id
  update({required String id, required UtilisateurModel utilisateurModel}) {

    final data = UtilisateurModel(
        nom: utilisateurModel.nom,
        email: utilisateurModel.email,
        mdp: utilisateurModel.mdp,
        type: utilisateurModel.type)
        .toJson();

    utilisateurCollection.document(id).update(data);

  }

  /// delete utilisateur with id
  delete({required String id})  => utilisateurCollection.document(id).delete();

  /// get all utilisateurs
  Future<List<Document>> get() async => await utilisateurCollection.get();

}
