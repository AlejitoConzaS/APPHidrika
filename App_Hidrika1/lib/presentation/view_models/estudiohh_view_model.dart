import 'package:flutter/material.dart';

import 'package:apphidrika1/domain/model/model.dart';
import '../../domain/usecase/usecase.dart';

class EstudiohhViewModel extends ChangeNotifier {
  final GetEstudiohhUsecase _getEstudiohhUseCase;

  List<EstudiohhModel> _estudiohh = [];
  String? _pageToken;
  bool _isLoading = false;
  String? _errorMessage;

  List<EstudiohhModel> get estudiohh => _estudiohh;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get pageToken => _pageToken;

  EstudiohhViewModel(getEstudiohhUseCase)
      : _getEstudiohhUseCase = getEstudiohhUseCase {
    fetchEstudiohh();
  }

  Future<void> fetchEstudiohh() async {
    _setLoading(true);
    _errorMessage = null;
    try {
      final resut = await _getEstudiohhUseCase.execute(pageToken: _pageToken);
      _estudiohh = _estudiohh.isEmpty ? resut.$1 : [..._estudiohh, ...resut.$1];
      _pageToken = resut.$2;
    } catch (e) {
      _errorMessage =
          "No se pudo cargar data estudio. Verifica tu conexión.";
    } finally {
      _setLoading(false);
    }
  }

  void addEstudiohh() {
    final estudiohh = EstudiohhModel(
      year: 'Año ${_estudiohh.length + 1}',
      tipo: 'tipo',
      url: '',
    );
    _estudiohh = [..._estudiohh, estudiohh];
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
