import 'package:joyflo_project/core/data/models/domain_model.dart';
import 'dart:convert';
import 'package:chopper/chopper.dart';

part 'api_service.chopper.dart';

@ChopperApi()
abstract class ApiService extends ChopperService {
  @GET(path: '/api/v1/dom/simply-domain/get?type_domain=TYPE_QUESTION')
  Future<Response> fetchDomainsRaw();

  static ApiService create({required String baseUrl}) {
    final client = ChopperClient(
      baseUrl: Uri.parse(baseUrl),
      services: [
        _$ApiService(),
      ],
      converter: const JsonConverter(),
      interceptors: [
        HttpLoggingInterceptor(),
      ],
    );

    return _$ApiService(client);
  }

  /// Wrapper che ritorna DomainResponse correttamente deserializzato
  Future<DomainResponse> fetchDomains() async {
    final Response rawResponse = await fetchDomainsRaw();

    if (!rawResponse.isSuccessful) {
      throw Exception(
          "Errore API: ${rawResponse.statusCode} - ${rawResponse.error}");
    }

    final Map<String, dynamic> jsonMap =
        rawResponse.body is Map<String, dynamic>
            ? rawResponse.body
            : jsonDecode(rawResponse.bodyString);

    return DomainResponse.fromJson(jsonMap);
  }

  /// Metodo helper che ritorna la lista dei DomainData
  Future<List<DomainData>> fetchDomValues() async {
    final DomainResponse domainResponse = await fetchDomains();
    return domainResponse.data.values.toList();
  }
}
