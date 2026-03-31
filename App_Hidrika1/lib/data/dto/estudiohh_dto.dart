import 'dart:convert';
import 'dart:ffi';

import '../../domain/model/model.dart';

// MARK: - From Firebase JSON
class EstudiohhDTO {
  final int year;
  final String tipo;
  final String url;

  EstudiohhDTO({
    required this.year,
    required this.tipo,
    required this.url,
   });

  // MARK: - Public
  factory EstudiohhDTO.fromJson(Map<String, dynamic> map) =>
      EstudiohhDTO._fromMap(map);

  String toJson() => json.encode(_toMap());

  EstudiohhModel toModel() {
    return EstudiohhModel(
      year: year.toString(),
      tipo: tipo,
      url: url,
    );
  }

  // MARK: - Private
  static const String _fields = "fields";
  static const String _stringKey = "stringValue";
   static const String _intKey = "integerValue";

  factory EstudiohhDTO._fromMap(Map<String, dynamic> map) {
    final String fullPath = map['name'] ?? '';
    final String docId = fullPath.split('/').last;

    final fields = map[_fields] as Map<String, dynamic>;

    return EstudiohhDTO(
      year: int.tryParse(fields['year']?[_intKey]?.toString() ?? '0')?? 0,
      tipo: fields['tipo']?[_stringKey] ?? '',
      url: fields['url']?[_stringKey] ?? '',
      
     );
  }

  Map<String, dynamic> _toMap() {
    return {
      _fields: {
        "año": {_intKey: year.toString()},
        "tipo": {_stringKey: tipo},
        "url": {_stringKey: url},
      }
    };
  }
}

