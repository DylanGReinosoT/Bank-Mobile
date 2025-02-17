import 'package:bank_mobile/model/card.dart';
import 'package:flutter/material.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _numeroTarjetaController =
      TextEditingController();
  final TextEditingController _codigoController = TextEditingController();
  final TextEditingController _saldoController = TextEditingController();
  final TextEditingController _titularController = TextEditingController();
  DateTime? _fechaVencimiento;
  String _tipoTarjeta = 'Visa';

  void _guardarTarjeta() {
    if (_formKey.currentState!.validate() && _fechaVencimiento != null) {
      final nuevaTarjeta = CardsModel(
        numeroTarjeta: _numeroTarjetaController.text,
        dateVencimiento: _fechaVencimiento!,
        codigo: _codigoController.text,
        tipoTarjeta: _tipoTarjeta,
        saldo: double.parse(_saldoController.text),
        titular: _titularController.text,
        dateCreacion: DateTime.now(),
      );

      Navigator.pop(context, nuevaTarjeta);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF041A3A),
      appBar: AppBar(
        title: const Text('Agregar Tarjeta'),
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
              _buildCardPreview(),
              const SizedBox(height: 20),
              _buildTextField(_numeroTarjetaController, 'Número de Tarjeta',
                  TextInputType.number, 16),
              _buildTextField(_titularController, 'Titular de la Tarjeta',
                  TextInputType.text),
              _buildTextField(_codigoController, 'Código de Seguridad (CVV)',
                  TextInputType.number, 3),
              _buildTextField(
                  _saldoController, 'Saldo Inicial', TextInputType.number),
              _buildDropdownTipoTarjeta(),
              _buildFechaVencimientoPicker(context),
              const SizedBox(height: 20),
              _buildGuardarButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardPreview() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Vista previa de la tarjeta',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 10),
          Text(
            _numeroTarjetaController.text.isEmpty
                ? '**** **** **** ****'
                : _numeroTarjetaController.text,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _titularController.text.isEmpty
                    ? 'Nombre del Titular'
                    : _titularController.text,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                _fechaVencimiento == null
                    ? 'MM/YY'
                    : '${_fechaVencimiento!.month}/${_fechaVencimiento!.year}',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      TextInputType keyboardType,
      [int? maxLength]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLength: maxLength,
        style: const TextStyle(color: Colors.white),
        decoration: _inputDecoration(label),
        validator: (value) {
          if (value == null || value.isEmpty)
            return 'Este campo es obligatorio';
          if (label == 'Número de Tarjeta' && value.length != 16)
            return 'Debe contener 16 dígitos';
          if (label == 'Código de Seguridad (CVV)' && value.length != 3)
            return 'Debe contener 3 dígitos';
          if (label == 'Saldo Inicial' && double.tryParse(value) == null)
            return 'Ingrese un valor válido';
          return null;
        },
      ),
    );
  }

  Widget _buildDropdownTipoTarjeta() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: _tipoTarjeta,
        items: const [
          DropdownMenuItem(value: 'Visa', child: Text('Visa')),
          DropdownMenuItem(value: 'Mastercard', child: Text('Mastercard')),
        ],
        onChanged: (value) => setState(() => _tipoTarjeta = value!),
        decoration: _inputDecoration('Tipo de Tarjeta'),
      ),
    );
  }

  Widget _buildFechaVencimientoPicker(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        tileColor: Colors.white.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          _fechaVencimiento == null
              ? 'Seleccionar Fecha de Vencimiento'
              : 'Vence: ${_fechaVencimiento!.month}/${_fechaVencimiento!.year}',
          style: const TextStyle(color: Colors.white),
        ),
        trailing: const Icon(Icons.calendar_today, color: Colors.white),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
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
            setState(() => _fechaVencimiento = pickedDate);
          }
        },
      ),
    );
  }

  Widget _buildGuardarButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _guardarTarjeta,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: const Text('Guardar Tarjeta',
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
