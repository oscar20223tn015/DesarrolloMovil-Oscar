import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contador Simple',
      home: const MyHomePage(title: 'Contador Simple'),
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
  int _counter = 0;
  
  List<int> _historial = [];
  bool _mostrarHistorial = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
      _historial.add(_counter);
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
      _historial.add(_counter);
    });
  }

  void _toggleHistorial() {
    setState(() {
      _mostrarHistorial = !_mostrarHistorial;
    });
  }


  void _limpiarHistorial() {
    setState(() {
      _historial.clear();
    });
  }

  Widget _buildHistorial() {
    if (_historial.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          'No hay historial todavía.',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Container(
      height: 180,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: ListView.builder(
        itemCount: _historial.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              '${index + 1}. ${_historial[index]}',
              style: const TextStyle(fontSize: 16),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Título
            const Text(
              'Mi Contador',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            
            const SizedBox(height: 30),
            
            
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Text(
                '$_counter',
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
            
            const SizedBox(height: 30),
            
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _decrementCounter,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('- Restar'),
                ),
                ElevatedButton(
                  onPressed: _incrementCounter,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('+ Sumar'),
                ),
              ],
            ),
            
            const SizedBox(height: 40),
            
            
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _toggleHistorial,
                    child: Text(_mostrarHistorial 
                      ? 'Ocultar Historial' 
                      : 'Mostrar Historial'
                    ),
                  ),
                ),
                
                const SizedBox(height: 10),
                
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _limpiarHistorial,
                    child: const Text('Limpiar Historial'),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            
            if (_mostrarHistorial) ...[
              const Text(
                'Historial:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(child: _buildHistorial()),
            ],
          ],
        ),
      ),
    );
  }
}