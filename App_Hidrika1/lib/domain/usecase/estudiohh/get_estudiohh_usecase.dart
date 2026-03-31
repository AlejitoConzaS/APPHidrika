import '../../../data/repositories/repositories.dart';
import '../../model/model.dart';

abstract class GetEstudiohhUsecase {
  Future<(List<EstudiohhModel>, String?)> execute({
    int pageSize = 6,
    String? pageToken,
  });
}

class DefaultGetEstudioUsecase implements GetEstudiohhUsecase {
  final EstudiohhRepository _repository;

  DefaultGetEstudioUsecase(repository) : _repository = repository;

  @override
  Future<(List<EstudiohhModel>, String?)> execute({
    int pageSize = 6,
    String? pageToken,
  }) async {
    return _repository.getEstudiohh(pageSize: pageSize, pageToken: pageToken);
  }
}
