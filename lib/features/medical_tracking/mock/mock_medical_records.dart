import '../models/medical_record.dart';

class MockMedicalRecords {
  static List<MedicalRecord> initialRecords() {
    return const [
      MedicalRecord(
        dateTimeText: 'Hoje - 08:00',
        type: 'Medicamento',
        description: 'Remédio da manhã tomado corretamente',
        impact: MedicalImpact.positive,
      ),
      MedicalRecord(
        dateTimeText: 'Hoje - 10:30',
        type: 'Humor',
        description: 'Paciente ficou calmo e comunicativo',
        impact: MedicalImpact.positive,
      ),
      MedicalRecord(
        dateTimeText: 'Hoje - 12:15',
        type: 'Alimentação',
        description: 'Almoçou bem e bebeu água',
        impact: MedicalImpact.positive,
      ),
      MedicalRecord(
        dateTimeText: 'Ontem - 22:00',
        type: 'Sono',
        description: 'Acordou duas vezes durante a noite',
        impact: MedicalImpact.attention,
      ),
      MedicalRecord(
        dateTimeText: 'Ontem - 16:40',
        type: 'Sintoma',
        description: 'Apresentou leve confusão mental',
        impact: MedicalImpact.attention,
      ),
    ];
  }
}
