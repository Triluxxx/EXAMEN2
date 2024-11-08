import 'package:examen/src/data/api/ApiConfig.dart';
import 'package:examen/src/domain/models/Matricula.dart';
import 'package:examen/src/domain/utils/Resource.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MatriculaService {
  // Método para obtener todas las matrículas (GET /alumnos)
  Future<Resource<List<Matricula>>> fetchMatriculas() async {
    try {
      Uri url = Uri.http(ApiConfig.API, 'api/matricula');
      Map<String, String> headers = {"Content-Type": "application/json"};
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        List<Matricula> matriculas = matriculasFromJson(response.body);
        return Success(matriculas);
      } else {
        return Error('Error: ${response.statusCode}, ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      return Error('Error al obtener las matrículas: $e');
    }
  }

  // Método para obtener los detalles de una matrícula específica (GET /alumnos/{id})
  Future<Resource<Matricula>> fetchMatriculaDetail(int idMatricula) async {
    try {
      Uri url = Uri.http(ApiConfig.API, 'api/matricula/$idMatricula');
      Map<String, String> headers = {"Content-Type": "application/json"};
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        Matricula matricula = Matricula.fromJson(json.decode(response.body));
        return Success(matricula);
      } else {
        return Error('Error: ${response.statusCode}, ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      return Error('Error al obtener los detalles de la matrícula: $e');
    }
  }

  // Método para crear una nueva matrícula (POST /alumnos)
  Future<Resource<Matricula>> createMatricula(Matricula matricula) async {
    try {
      Uri url = Uri.http(ApiConfig.API, 'api/matricula');
      Map<String, String> headers = {"Content-Type": "application/json"};
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(matricula.toJson()),
      );

      if (response.statusCode == 201) {
        Matricula newMatricula = Matricula.fromJson(json.decode(response.body));
        return Success(newMatricula);
      } else {
        return Error('Error: ${response.statusCode}, ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      return Error('Error al crear la matrícula: $e');
    }
  }

  // Método para actualizar una matrícula existente (PUT /alumnos/{id})
  Future<Resource<Matricula>> updateMatricula(
      int idMatricula, Matricula matricula) async {
    try {
      Uri url = Uri.http(ApiConfig.API, 'api/matricula/$idMatricula');
      Map<String, String> headers = {"Content-Type": "application/json"};
      final response = await http.put(
        url,
        headers: headers,
        body: json.encode(matricula.toJson()),
      );

      if (response.statusCode == 200) {
        Matricula updatedMatricula =
            Matricula.fromJson(json.decode(response.body));
        return Success(updatedMatricula);
      } else {
        return Error('Error: ${response.statusCode}, ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      return Error('Error al actualizar la matrícula: $e');
    }
  }

  // Método para eliminar una matrícula (DELETE /alumnos/{id})
  Future<Resource<bool>> deleteMatricula(int idMatricula) async {
    try {
      Uri url = Uri.http(ApiConfig.API, 'api/matricula/$idMatricula');
      Map<String, String> headers = {"Content-Type": "application/json"};
      final response = await http.delete(url, headers: headers);

      if (response.statusCode == 200) {
        return Success(true);
      } else {
        return Error('Error: ${response.statusCode}, ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      return Error('Error al eliminar la matrícula: $e');
    }
  }
}
