// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$ApiService extends ApiService {
  _$ApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = ApiService;

  @override
  Future<Response<dynamic>> fetchDomainsRaw() {
    final Uri $url = Uri.parse(
      '/api/v1/dom/simply-domain/get?type_domain=TYPE_QUESTION',
    );
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> sendAssistanceRequestRaw(
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('/user/user-contact/request');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
