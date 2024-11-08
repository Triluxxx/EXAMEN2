import 'package:examen/src/data/dataSource/service/MatriculaService.dart';
import 'package:examen/src/domain/models/Matricula.dart';
import 'package:examen/src/domain/repository/MatriculaRepository.dart';
import 'package:examen/src/domain/utils/Resource.dart';

class MatriculaRepositoryImpl implements MatriculaRepository {
  final MatriculaService matriculaService;

  MatriculaRepositoryImpl(this.matriculaService);

  // Implementación del método para obtener la lista de matrículas
  @override
  Future<Resource<List<Matricula>>> fetchMatriculas() {
    return matriculaService.fetchMatriculas();
  }

  // Implementación del método para obtener los detalles de una matrícula específica
  @override
  Future<Resource<Matricula>> fetchMatriculaDetail(int idMatricula) {
    return matriculaService.fetchMatriculaDetail(idMatricula);
  }

  // Implementación del método para crear una nueva matrícula
  @override
  Future<Resource<Matricula>> createMatricula(Matricula matricula) {
    return matriculaService.createMatricula(matricula);
  }

  // Implementación del método para actualizar una matrícula existente
  @override
  Future<Resource<Matricula>> updateMatricula(
      int idMatricula, Matricula matricula) {
    return matriculaService.updateMatricula(idMatricula, matricula);
  }

  // Implementación del método para eliminar una matrícula
  @override
  Future<Resource<bool>> deleteMatricula(int idMatricula) {
    return matriculaService.deleteMatricula(idMatricula);
  }
}
