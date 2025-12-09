import 'package:joyflo_project/core/data/models/domain_model.dart';
import 'package:joyflo_project/core/data/services/api_service.dart';

/// Classe che rappresenta il risultato dell'UseCase
class GetDomainsResult {
  final List<DomainData>? domains;
  final String? error;

  GetDomainsResult({this.domains, this.error});

  bool get isSuccess => domains != null && error == null;
}

class GetDomainsUseCase {
  final ApiService apiService;

  GetDomainsUseCase({required this.apiService});

  /// Metodo principale dell'use case
  Future<GetDomainsResult> execute() async {
    try {
      final List<DomainData> domains = await apiService.fetchDomValues();
      return GetDomainsResult(domains: domains);
    } on Exception catch (e) {
      // Cattura tutte le eccezioni e ritorna un messaggio leggibile
      return GetDomainsResult(error: e.toString());
    }
  }
}
