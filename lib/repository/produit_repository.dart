import 'package:firedart/firedart.dart';
import 'package:pharmacie/model/produit_model.dart';

/// product repository
class ProduitRepository {

  final CollectionReference _produitReference = Firestore
      .instance.collection("produit");

  ProduitRepository();

  /// save product
  save({required ProduitModel produitModel}) {
    final data = ProduitModel(
        nom: produitModel.nom,
        pu: produitModel.pu,
        qte: produitModel.qte,
        dateExp: produitModel.dateExp).toJson();

    _produitReference.add(data);
  }

  /// update product with id
  update({required String id, required ProduitModel produitModel}) {
    final data = ProduitModel(
        nom: produitModel.nom,
        pu: produitModel.pu,
        qte: produitModel.qte,
        dateExp: produitModel.dateExp).toJson();

    _produitReference.document(id).update(data);
  }

  /// delete product with id
  delete({required String id}) => _produitReference.document(id).delete();

  /// get all products
  Future<List<Document>> get() async => _produitReference.get();

}