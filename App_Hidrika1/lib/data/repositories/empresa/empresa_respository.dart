import '../../../domain/model/model.dart';

// abstract class EmpresaRepository {
//   Future<(List<EmpresaModel>, String?)> getEmpresa({
//     int pageSize = 6,
//     String? pageToken,
//   });
// }

abstract class EmpresaRepository {
  Future<EmpresaModel> login(String userName, String password);

  Future<EmpresaModel> getEmpresa(String userId);

  Future<bool> updateEmpresa(String userId, EmpresaModel user);

  Future<void> logout();
}
