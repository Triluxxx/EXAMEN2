
import 'package:examen/src/presentation/pages/listRoom/bloc/matricula_bloc.dart';
import 'package:examen/src/presentation/pages/listRoom/bloc/matricula_event.dart';
import 'package:examen/src/presentation/pages/listRoom/bloc/matricula_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:examen/src/domain/models/Matricula.dart';

class RegisterMatriculaPage extends StatelessWidget {
  final Matricula? matricula;

  const RegisterMatriculaPage({Key? key, this.matricula}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController cursoController =
        TextEditingController(text: matricula?.curso ?? '');
    final TextEditingController estudianteController =
        TextEditingController(text: matricula?.estudiante ?? '');
    final TextEditingController horasController =
        TextEditingController(text: matricula?.numeroHoras.toString() ?? '');
    final TextEditingController creditosController =
        TextEditingController(text: matricula?.numeroCreditos.toString() ?? '');
    final TextEditingController estadoController =
        TextEditingController(text: matricula?.estado ?? '');

    return Scaffold(
      appBar: AppBar(
        title: Text(
            matricula != null ? 'Editar Matrícula' : 'Registrar Matrícula'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: cursoController,
                decoration: const InputDecoration(labelText: 'Curso'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: estudianteController,
                decoration: const InputDecoration(labelText: 'Estudiante'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: horasController,
                decoration: const InputDecoration(labelText: 'Número de Horas'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: creditosController,
                decoration:
                    const InputDecoration(labelText: 'Número de Créditos'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: estadoController,
                decoration: const InputDecoration(labelText: 'Estado'),
              ),
              const SizedBox(height: 30),
              BlocConsumer<MatriculaBloc, MatriculaState>(
                listener: (context, state) {
                  if (state is MatriculaSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(matricula != null
                              ? 'Matrícula actualizada con éxito'
                              : 'Matrícula registrada con éxito')),
                    );
                    Navigator.pop(
                        context, true); // Regresar 'true' para indicar éxito
                  } else if (state is MatriculaFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${state.error}')),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is MatriculaLoading) {
                    return const CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.black, // Cambiado de primary a backgroundColor
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      final nuevaMatricula = Matricula(
                        idMatricula: matricula?.idMatricula,
                        curso: cursoController.text,
                        estudiante: estudianteController.text,
                        numeroHoras: int.tryParse(horasController.text) ?? 0,
                        numeroCreditos:
                            int.tryParse(creditosController.text) ?? 0,
                        estado: estadoController.text,
                      );

                      if (matricula != null) {
                        context
                            .read<MatriculaBloc>()
                            .add(UpdateMatriculaEvent(nuevaMatricula));
                      } else {
                        context
                            .read<MatriculaBloc>()
                            .add(CreateMatriculaEvent(nuevaMatricula));
                      }
                    },
                    child: Text(matricula != null ? 'Actualizar' : 'Registrar'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
