import 'package:joyflo_project/core/data/models/domain_model.dart';
import 'package:joyflo_project/core/data/services/api_service.dart';

// Class for result of usecase
class GetDomainsResult {
  final List<DomainData>? domains;
  final String? error;

  GetDomainsResult({this.domains, this.error});

  bool get isSuccess => domains != null && error == null;
}

class GetDomainsUseCase {
  final ApiService apiService;

  GetDomainsUseCase({required this.apiService});

  // Principal method 
  Future<GetDomainsResult> execute() async {
    try {
      final List<DomainData> domains = await apiService.fetchDomValues();
      return GetDomainsResult(domains: domains);
    } on Exception catch (e) {
      return GetDomainsResult(error: e.toString());
    }
  }
}
