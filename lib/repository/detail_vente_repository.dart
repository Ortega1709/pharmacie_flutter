
import 'package:firedart/firedart.dart';
import 'package:pharmacie/model/detail_vente_model.dart';

/// detail vente repository
class DetailVenteRepository {
  
  final CollectionReference _detailVenteCollection = Firestore
      .instance.collection("detailVente");

  DetailVenteRepository();

  /// save detail sale
  save({required DetailVenteModel detailVenteModel}) {

    final data = DetailVenteModel(
        idProduit: detailVenteModel.idProduit,
        idVente: detailVenteModel.idVente,
        qte: detailVenteModel.qte,
        total: detailVenteModel.total)
        .toJson();

    _detailVenteCollection.add(data);

  }

  /// get all detail vente of one sale with id
  get({required String id}) async => _detailVenteCollection.get();
}