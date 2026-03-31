import 'dart:ffi';

import '../../../data/repositories/repositories.dart';
import '../../model/model.dart';

abstract class LogoutEmpresaUsecase {
  Future<void> execute();
}

class DefaultLogoutEmpresaUsecase implements LogoutEmpresaUsecase {
  final EmpresaRepository _repository;

  DefaultLogoutEmpresaUsecase(repository) : _repository = repository;

  @override
  Future<void> execute() async {
    _repository.logout();
  }
}
