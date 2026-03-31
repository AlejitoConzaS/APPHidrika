import '../../../data/repositories/repositories.dart';
import '../../model/model.dart';

abstract class UpdateEmpresaUseCase {
  Future<bool> execute(String userId, EmpresaModel user);
}

class DefaultUpdateEmpresaUseCase implements UpdateEmpresaUseCase {
  final EmpresaRepository _repository;

  DefaultUpdateEmpresaUseCase(repository) : _repository = repository;

  @override
  Future<bool> execute(String userId, EmpresaModel user) async {
    return _repository.updateEmpresa(userId, user);
  }
}
