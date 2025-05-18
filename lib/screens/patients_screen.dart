import 'package:flutter/material.dart';
import '../models/patient.dart';
import 'patient_details.dart';

class PatientsScreen extends StatefulWidget {
  const PatientsScreen({super.key});

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  final List<Patient> _patients = [
    Patient(name: 'Jan', surname: 'Kowalski'),
    Patient(name: 'Anna', surname: 'Nowak'),
    Patient(name: 'Piotr', surname: 'Wiśniewski'),
    Patient(name: 'Maria', surname: 'Lewandowska'),
    Patient(name: 'Tomasz', surname: 'Zieliński'),
    Patient(name: 'Katarzyna', surname: 'Szymańska'),
  ];

  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();

  void _showAddPatientDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Dodaj nowego pacjenta'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Imię'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _surnameController,
                  decoration: const InputDecoration(labelText: 'Nazwisko'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _nameController.clear();
                  _surnameController.clear();
                  Navigator.pop(context);
                },
                child: const Text('Anuluj'),
              ),
              TextButton(
                onPressed: () {
                  if (_nameController.text.isNotEmpty &&
                      _surnameController.text.isNotEmpty) {
                    setState(() {
                      _patients.add(
                        Patient(
                          name: _nameController.text,
                          surname: _surnameController.text,
                        ),
                      );
                    });
                    _nameController.clear();
                    _surnameController.clear();
                    Navigator.pop(context);
                  }
                },
                child: const Text('Dodaj'),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pacjenci')),
      body: ListView.builder(
        itemCount: _patients.length,
        itemBuilder: (context, index) {
          final patient = _patients[index];
          return Column(
            children: [
              ListTile(
                title: Text('${patient.name} ${patient.surname}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PatientDetails(patient: patient),
                    ),
                  );
                },
              ),
              const Divider(height: 1),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddPatientDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
