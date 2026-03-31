import '../../../domain/model/model.dart';

abstract class EstudiohhRepository {
  Future<(List<EstudiohhModel>, String?)> getEstudiohh({
    int pageSize = 6,
    String? pageToken,
  });
}
