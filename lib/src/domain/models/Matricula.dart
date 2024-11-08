import 'dart:convert';

// Funciones para parsear y serializar los datos de Matricula
List<Matricula> matriculasFromJson(String str) =>
    List<Matricula>.from(json.decode(str).map((x) => Matricula.fromJson(x)));

String matriculasToJson(List<Matricula> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Matricula {
  int? idMatricula;
  String curso;
  String estudiante;
  int numeroHoras;
  int numeroCreditos;
  DateTime? fechaRegistro;
  String estado;

  Matricula({
    this.idMatricula,
    required this.curso,
    required this.estudiante,
    required this.numeroHoras,
    required this.numeroCreditos,
    this.fechaRegistro,
    required this.estado,
  });

  // Método para convertir JSON en un objeto Matricula (Recepción de datos)
  factory Matricula.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(String? dateStr) {
      if (dateStr == null || dateStr.isEmpty) return null;

      try {
        return DateTime.parse(dateStr);
      } catch (e) {
        print("Error parsing date: $e");
        return null;
      }
    }

    return Matricula(
      idMatricula: json["id_matricula"], // Corregido a la clave correcta
      curso: json["curso"] ?? 'Curso no especificado', // Corregido
      estudiante:
          json["estudiante"] ?? 'Estudiante no especificado', // Corregido
      numeroHoras: json["numero_horas"] ?? 0, // Corregido
      numeroCreditos: json["numero_creditos"] ?? 0, // Corregido
      fechaRegistro: parseDate(json["fecha_registro"]), // Corregido
      estado: json["estado"] ?? 'Estado no especificado', // Corregido
    );
  }

  // Método para convertir un objeto Matricula a JSON (Envío de datos)
  Map<String, dynamic> toJson() => {
        "id_matricula": idMatricula,
        "curso": curso,
        "estudiante": estudiante,
        "numero_horas": numeroHoras,
        "numero_creditos": numeroCreditos,
        "fecha_registro": fechaRegistro?.toIso8601String(),
        "estado": estado,
      };
}
