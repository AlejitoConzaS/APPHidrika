// import 'dart:convert';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:http/http.dart' as http;

// import '../../../domain/model/model.dart';
// import '../../dto/dto.dart';
// import 'empresa_respository.dart';

// class EmpresaRepositoryImpl implements EmpresaRepository {
//   final http.Client client;
//   static const String _baseUrl =
//       "https://firestore.googleapis.com/v1/projects/huellahidrika/databases/(default)";
//   static const String _patch = "documents/Empresas";

//   EmpresaRepositoryImpl(this.client);

//   @override
//   Future<(List<EmpresaModel>, String?)> getEmpresa({
//     int pageSize = 6,
//     String? pageToken,
//   }) async {
//     String urlString = "$_baseUrl/$_patch?pageSize=$pageSize";
//     if (pageToken != null) {
//       urlString += "&pageToken=$pageToken";
//     }
//     final url = Uri.parse(urlString);
//     try {
//       final response = await client.get(
//         url,
//         headers: await _getAuthHeaders(),
//       );

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> decodedData = json.decode(response.body);
//         final List<dynamic> documents = decodedData['documents'] ?? [];
//         final String? nextPageToken = decodedData['nextPageToken'];

//         final empresa = documents.map((item) {
//           final dto = EmpresaDTO.fromJson(item as Map<String, dynamic>);
//           return dto.toModel();
//         }).toList();
//         return (empresa, nextPageToken);
//       } else {
//         throw Exception("Error al obtener empresas: ${response.statusCode}");
//       }
//     } catch (e) {
//       throw Exception("Fallo de conexión: $e");
//     }
//   }

//   Future<Map<String, String>> _getAuthHeaders() async {
//     final token = await FirebaseAuth.instance.currentUser?.getIdToken();
//     return {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $token',
//     };
//   }
// }




import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../../../domain/model/model.dart';
import '../../data_source/data_source.dart';
import '../../dto/dto.dart';
import 'empresa_respository.dart';

class EmpresaRepositoryImpl implements EmpresaRepository {
  final http.Client client;
  late final AuthDataSource _authDataSource;

  static const String _baseUrl =
      "https://firestore.googleapis.com/v1/projects/huellahidrika/databases/(default)";
  static const String _patch = "documents/Empresas";

  EmpresaRepositoryImpl(this.client) {
    _authDataSource = AuthDataSource();
  }

  @override
  Future<EmpresaModel> login(String userName, String password) async {
    final userCredential = await _authDataSource.login(userName, password);
    final firebaseUser = userCredential.user;

    if (firebaseUser == null) {
      throw Exception("No se pudo obtener el usuario de Firebase");
    }

    return EmpresaModel(
      id: firebaseUser.uid,
      nombre: firebaseUser.email!,
      rubro: firebaseUser.displayName ?? "Nuevo Usuario",
      ruc: 0,
      clienteactivo: false,
    );
  }

  @override
  Future<EmpresaModel> getEmpresa(String userId) async {
    final String urlPath = "$_baseUrl/$_patch/$userId";
    final Uri url = Uri.parse(urlPath);

    try {
      final response = await client.get(
        url,
        headers: await _getAuthHeaders(),
      );

      // if (response.statusCode == 200) {
      //   final empresaDto = EmpresaDTO.fromJson(response.body);
      //   return empresaDto.toModel();
      // }

      throw Exception("Error: ${response.statusCode}");
    } catch (e) {
      throw Exception("Fallo de conexión: $e");
    }
  }

  // MARK: - Update User
  @override
  Future<bool> updateEmpresa(String userId, EmpresaModel user) async {
    final url = Uri.parse("$_baseUrl/$_patch/$userId");

    try {
      final response = await client.patch(
        url,
        // headers: await _getAuthHeaders(),
        body: user.toDTO().toJson(),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> logout() async {
    await _authDataSource.logout();
  }

  Future<Map<String, String>> _getAuthHeaders() async {
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
}
