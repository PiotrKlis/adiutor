import 'package:flutter/material.dart';
import '../models/patient.dart';
import '../models/recording.dart';
import 'recording_screen.dart';

class PatientDetails extends StatefulWidget {
  final Patient patient;

  const PatientDetails({super.key, required this.patient});

  @override
  State<PatientDetails> createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  final List<Recording> _recordings = [
    Recording(
      name: '10:30 15/03/2024',
      recording:
          'Pacjent zgłasza bóle głowy w okolicy skroniowej, występujące głównie rano. Zauważył, że objawy nasilają się przy zmianie pogody. Nie przyjmuje żadnych leków przeciwbólowych. Zalecono prowadzenie dziennika bólów głowy i obserwację czynników wywołujących.',
      title: 'Pierwsza wizyta',
    ),
    Recording(
      name: '14:45 14/03/2024',
      recording:
          'Kontrola po tygodniu od pierwszej wizyty. Pacjent zgłasza poprawę - bóle głowy występują rzadziej i są mniej intensywne. Dziennik bólów głowy wskazuje na związek z niedoborem snu. Zalecono regularny tryb dnia i techniki relaksacyjne przed snem.',
      title: 'Kontrola',
    ),
    Recording(
      name: '09:15 13/03/2024',
      recording:
          'Pacjent zgłasza nowe objawy - zawroty głowy i problemy z koncentracją. Bóle głowy ustąpiły po wprowadzeniu zaleconych zmian. Zalecono wykonanie podstawowych badań krwi i konsultację neurologiczną.',
    ),
  ];

  final _titleController = TextEditingController();

  void _showAddRecordingDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Dodaj nowe nagranie'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Nazwa (opcjonalnie)',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _titleController.clear();
                  Navigator.pop(context);
                },
                child: const Text('Anuluj'),
              ),
              TextButton(
                onPressed: () {
                  final now = DateTime.now();
                  final formattedDate =
                      '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} ${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';

                  setState(() {
                    _recordings.insert(
                      0,
                      Recording(
                        name: formattedDate,
                        recording: 'New Recording',
                        title:
                            _titleController.text.isNotEmpty
                                ? _titleController.text
                                : null,
                      ),
                    );
                  });

                  _titleController.clear();
                  Navigator.pop(context);
                },
                child: const Text('Dodaj'),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.patient.name} ${widget.patient.surname}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nagrania', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _recordings.length,
                itemBuilder: (context, index) {
                  final recording = _recordings[index];
                  return Column(
                    children: [
                      ListTile(
                        title: Text(recording.title ?? recording.name),
                        subtitle:
                            recording.title != null
                                ? Text(recording.name)
                                : null,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      RecordingScreen(recording: recording),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 1),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddRecordingDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
