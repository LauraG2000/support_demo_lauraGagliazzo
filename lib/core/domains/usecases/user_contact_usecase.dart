import 'package:joyflo_project/core/data/services/api_service.dart';
import 'package:joyflo_project/core/data/models/user_contact_request.dart';
import 'package:joyflo_project/core/data/models/user_contact_response.dart';

class UserContactUseCase {
  final ApiService apiService;

  UserContactUseCase({required this.apiService});

  Future<UserContactResponse> sendAssistanceRequest(
      UserContactRequest request) async {
    try {
      final response = await apiService.sendAssistanceRequest(request);
      return response;
    } catch (e) {
      throw Exception("Errore durante la richiesta di assistenza: $e");
    }
  }
}
