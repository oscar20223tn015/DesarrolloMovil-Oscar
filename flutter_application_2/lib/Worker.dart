class Worker {
  String id;
  String nombre;
  String apellidos;
  int edad;

  Worker(this.nombre, this.id, this.apellidos, this.edad);

  @override
  String toString() {
    return 'Worker{id: $id, nombre: $nombre, apellidos: $apellidos, edad: $edad}';
  }
}
