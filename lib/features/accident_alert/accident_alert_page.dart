import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../shared/mock/mock_connections.dart';
import '../../shared/widgets/primary_button.dart';

class AccidentAlertPage extends StatefulWidget {
  const AccidentAlertPage({super.key});

  @override
  State<AccidentAlertPage> createState() => _AccidentAlertPageState();
}

class _AccidentAlertPageState extends State<AccidentAlertPage> {
  String _lastAlertText = 'Nenhum alerta enviado nesta sessão';
  String? _lastReason;

  final List<_AlertReason> _alertReasons = const [
    _AlertReason(
      title: 'Eu caí ou me machuquei',
      description: 'Preciso de ajuda porque tive uma queda ou acidente.',
      icon: Icons.personal_injury_outlined,
    ),
    _AlertReason(
      title: 'Estou perdido ou confuso',
      description:
          'Preciso de ajuda porque não sei onde estou ou estou confuso.',
      icon: Icons.psychology_alt_outlined,
    ),
    _AlertReason(
      title: 'Estou me sentindo mal',
      description: 'Preciso de ajuda por dor, tontura, fraqueza ou mal-estar.',
      icon: Icons.health_and_safety_outlined,
    ),
  ];

  List<Connection> get _contacts => MockConnections.connections;

  Future<void> _chooseAlertReason() async {
    final reason = await showModalBottomSheet<_AlertReason>(
      context: context,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) => _AlertReasonSheet(reasons: _alertReasons),
    );

    if (reason != null) {
      _sendAlert(reason);
    }
  }

  void _sendAlert(_AlertReason reason) {
    setState(() {
      _lastReason = reason.title;
      _lastAlertText = 'Último alerta enviado: há poucos segundos';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Alerta de ${reason.title.toLowerCase()} enviado para os contatos de emergência',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final secondaryColor = theme.textTheme.bodySmall?.color ?? Colors.grey;
    final infoCardColor = theme.brightness == Brightness.dark
        ? theme.cardColor
        : SomaColors.fieldBlue;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 38, 24, 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back,
                          color: textColor,
                          size: 29,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 40,
                          minHeight: 40,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Alerta de acidentes',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  Center(
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.78,
                      constraints: const BoxConstraints(maxWidth: 310),
                      padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
                      decoration: BoxDecoration(
                        color: infoCardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: theme.dividerColor),
                      ),
                      child: Text(
                        'Toque em “Novo alerta”\n'
                        'para escolher o motivo\n'
                        'e enviar uma notificação\n'
                        'de emergência para os\n'
                        'contatos de emergência.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          height: 1.22,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          _lastAlertText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: secondaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (_lastReason != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            'Motivo: $_lastReason',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'Contatos de emergência',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ..._contacts.map(
                    (contact) => _EmergencyContactTile(contact: contact),
                  ),
                  const Spacer(),
                  Center(
                    child: PrimaryButton(
                      text: 'Novo alerta',
                      width: 180,
                      height: 48,
                      fontSize: 16,
                      onPressed: _chooseAlertReason,
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
}

class _AlertReason {
  const _AlertReason({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final IconData icon;
}

class _AlertReasonSheet extends StatelessWidget {
  const _AlertReasonSheet({required this.reasons});

  final List<_AlertReason> reasons;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final secondaryColor = theme.textTheme.bodySmall?.color ?? Colors.grey;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Qual o motivo do alerta?',
              style: TextStyle(
                color: textColor,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Escolha uma opção para avisar os contatos.',
              style: TextStyle(
                color: secondaryColor,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 14),
            ...reasons.map(
              (reason) => _AlertReasonTile(reason: reason),
            ),
          ],
        ),
      ),
    );
  }
}

class _AlertReasonTile extends StatelessWidget {
  const _AlertReasonTile({required this.reason});

  final _AlertReason reason;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final secondaryColor = theme.textTheme.bodySmall?.color ?? Colors.grey;

    return InkWell(
      onTap: () => Navigator.pop(context, reason),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.brightness == Brightness.dark
              ? theme.scaffoldBackgroundColor
              : const Color(0xFFF2FBFF),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.dividerColor),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: SomaColors.primaryBlue.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                reason.icon,
                color: SomaColors.primaryBlue,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reason.title,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    reason.description,
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmergencyContactTile extends StatelessWidget {
  const _EmergencyContactTile({required this.contact});

  final Connection contact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final secondaryColor = theme.textTheme.bodySmall?.color ?? Colors.grey;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? theme.cardColor
            : const Color(0xFFF2FBFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.contact_phone_outlined,
            color: SomaColors.primaryBlue,
            size: 22,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${contact.name} - ${contact.relationship}',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  contact.phone,
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
