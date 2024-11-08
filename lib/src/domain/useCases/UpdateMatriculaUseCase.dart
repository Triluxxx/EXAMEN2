import 'package:examen/src/domain/models/Matricula.dart';
import 'package:examen/src/domain/repository/MatriculaRepository.dart';
import 'package:examen/src/domain/utils/Resource.dart';

class UpdateMatriculaUseCase {
  final MatriculaRepository matriculaRepository;

  UpdateMatriculaUseCase(this.matriculaRepository);

  Future<Resource<Matricula>> call(int idMatricula, Matricula matricula) async {
    return await matriculaRepository.updateMatricula(idMatricula, matricula);
  }
}
