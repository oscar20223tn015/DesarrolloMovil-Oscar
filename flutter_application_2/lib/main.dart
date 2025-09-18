import 'package:flutter/material.dart';
import 'package:flutter_application_2/Worker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Worker Management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 132, 118, 156),
        ),
      ),
      home: const MyHomePage(title: 'Worker Management App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Worker> workersList = [];

  // Controladores para los campos de texto
  TextEditingController _txtIdCtrl = TextEditingController();
  TextEditingController _txtNameCtrl = TextEditingController();
  TextEditingController _txtLastNameCtrl = TextEditingController();
  TextEditingController _txtAgeCtrl = TextEditingController();

  void _addWorker() {
    final id = _txtIdCtrl.text.trim();
    final name = _txtNameCtrl.text.trim();
    final apellidos = _txtLastNameCtrl.text.trim();
    final ageText = _txtAgeCtrl.text.trim();

    if (id.isEmpty || name.isEmpty || apellidos.isEmpty || ageText.isEmpty) {
      _showSnackBar("Todos los campos son obligatorios");
      return;
    }

    int edad;
    try {
      edad = int.parse(ageText);
    } catch (e) {
      _showSnackBar("La edad debe ser un número válido");
      return;
    }

    if (edad < 18) {
      _showSnackBar("Solo se pueden registrar mayores de edad (18+)");
      return;
    }

    if (workersList.any((worker) => worker.id == id)) {
      _showSnackBar("El ID ya existe. Use un ID diferente");
      return;
    }

    setState(() {
      workersList.add(Worker(name, id, apellidos, edad));
    });

    _txtIdCtrl.clear();
    _txtNameCtrl.clear();
    _txtLastNameCtrl.clear();
    _txtAgeCtrl.clear();

    _showSnackBar("Trabajador agregado exitosamente");
  }

  void _removeLastWorker() {
    if (workersList.isEmpty) {
      _showSnackBar("No hay trabajadores para eliminar");
      return;
    }

    setState(() {
      workersList.removeLast();
    });

    _showSnackBar("Último trabajador eliminado");
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildWorkersList() {
    if (workersList.isEmpty) {
      return const Text(
        "No hay trabajadores registrados",
        style: TextStyle(fontStyle: FontStyle.italic),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Lista de Trabajadores:",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...workersList.asMap().entries.map((entry) {
          int index = entry.key;
          Worker worker = entry.value;
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${index + 1}. ${worker.nombre} ${worker.apellidos}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("ID: ${worker.id}"),
                  Text("Edad: ${worker.edad} años"),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Registro de Trabajadores',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _txtIdCtrl,
              decoration: const InputDecoration(
                labelText: 'ID del Trabajador',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _txtNameCtrl,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _txtLastNameCtrl,
              decoration: const InputDecoration(
                labelText: 'Apellidos',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _txtAgeCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Edad',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Botones
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _addWorker,
                    label: const Text("Agregar Trabajador"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: const Color.fromARGB(255, 123, 253, 62),
                      foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _removeLastWorker,
                    label: const Text("Eliminar Último"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Colors.red,
                      foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Lista de trabajadores
            _buildWorkersList(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _txtIdCtrl.dispose();
    _txtNameCtrl.dispose();
    _txtLastNameCtrl.dispose();
    _txtAgeCtrl.dispose();
    super.dispose();
  }
}
