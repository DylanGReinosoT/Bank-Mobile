import 'package:bank_mobile/model/payment.dart';
import 'package:flutter/material.dart';

class AddPagoPage extends StatefulWidget {
  const AddPagoPage({super.key});

  @override
  State<AddPagoPage> createState() => _AddPagoPageState();
}

class _AddPagoPageState extends State<AddPagoPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _montoController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  DateTime? _fechaPago;
  String _estado = 'Pendiente';

  void _guardarPago() {
    if (_formKey.currentState!.validate() && _fechaPago != null) {
      final nuevoPago = Pagos(
        monto: double.parse(_montoController.text),
        fechaPago: _fechaPago!,
        descripcion: _descripcionController.text,
        estado: _estado,
      );

      Navigator.pop(context, nuevoPago);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF041A3A),
      appBar: AppBar(
        title: const Text('Agregar Pago'),
        backgroundColor: Colors.amber,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                  _descripcionController, 'Descripción', TextInputType.text),
              _buildTextField(_montoController, 'Monto', TextInputType.number),
              _buildFechaPagoPicker(context),
              _buildDropdownEstado(),
              const SizedBox(height: 20),
              _buildGuardarButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      TextInputType keyboardType) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
        decoration: _inputDecoration(label),
        validator: (value) {
          if (value == null || value.isEmpty)
            return 'Este campo es obligatorio';
          if (label == 'Monto' && double.tryParse(value) == null)
            return 'Ingrese un valor válido';
          return null;
        },
      ),
    );
  }

  Widget _buildFechaPagoPicker(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        tileColor: Colors.white.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          _fechaPago == null
              ? 'Seleccionar Fecha de Pago'
              : 'Pago: ${_fechaPago!.day}/${_fechaPago!.month}/${_fechaPago!.year}',
          style: const TextStyle(color: Colors.white),
        ),
        trailing: const Icon(Icons.calendar_today, color: Colors.white),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2035),
            builder: (context, child) {
              return Theme(
                data: ThemeData.dark().copyWith(
                  colorScheme: const ColorScheme.dark(primary: Colors.amber),
                ),
                child: child!,
              );
            },
          );
          if (pickedDate != null) {
            setState(() => _fechaPago = pickedDate);
          }
        },
      ),
    );
  }

  Widget _buildDropdownEstado() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: _estado,
        items: const [
          DropdownMenuItem(value: 'Pendiente', child: Text('Pendiente')),
          DropdownMenuItem(value: 'Completado', child: Text('Completado')),
        ],
        onChanged: (value) => setState(() => _estado = value!),
        decoration: _inputDecoration('Estado del Pago'),
      ),
    );
  }

  Widget _buildGuardarButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _guardarPago,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: const Text('Guardar Pago',
            style: TextStyle(fontSize: 16, color: Colors.black)),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
