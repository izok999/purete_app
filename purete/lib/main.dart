import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reservas Restaurant',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Agregar estas líneas para mejorar el tema
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          elevation: 4,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepOrange,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const PantallaInicio(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ==================== MODELOS DE DATOS ====================

class Mesa {
  final int id;
  final int numero;
  final int capacidad;
  bool reservada;

  Mesa({
    required this.id,
    required this.numero,
    required this.capacidad,
    this.reservada = false,
  });
}

class ElementoMenu {
  final int id;
  final String nombre;
  final double precio;
  final String categoria;

  ElementoMenu({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.categoria,
  });
}

class Reserva {
  final int id;
  final String nombreCliente;
  final String telefono;
  final Mesa mesa;
  final String fecha;
  final String hora;
  final List<ElementoMenu> menuSeleccionado;
  final double total;

  Reserva({
    required this.id,
    required this.nombreCliente,
    required this.telefono,
    required this.mesa,
    required this.fecha,
    required this.hora,
    required this.menuSeleccionado,
    required this.total,
  });
}

// ==================== DATOS GLOBALES ====================

List<Mesa> mesas = [
  Mesa(id: 1, numero: 1, capacidad: 2),
  Mesa(id: 2, numero: 2, capacidad: 4),
  Mesa(id: 3, numero: 3, capacidad: 2, reservada: true),
  Mesa(id: 4, numero: 4, capacidad: 6),
  Mesa(id: 5, numero: 5, capacidad: 4),
  Mesa(id: 6, numero: 6, capacidad: 8),
  Mesa(id: 7, numero: 7, capacidad: 2),
  Mesa(id: 8, numero: 8, capacidad: 4),
];

List<ElementoMenu> menuRestaurant = [
  ElementoMenu(id: 1, nombre: 'Empanadas', precio: 15000, categoria: 'Entrada'),
  ElementoMenu(
    id: 2,
    nombre: 'Sopa Paraguaya',
    precio: 12000,
    categoria: 'Entrada',
  ),
  ElementoMenu(
    id: 3,
    nombre: 'Bife con Mandioca',
    precio: 45000,
    categoria: 'Plato Principal',
  ),
  ElementoMenu(
    id: 4,
    nombre: 'Asado',
    precio: 55000,
    categoria: 'Plato Principal',
  ),
  ElementoMenu(
    id: 5,
    nombre: 'Milanesa Completa',
    precio: 35000,
    categoria: 'Plato Principal',
  ),
  ElementoMenu(id: 6, nombre: 'Helado', precio: 18000, categoria: 'Postre'),
  ElementoMenu(id: 7, nombre: 'Flan', precio: 15000, categoria: 'Postre'),
  ElementoMenu(id: 8, nombre: 'Coca Cola', precio: 8000, categoria: 'Bebida'),
  ElementoMenu(id: 9, nombre: 'Cerveza', precio: 12000, categoria: 'Bebida'),
];

List<Reserva> reservasActivas = [];

// ==================== PANTALLA 1: INICIO - SELECCIÓN DE MESAS ====================

class PantallaInicio extends StatefulWidget {
  const PantallaInicio({Key? key}) : super(key: key);

  @override
  State<PantallaInicio> createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🍽️ Reservas Restaurant'),
        elevation: 4, // Cambiar de 0 a 4
        centerTitle: true, // Centrar el título
        actions: [
          IconButton(
            icon: const Icon(Icons.list_alt),
            tooltip: 'Ver Reservas', // Agregar tooltip
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PantallaReservas(),
                ),
              ).then((_) => setState(() {}));
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange.shade50, Colors.red.shade50],
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange.shade200, Colors.orange.shade100],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.orange.shade800),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Seleccione una mesa disponible para hacer su reserva',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: mesas.length,
                itemBuilder: (context, index) {
                  final mesa = mesas[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: mesa.reservada ? 2 : 6, // Cambiar elevación
                    shadowColor: Colors.orange.withOpacity(0.3), // Agregar color de sombra
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: mesa.reservada
                            ? Colors.grey.shade300
                            : Colors.orange.shade100,
                        child: Icon(
                          Icons.table_restaurant,
                          color: mesa.reservada ? Colors.grey : Colors.orange,
                          size: 30,
                        ),
                      ),
                      title: Text(
                        'Mesa ${mesa.numero}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: mesa.reservada ? Colors.grey : Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        'Capacidad: ${mesa.capacidad} personas',
                        style: TextStyle(
                          color: mesa.reservada ? Colors.grey : Colors.black54,
                        ),
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: mesa.reservada
                              ? Colors.red.shade100
                              : Colors.green.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          mesa.reservada ? 'Reservada' : 'Disponible',
                          style: TextStyle(
                            color: mesa.reservada
                                ? Colors.red.shade700
                                : Colors.green.shade700,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      onTap: mesa.reservada
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PantallaFormulario(mesa: mesa),
                                ),
                              ).then((_) => setState(() {}));
                            },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== PANTALLA 2: FORMULARIO DE RESERVA ====================

class PantallaFormulario extends StatefulWidget {
  final Mesa mesa;
  const PantallaFormulario({Key? key, required this.mesa}) : super(key: key);

  @override
  State<PantallaFormulario> createState() => _PantallaFormularioState();
}

class _PantallaFormularioState extends State<PantallaFormulario> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _telefonoController = TextEditingController();
  String _fecha = '';
  String _hora = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reservar Mesa ${widget.mesa.numero}')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange.shade50, Colors.red.shade50],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.table_restaurant,
                            size: 60,
                            color: Colors.orange,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Mesa ${widget.mesa.numero}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Capacidad: ${widget.mesa.capacidad} personas',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Datos del Cliente',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: _nombreController,
                            decoration: InputDecoration(
                              labelText: 'Nombre Completo',
                              prefixIcon: const Icon(Icons.person, color: Colors.deepOrange), // Cambiar color
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12), // Más redondeado
                                borderSide: BorderSide(color: Colors.orange.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.deepOrange, width: 2),
                              ),
                              filled: true,
                              fillColor: Colors.orange.shade50, // Agregar color de fondo
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese su nombre';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: _telefonoController,
                            decoration: InputDecoration(
                              labelText: 'Teléfono',
                              prefixIcon: const Icon(Icons.phone),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese su teléfono';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(
                              Icons.calendar_today,
                              color: Colors.orange,
                            ),
                            title: Text(
                              _fecha.isEmpty ? 'Seleccionar Fecha' : _fecha,
                              style: TextStyle(
                                color: _fecha.isEmpty
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            ),
                            onTap: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(
                                  const Duration(days: 90),
                                ),
                              );
                              if (picked != null) {
                                setState(() {
                                  _fecha =
                                      '${picked.day}/${picked.month}/${picked.year}';
                                });
                              }
                            },
                          ),
                          const Divider(),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(
                              Icons.access_time,
                              color: Colors.orange,
                            ),
                            title: Text(
                              _hora.isEmpty ? 'Seleccionar Hora' : _hora,
                              style: TextStyle(
                                color: _hora.isEmpty
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            ),
                            onTap: () async {
                              final TimeOfDay? picked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (picked != null) {
                                setState(() {
                                  _hora =
                                      '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.deepOrange, Colors.orange.shade600],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            _fecha.isNotEmpty &&
                            _hora.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PantallaMenu(
                                mesa: widget.mesa,
                                nombre: _nombreController.text,
                                telefono: _telefonoController.text,
                                fecha: _fecha,
                                hora: _hora,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Por favor complete todos los campos',
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.restaurant_menu),
                      label: const Text('Continuar al Menú (Opcional)'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent, // Transparente para mostrar gradiente
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          _fecha.isNotEmpty &&
                          _hora.isNotEmpty) {
                        _confirmarReservaSinMenu();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Por favor complete todos los campos',
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.check),
                    label: const Text('Confirmar Reserva Sin Menú'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _confirmarReservaSinMenu() {
    final reserva = Reserva(
      id: DateTime.now().millisecondsSinceEpoch,
      nombreCliente: _nombreController.text,
      telefono: _telefonoController.text,
      mesa: widget.mesa,
      fecha: _fecha,
      hora: _hora,
      menuSeleccionado: [],
      total: 0,
    );

    setState(() {
      reservasActivas.add(reserva);
      widget.mesa.reservada = true;
    });

    Navigator.popUntil(context, (route) => route.isFirst);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('¡Reserva confirmada exitosamente!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }
}

// ==================== PANTALLA 3: SELECCIÓN DE MENÚ ====================

class PantallaMenu extends StatefulWidget {
  final Mesa mesa;
  final String nombre;
  final String telefono;
  final String fecha;
  final String hora;

  const PantallaMenu({
    Key? key,
    required this.mesa,
    required this.nombre,
    required this.telefono,
    required this.fecha,
    required this.hora,
  }) : super(key: key);

  @override
  State<PantallaMenu> createState() => _PantallaMenuState();
}

class _PantallaMenuState extends State<PantallaMenu> {
  List<ElementoMenu> menuSeleccionado = [];

  double calcularTotal() {
    return menuSeleccionado.fold(0, (sum, item) => sum + item.precio);
  }

  Map<String, List<ElementoMenu>> agruparPorCategoria() {
    Map<String, List<ElementoMenu>> agrupado = {};
    for (var item in menuRestaurant) {
      if (!agrupado.containsKey(item.categoria)) {
        agrupado[item.categoria] = [];
      }
      agrupado[item.categoria]!.add(item);
    }
    return agrupado;
  }

  IconData _getIconoCategoria(String categoria) {
    switch (categoria) {
      case 'Entrada':
        return Icons.restaurant;
      case 'Plato Principal':
        return Icons.dinner_dining;
      case 'Postre':
        return Icons.cake;
      case 'Bebida':
        return Icons.local_drink;
      default:
        return Icons.restaurant_menu;
    }
  }

  @override
  Widget build(BuildContext context) {
    final menuAgrupado = agruparPorCategoria();

    return Scaffold(
      appBar: AppBar(title: const Text('Seleccionar Menú')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange.shade50, Colors.red.shade50],
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.orange.shade100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Seleccione los platos (Opcional)',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Total: ₲${calcularTotal().toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: menuAgrupado.entries.map((entry) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.orange.shade200, Colors.orange.shade100],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                _getIconoCategoria(entry.key), // Usar función helper
                                color: Colors.deepOrange,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                entry.key,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ...entry.value.map((item) {
                          final isSelected = menuSeleccionado.contains(item);
                          return CheckboxListTile(
                            title: Text(item.nombre),
                            subtitle: Text(
                              '₲${item.precio.toStringAsFixed(0)}',
                            ),
                            value: isSelected,
                            activeColor: Colors.orange,
                            onChanged: (bool? value) {
                              setState(() {
                                if (value == true) {
                                  menuSeleccionado.add(item);
                                } else {
                                  menuSeleccionado.remove(item);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  _confirmarReserva();
                },
                icon: const Icon(Icons.check_circle),
                label: Text(
                  menuSeleccionado.isEmpty
                      ? 'Confirmar Reserva Sin Menú'
                      : 'Confirmar Reserva con Menú',
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmarReserva() {
    final reserva = Reserva(
      id: DateTime.now().millisecondsSinceEpoch,
      nombreCliente: widget.nombre,
      telefono: widget.telefono,
      mesa: widget.mesa,
      fecha: widget.fecha,
      hora: widget.hora,
      menuSeleccionado: menuSeleccionado,
      total: calcularTotal(),
    );

    setState(() {
      reservasActivas.add(reserva);
      widget.mesa.reservada = true;
    });

    Navigator.popUntil(context, (route) => route.isFirst);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          menuSeleccionado.isEmpty
              ? '¡Reserva confirmada!'
              : '¡Reserva confirmada con menú!',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}

// ==================== PANTALLA 4: LISTA DE RESERVAS ====================

class PantallaReservas extends StatefulWidget {
  const PantallaReservas({Key? key}) : super(key: key);

  @override
  State<PantallaReservas> createState() => _PantallaReservasState();
}

class _PantallaReservasState extends State<PantallaReservas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis Reservas')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange.shade50, Colors.red.shade50],
          ),
        ),
        child: reservasActivas.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.event_busy, size: 80, color: Colors.grey),
                    SizedBox(height: 20),
                    Text(
                      'No hay reservas activas',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: reservasActivas.length,
                itemBuilder: (context, index) {
                  final reserva = reservasActivas[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person,
                                    color: Colors.orange,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    reserva.nombreCliente,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade100,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Mesa ${reserva.mesa.numero}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(
                                Icons.phone,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 8),
                              Text(reserva.telefono),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 8),
                              Text('${reserva.fecha} - ${reserva.hora}'),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.people,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Capacidad: ${reserva.mesa.capacidad} personas',
                              ),
                            ],
                          ),
                          if (reserva.menuSeleccionado.isNotEmpty) ...[
                            const Divider(height: 20),
                            const Text(
                              'Menú seleccionado:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ...reserva.menuSeleccionado.map(
                              (item) => Padding(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  bottom: 4,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('• ${item.nombre}'),
                                    Text(
                                      '₲${item.precio.toStringAsFixed(0)}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text(
                                  'Total: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '₲${reserva.total.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                          ],
                          const SizedBox(height: 12),
                          ElevatedButton.icon(
                            onPressed: () {
                              _mostrarDialogoCancelar(reserva);
                            },
                            icon: const Icon(Icons.cancel),
                            label: const Text('Cancelar Reserva'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              minimumSize: const Size(double.infinity, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  void _mostrarDialogoCancelar(Reserva reserva) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cancelar Reserva'),
          content: Text(
            '¿Está seguro que desea cancelar la reserva de ${reserva.nombreCliente}?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  reservasActivas.remove(reserva);
                  reserva.mesa.reservada = false;
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Reserva cancelada exitosamente'),
                    backgroundColor: Colors.orange,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Sí, cancelar'),
            ),
          ],
        );
      },
    );
  }
}
