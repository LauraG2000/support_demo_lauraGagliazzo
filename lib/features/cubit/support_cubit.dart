import 'package:bloc/bloc.dart';
import 'package:joyflo_project/core/data/models/user_contact_request.dart';
import 'package:joyflo_project/core/data/models/user_contact_response.dart';
import 'package:joyflo_project/core/domains/usecases/get_domains_usecase.dart';
import 'package:joyflo_project/core/domains/usecases/user_contact_usecase.dart';

//  UseCases for the page
class SupportCubit extends Cubit<void> {
  final GetDomainsUseCase getDomainsUseCase;
  final UserContactUseCase userContactUseCase;

  SupportCubit({
    required this.getDomainsUseCase,
    required this.userContactUseCase,
  }) : super(null);

  // Send request (for the page)
  Future<UserContactResponse> sendAssistanceRequest(
    UserContactRequest request,
  ) async {
    return await userContactUseCase.sendAssistanceRequest(request);
  }
}
