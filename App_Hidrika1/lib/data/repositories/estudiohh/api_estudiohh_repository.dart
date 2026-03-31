import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../../../domain/model/model.dart';
import '../../dto/dto.dart';
import 'estudiohh_repository.dart';

class EstudiohhRepositoryImpl implements EstudiohhRepository {
  final http.Client client;
  static const String _baseUrl =
      "https://firestore.googleapis.com/v1/projects/huellahidrika/databases/(default)";
  static const String _patch = "documents/EstudiosHH";

  EstudiohhRepositoryImpl(this.client);

  @override
  Future<(List<EstudiohhModel>, String?)> getEstudiohh({
    int pageSize = 6,
    String? pageToken,
  }) async {
    String urlString = "$_baseUrl/$_patch?pageSize=$pageSize";
    if (pageToken != null) {
      urlString += "&pageToken=$pageToken";
    }
    final url = Uri.parse(urlString);
    try {
      final response = await client.get(
        url,
        headers: await _getAuthHeaders(),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedData = json.decode(response.body);
        final List<dynamic> documents = decodedData['documents'] ?? [];
        final String? nextPageToken = decodedData['nextPageToken'];

        final estudiohh = documents.map((item) {
          final dto = EstudiohhDTO.fromJson(item as Map<String, dynamic>);
          return dto.toModel();
        }).toList();
        return (estudiohh, nextPageToken);
      } else {
        throw Exception("Error al obtener estudios: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Fallo de conexión: $e");
    }
  }

  Future<Map<String, String>> _getAuthHeaders() async {
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
}
