// import 'package:flutter/material.dart';

// import 'package:apphidrika1/domain/model/model.dart';
// import '../../domain/usecase/usecase.dart';

// class EmpresaViewModel extends ChangeNotifier {
//   final GetEmpresaUsecase _getEmpresaUseCase;

//   List<EmpresaModel> _empresa = [];
//   String? _pageToken;
//   bool _isLoading = false;
//   String? _errorMessage;

//   List<EmpresaModel> get empresa => _empresa;
//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//   String? get pageToken => _pageToken;

//   EmpresaViewModel(getEmpresaUseCase)
//       : _getEmpresaUseCase = getEmpresaUseCase {
//     fetchEmpresa();
//   }

//   Future<void> fetchEmpresa() async {
//     _setLoading(true);
//     _errorMessage = null;
//     try {
//       final resut = await _getEmpresaUseCase.execute(pageToken: _pageToken);
//       _empresa = _empresa.isEmpty ? resut.$1 : [..._empresa, ...resut.$1];
//       _pageToken = resut.$2;
//     } catch (e) {
//       _errorMessage =
//           "No se pudo cargar data empresa. Verifica tu conexión.";
//     } finally {
//       _setLoading(false);
//     }
//   }

//   void addEmpresa() {
//     final empresa = EmpresaModel(
//       id: 'id',
//       nombre: 'nombre',
//       rubro: 'rubro',
//       ruc: 12345678,
//       clienteactivo: true, 
//     );
//     _empresa = [..._empresa, empresa];
//     notifyListeners();
//   }

//   void _setLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }
// }



import 'package:flutter/material.dart';

import '../../domain/model/model.dart';
import '../../domain/usecase/usecase.dart';

class EmpresaViewModel extends ChangeNotifier {
  EmpresaModel? _currentEmpresa;
  bool _isLoading = false;
  String? error;
  final GetEmpresaUsecase _getEmpresaUsecase;
  final UpdateEmpresaUseCase _updateEmpresaUseCase;
  final AuthenticateEmpresaUsecase _authenticateEmpresaUsecase;
  final LogoutEmpresaUsecase _logoutEmpresaUsecase;

  EmpresaModel? get currentEmpresa => _currentEmpresa;
  bool get isLoading => _isLoading;

  EmpresaViewModel(getEmpresaUsecase, updateEmpresaUseCase, authenticateEmpresaUsecase,
      logoutEmpresaUsecase)
      : _getEmpresaUsecase = getEmpresaUsecase,
        _updateEmpresaUseCase = updateEmpresaUseCase,
        _authenticateEmpresaUsecase = authenticateEmpresaUsecase,
        _logoutEmpresaUsecase = logoutEmpresaUsecase;

  Future<void> register(String userName, String email, String password) async {
    _setLoading(true);
    try {
      final authEmpresa = await _authenticateEmpresaUsecase.execute(email, password);
      _currentEmpresa = await _getEmpresaUsecase.execute(authEmpresa.id);
    } catch (e) {
    } finally {
      _setLoading(false);
    }
  }

  Future<void> login(String email, String password) async {
    error = null; 
    _setLoading(true);
    try {
      final authEmpresa = await _authenticateEmpresaUsecase.execute(email, password);
      _currentEmpresa = await _getEmpresaUsecase.execute(authEmpresa.id);
    } catch (e) {
      error = e.toString();
      print(e);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateEmpresa(String nombre, String rubro) async {
    _setLoading(true);
    try {
      var newEmpresa = _currentEmpresa?.copyWith(nombre: nombre, rubro: rubro);
      if (newEmpresa != null) {
        final wasUpdated =
            await _updateEmpresaUseCase.execute(newEmpresa.id, newEmpresa);
        if (wasUpdated) {
          _currentEmpresa = newEmpresa;
        } else {
          error = 'Hubo un error al actualizar';
        }
      }
    } catch (e) {
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    _setLoading(true);
    try {
      await _logoutEmpresaUsecase.execute();
      _currentEmpresa = null;
    } catch (e) {
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
