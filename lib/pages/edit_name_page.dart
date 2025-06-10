import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_service.dart';

class EditServicioPage extends StatefulWidget {
  const EditServicioPage({super.key});

  @override
  State<EditServicioPage> createState() => _EditServicioPageState();
}

class _EditServicioPageState extends State<EditServicioPage> {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController descriptionController = TextEditingController(text: "");
  TextEditingController priceController = TextEditingController(text: "");
  TextEditingController tipoController = TextEditingController(text: "");
  TextEditingController horarioController = TextEditingController(text: "");
  TextEditingController ubicacionController = TextEditingController(text: "");

  String? _uid;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;

    _uid = arguments['uid'];
    nameController.text = arguments['Nombre'] ?? '';
    descriptionController.text = arguments['Descripcion'] ?? '';
    priceController.text = (arguments['Precio'] ?? 0).toString();
    tipoController.text = arguments['Tipo'] ?? '';
    horarioController.text = arguments['Horario'] ?? '';
    ubicacionController.text = arguments['Ubicacion'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Servicio"),
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
                hintText: 'Ingrese el Nombre',
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),

            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                hintText: 'Ingrese la Descripción',
                labelText: 'Descripción',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),

            TextField(
              controller: priceController,
              decoration: const InputDecoration(
                hintText: 'Ingrese el Precio',
                labelText: 'Precio',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),

            TextField(
              controller: tipoController,
              decoration: const InputDecoration(
                hintText: 'Ingrese el Tipo',
                labelText: 'Tipo',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),

            TextField(
              controller: horarioController,
              decoration: const InputDecoration(
                hintText: 'Ingrese el Horario',
                labelText: 'Horario',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),

            TextField(
              controller: ubicacionController,
              decoration: const InputDecoration(
                hintText: 'Ingrese la Ubicación',
                labelText: 'Ubicación',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                if (_uid != null) {
                  int price = int.tryParse(priceController.text) ?? 0;

                  await updateServicio(
                    _uid!,
                    nameController.text,
                    descriptionController.text,
                    price,
                    tipoController.text,
                    horarioController.text,
                    ubicacionController.text,
                  ).then((_) {
                    Navigator.pop(context);
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Error: No se pudo obtener el UID del documento.")),
                  );
                }
              },
              child: const Text("Actualizar"),
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
