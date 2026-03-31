import '../../../data/repositories/repositories.dart';
import '../../model/model.dart';

abstract class AuthenticateEmpresaUsecase {
  Future<EmpresaModel> execute(String userName, String password);
}

class DefaultAuthenticateEmpresaUsecase implements AuthenticateEmpresaUsecase {
  final EmpresaRepository _repository;

  DefaultAuthenticateEmpresaUsecase(repository) : _repository = repository;

  @override
  Future<EmpresaModel> execute(String userName, String password) async {
    return await _repository.login(userName, password);
  }
}
