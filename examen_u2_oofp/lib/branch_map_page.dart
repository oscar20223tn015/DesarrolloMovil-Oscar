import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BranchMapPage extends StatefulWidget {
  const BranchMapPage({super.key});

  @override
  State<BranchMapPage> createState() => _BranchMapPageState();
}

class _BranchMapPageState extends State<BranchMapPage> {
  // 2. Definir posición de la sucursal
  static const LatLng _branchPosition = LatLng(18.9261, -99.2216);
  static const CameraPosition _initialCamera = CameraPosition(
    target: _branchPosition,
    zoom: 16,
  );

  // 3. Declarar el set de marcadores
  final Set<Marker> _markers = {};

  // 4. Agregar el marcador en initState()
  @override
  void initState() {
    super.initState();
    _markers.add(
      const Marker(
        markerId: MarkerId('branch'),
        position: _branchPosition,
        infoWindow: InfoWindow(title: 'Sucursal Principal'),
      ),
    );
  }

  // 5. Construir el Scaffold con el mapa
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa de sucursal'),
      ),
      body: GoogleMap(
        initialCameraPosition: _initialCamera,
        markers: _markers,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: true,
      ),
    );
  }
}