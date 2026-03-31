import '../../data/dto/dto.dart';

class EmpresaModel {
  final String id;
  final String nombre;
  final String rubro;
  final int ruc;
  final bool clienteactivo;

  EmpresaModel({
    required this.id,
    required this.nombre,
    required this.rubro,
    required this.ruc,
    required this.clienteactivo,
  });

  EmpresaModel copyWith({
    String? nombre,
    String? rubro,
    int? ruc,
    bool? clienteactivo,
  }) =>
      EmpresaModel(
        id: id,
        nombre: nombre ?? this.nombre,
        rubro: rubro ?? this.rubro,
        ruc: ruc ?? this.ruc,
        clienteactivo: clienteactivo ?? this.clienteactivo,
       );

  EmpresaDTO toDTO() {
    return EmpresaDTO(
      id: id,
      nombre: nombre,
      rubro: rubro,
      ruc: ruc,
      clienteactivo: clienteactivo,
    );
  }
}
