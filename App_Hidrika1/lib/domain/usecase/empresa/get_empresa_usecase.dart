// import '../../../data/repositories/repositories.dart';
// import '../../model/model.dart';

// abstract class GetEmpresaUsecase {
//   Future<(List<EmpresaModel>, String?)> execute({
//     int pageSize = 6,
//     String? pageToken,
//   });
// }

// class DefaultGetEmpresaUsecase implements GetEmpresaUsecase {
//   final EmpresaRepository _repository;

//   DefaultGetEmpresaUsecase(repository) : _repository = repository;

//   @override
//   Future<(List<EmpresaModel>, String?)> execute({
//     int pageSize = 6,
//     String? pageToken,
//   }) async {
//     return _repository.getEmpresa(pageSize: pageSize, pageToken: pageToken);
//   }
// }


import '../../../data/repositories/repositories.dart';
import '../../model/model.dart';

abstract class GetEmpresaUsecase {
  Future<EmpresaModel> execute(String userId);
}

class DefaultGetEmpresaUsecase implements GetEmpresaUsecase {
  final EmpresaRepository _repository;

  DefaultGetEmpresaUsecase(repository) : _repository = repository;

  @override
  Future<EmpresaModel> execute(String userId) async {
    return _repository.getEmpresa(userId);
  }
}
