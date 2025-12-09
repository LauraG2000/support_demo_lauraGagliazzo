import 'package:bloc/bloc.dart';
import 'package:joyflo_project/core/domains/usecases/get_domains_usecase.dart';

/// Cubit minimale: espone solo il UseCase per la pagina
class SupportCubit extends Cubit<void> {
  final GetDomainsUseCase getDomainsUseCase;

  SupportCubit({required this.getDomainsUseCase}) : super(null);

}
