import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_service.dart'; // Asegúrate de que esta ruta sea correcta

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Servicios"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
        future: getServicios(), // Llamamos a la función adaptada
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Map<String, dynamic>> serviciosList =
                List<Map<String, dynamic>>.from(snapshot.data ?? []);

            if (serviciosList.isEmpty) {
              return const Center(
                child: Text('No hay servicios registrados. ¡Agrega uno!'),
              );
            }

            return ListView.builder(
              itemCount: serviciosList.length,
              itemBuilder: (context, index) {
                final servicio = serviciosList[index];

                return Dismissible(
                  onDismissed: (direction) async {
                    await deleteServicio(servicio['uid']);
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('"${servicio['Nombre']}" eliminado correctamente')),
                    );
                  },
                  confirmDismiss: (direction) async {
                    bool? result = await showAdaptiveDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("¿Eliminar '${servicio['Nombre']}'?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text("Cancelar", style: TextStyle(color: Colors.red)),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text("Sí, eliminar"),
                            ),
                          ],
                        );
                      },
                    );
                    return result ?? false;
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  direction: DismissDirection.endToStart,
                  key: Key(servicio['uid']),
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    elevation: 4.0,
                    child: ListTile(
                      title: Text(
                        servicio['Nombre'] ?? 'Sin nombre',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Descripción: ${servicio['Descripcion'] ?? 'N/A'}'),
                          Text('Precio: \$${servicio['Precio']?.toString() ?? 'N/A'}'),
                          Text('Tipo: ${servicio['Tipo'] ?? 'N/A'}'),
                          Text('Horario: ${servicio['Horario'] ?? 'N/A'}'),
                          Text('Ubicación: ${servicio['Ubicacion'] ?? 'N/A'}'),
                        ],
                      ),
                      onTap: () async {
                        await Navigator.pushNamed(
                          context,
                          '/edit',
                          arguments: servicio,
                        );
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error al cargar datos: ${snapshot.error}'),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
