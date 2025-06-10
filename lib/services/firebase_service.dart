import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

// Obtener todos los servicios
Future<List> getServicios() async {
  List servicios = [];
  CollectionReference collectionReferenceServicios = db.collection("Servicios");
  QuerySnapshot queryServicios = await collectionReferenceServicios.get();

  for (var doc in queryServicios.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final servicio = {
      "Nombre": data['Nombre'],
      "Descripcion": data['Descripcion'],
      "Precio": data['Precio'],
      "Tipo": data['Tipo'],
      "Horario": data['Horario'],
      "Ubicacion": data['Ubicacion'],
      "uid": doc.id,
    };
    servicios.add(servicio);
  }
  return servicios;
}

// Agregar un nuevo servicio
Future<void> addServicio(
  String nombre,
  String descripcion,
  int precio,
  String tipo,
  String horario,
  String ubicacion,
) async {
  await db.collection("Servicios").add({
    "Nombre": nombre,
    "Descripcion": descripcion,
    "Precio": precio,
    "Tipo": tipo,
    "Horario": horario,
    "Ubicacion": ubicacion,
  });
}

// Actualizar un servicio existente
Future<void> updateServicio(
  String uid,
  String nombre,
  String descripcion,
  int precio,
  String tipo,
  String horario,
  String ubicacion,
) async {
  await db.collection("Servicios").doc(uid).set({
    "Nombre": nombre,
    "Descripcion": descripcion,
    "Precio": precio,
    "Tipo": tipo,
    "Horario": horario,
    "Ubicacion": ubicacion,
  });
}

// Eliminar un servicio
Future<void> deleteServicio(String uid) async {
  await db.collection("Servicios").doc(uid).delete();
}
