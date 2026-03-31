import 'dart:convert';

import '../../domain/model/model.dart';

class EmpresaDTO {
  final String id;
  final String nombre;
  final String rubro;
  final int ruc;
  final bool clienteactivo;

  EmpresaDTO({
    required this.id,
    required this.nombre,
    required this.rubro,
    required this.ruc,
    required this.clienteactivo,
   });

  // MARK: - Public
  factory EmpresaDTO.fromJson(Map<String, dynamic> map) =>
      EmpresaDTO._fromMap(map);

  String toJson() => json.encode(_toMap());

  EmpresaModel toModel() {
    return EmpresaModel(
      id: id,
      nombre: nombre,
      rubro: rubro,
      ruc: ruc,
      clienteactivo: clienteactivo,
    );
  }

  // MARK: - Private
  static const String _fields = "fields";
  static const String _stringKey = "stringValue";
  static const String _integerKey = "integerValue";
  static const String _booleanKey = "booleanValue";

  factory EmpresaDTO._fromMap(Map<String, dynamic> map) {
    final String fullPath = map['name'] ?? '';
    final String docId = fullPath.split('/').last;
    final fields = map[_fields] as Map<String, dynamic>;

return EmpresaDTO(
      id: docId,
     nombre: fields['nombre']?[_stringKey] ?? '',
     rubro: fields['rubro']?[_stringKey] ?? '',
     ruc: int.parse(fields['ruc']['integerValue']),
     clienteactivo: fields ['clienteactivo']['booleanValue'],
      
     );
  }

  Map<String, dynamic> _toMap() {
    return {
      _fields: {
         "nombre": {_stringKey: nombre},
         "rubro": {_stringKey: rubro},
         "ruc": {_integerKey: ruc},
         "clienteactivo": {_booleanKey: clienteactivo},
      }
    };
  }
}
//     return EmpresaDTO(
//       id: docId,
//       nombre: fields['nombre']?[_stringKey] ?? '',
//       rubro: fields['rubro']?[_stringKey] ?? '',
//       ruc: int.parse(fields['ruc']['integerValue']),
//       clienteactivo: fields ['clienteactivo']['booleanValue'],
//     );
//   }

//   Map<String, dynamic> _toMap() {
//     return {
//       _fields: {
//         "nombre": {_stringKey: nombre},
//         "rubro": {_stringKey: rubro},
//         "ruc": {_integerKey: ruc},
//         "clienteactivo": {_booleanKey: clienteactivo},
//       }
//     };
//   }
// }