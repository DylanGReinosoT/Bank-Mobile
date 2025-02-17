import 'package:flutter/material.dart';

class AddTransferPage extends StatefulWidget {
  const AddTransferPage({super.key});

  @override
  State<AddTransferPage> createState() => _AddTransferPageState();
}

class _AddTransferPageState extends State<AddTransferPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Procesar la transferencia aquí
      Navigator.pop(context);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nueva Transferencia"),
        backgroundColor: Colors.amber,
      ),
      backgroundColor: const Color(0xFF041A3A),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título del formulario
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Título"),
                validator: (value) => value!.isEmpty ? "Campo requerido" : null,
              ),

              // Descripción del formulario
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: "Descripción"),
              ),

              // Monto del formulario
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Monto"),
                validator: (value) =>
                    value!.isEmpty ? "Ingrese un monto válido" : null,
              ),

              const SizedBox(height: 16),

              // Selector de fecha
              Row(
                children: [
                  Text("Fecha: ${selectedDate.toLocal()}".split(' ')[0],
                      style: const TextStyle(color: Colors.amber)),
                  IconButton(
                    icon: const Icon(Icons.calendar_today, color: Colors.amber),
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Botón para agregar la transferencia
              Center(
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                  onPressed: _submitForm,
                  child: const Text("Agregar",
                      style: TextStyle(color: Colors.black)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
