import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_service.dart';

class AddServicioPage extends StatefulWidget {
  const AddServicioPage({super.key});

  @override
  State<AddServicioPage> createState() => _AddServicioPageState();
}

class _AddServicioPageState extends State<AddServicioPage> {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController descriptionController = TextEditingController(text: "");
  TextEditingController priceController = TextEditingController(text: "");
  TextEditingController tipoController = TextEditingController(text: "");
  TextEditingController horarioController = TextEditingController(text: "");
  TextEditingController ubicacionController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agregar Servicio"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Ingrese el Nombre del Servicio',
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),

            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                hintText: 'Ingrese la Descripción del Servicio',
                labelText: 'Descripción',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),

            TextField(
              controller: priceController,
              decoration: const InputDecoration(
                hintText: 'Ingrese el Precio del Servicio',
                labelText: 'Precio',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),

            TextField(
              controller: tipoController,
              decoration: const InputDecoration(
                hintText: 'Ingrese el Tipo de Servicio',
                labelText: 'Tipo',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),

            TextField(
              controller: horarioController,
              decoration: const InputDecoration(
                hintText: 'Ingrese el Horario del Servicio',
                labelText: 'Horario',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),

            TextField(
              controller: ubicacionController,
              decoration: const InputDecoration(
                hintText: 'Ingrese la Ubicación del Servicio',
                labelText: 'Ubicación',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                int price = int.tryParse(priceController.text) ?? 0;

                await addServicio(
                  nameController.text,
                  descriptionController.text,
                  price,
                  tipoController.text,
                  horarioController.text,
                  ubicacionController.text,
                ).then((_) {
                  Navigator.pop(context);
                });
              },
              child: const Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    tipoController.dispose();
    horarioController.dispose();
    ubicacionController.dispose();
    super.dispose();
  }
}
