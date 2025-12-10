import 'package:joyflo_project/core/data/models/domain_model.dart';
import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'package:joyflo_project/core/data/models/user_contact_request.dart';
import 'package:joyflo_project/core/data/models/user_contact_response.dart';

part 'api_service.chopper.dart';

@ChopperApi()
abstract class ApiService extends ChopperService {
  @GET(path: '/api/v1/dom/simply-domain/get?type_domain=TYPE_QUESTION')
  Future<Response> fetchDomainsRaw();

  @POST(path: '/user/user-contact/request')
  Future<Response> sendAssistanceRequestRaw(
    @Body() Map<String, dynamic> body,
  );

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

  /// Wrapper returns DomainResponse -> deserialized 
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

  /// Helper returns -> DomainData
  Future<List<DomainData>> fetchDomValues() async {
    final DomainResponse domainResponse = await fetchDomains();
    return domainResponse.data.values.toList();
  }

  /// Wrapper returns UserContactResponse -> deserialized
    Future<UserContactResponse> sendAssistanceRequest(
      UserContactRequest request) async {
    final Response raw = await sendAssistanceRequestRaw(request.toJson());

    if (!raw.isSuccessful) {
      throw Exception(
          "Errore API: ${raw.statusCode} - ${raw.error}");
    }

    final Map<String, dynamic> jsonMap =
        raw.body is Map<String, dynamic>
            ? raw.body
            : jsonDecode(raw.bodyString);

    return UserContactResponse.fromJson(jsonMap);
  }

}
