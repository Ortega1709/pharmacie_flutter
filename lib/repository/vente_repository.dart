
import 'package:firedart/firedart.dart';
import 'package:pharmacie/model/vente_model.dart';

/// vente repository
class VenteRepository {

  final CollectionReference _venteCollection = Firestore
      .instance.collection("vente");

  VenteRepository();

  /// save sale
  save({required VenteModel venteModel}) {
    final data = VenteModel(
        idUtilisateur: venteModel.idUtilisateur,
        total: venteModel.total,
        date: venteModel.date)
        .toJson();

    _venteCollection.add(data);
  }

  /// get all sales
  Future<List<Document>> get() async => _venteCollection.get();
}