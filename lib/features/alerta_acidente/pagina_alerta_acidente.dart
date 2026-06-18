import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../shared/mock/mock_conexoes.dart';
import '../../shared/widgets/botao_principal.dart';

class PaginaAlertaAcidente extends StatefulWidget {
  const PaginaAlertaAcidente({super.key});

  @override
  State<PaginaAlertaAcidente> createState() => _PaginaAlertaAcidenteState();
}

class _PaginaAlertaAcidenteState extends State<PaginaAlertaAcidente> {
  String _ultimoAlerta = '\u00DAltimo alerta enviado: agora';
  String? _ultimoMotivo;

  final List<_MotivoAlerta> _motivosAlerta = const [
    _MotivoAlerta(
      titulo: 'Eu ca\u00ED ou me machuquei',
      descricao: 'Preciso de ajuda porque tive uma queda ou acidente.',
      icone: Icons.personal_injury_outlined,
    ),
    _MotivoAlerta(
      titulo: 'Estou perdido ou confuso',
      descricao:
          'Preciso de ajuda porque n\u00E3o sei onde estou ou estou confuso.',
      icone: Icons.psychology_alt_outlined,
    ),
    _MotivoAlerta(
      titulo: 'Estou me sentindo mal',
      descricao: 'Preciso de ajuda por dor, tontura, fraqueza ou mal-estar.',
      icone: Icons.health_and_safety_outlined,
    ),
  ];

  List<Conexao> get _contatosNotificados => MockConexoes.conexoes;

  Future<void> _escolherMotivoAlerta() async {
    final motivo = await showModalBottomSheet<_MotivoAlerta>(
      context: context,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) => _FolhaMotivoAlerta(motivos: _motivosAlerta),
    );

    if (motivo != null) {
      final confirmado = await _confirmarEnvioAlerta();
      if (confirmado) {
        _enviarAlerta(motivo);
      }
    }
  }

  Future<bool> _confirmarEnvioAlerta() async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        final theme = Theme.of(dialogContext);
        final textColor = theme.colorScheme.onSurface;
        final secondaryColor = theme.textTheme.bodySmall?.color ?? textColor;

        return AlertDialog(
          backgroundColor: theme.cardColor,
          title: Text(
            'Confirmar alerta?',
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: Text(
            'Deseja enviar alerta para os contatos de emerg\u00EAncia?',
            style: TextStyle(
              color: secondaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text(
                'Enviar alerta',
                style: TextStyle(
                  color: Color(0xFFD41717),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        );
      },
    );

    return confirmar == true;
  }

  void _enviarAlerta(_MotivoAlerta motivo) {
    setState(() {
      _ultimoMotivo = motivo.titulo;
      _ultimoAlerta = '\u00DAltimo alerta enviado: h\u00E1 poucos segundos';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Alerta enviado para os contatos de emerg\u00EAncia'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final secondaryColor = theme.textTheme.bodySmall?.color ?? Colors.grey;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 30, 22, 22),
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
                  const SizedBox(height: 28),
                  _CardAlertaEnviado(
                    ultimoAlerta: _ultimoAlerta,
                    ultimoMotivo: _ultimoMotivo,
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Contatos notificados',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView(
                      children: [
                        ..._contatosNotificados.map(
                          (contato) => _ItemContatoEmergencia(contato: contato),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Nenhuma mensagem real foi enviada. Esta tela apenas simula o envio do alerta.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: secondaryColor,
                            fontSize: 12,
                            height: 1.35,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: BotaoPrincipal(
                      text: 'Novo alerta',
                      width: 190,
                      height: 50,
                      fontSize: 16,
                      onPressed: _escolherMotivoAlerta,
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

class _CardAlertaEnviado extends StatelessWidget {
  const _CardAlertaEnviado({
    required this.ultimoAlerta,
    required this.ultimoMotivo,
  });

  final String ultimoAlerta;
  final String? ultimoMotivo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = theme.colorScheme.onSurface;
    final secondaryColor = theme.textTheme.bodySmall?.color ?? Colors.grey;
    final alertColor =
        isDark ? const Color(0xFFEF5350) : const Color(0xFFE53935);
    final cardColor =
        isDark ? const Color(0xFF331F1F) : const Color(0xFFFFE5E5);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: alertColor, width: 1.8),
        boxShadow: [
          BoxShadow(
            color: alertColor.withValues(alpha: isDark ? 0.18 : 0.16),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: alertColor.withValues(alpha: 0.16),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.campaign_outlined,
              color: alertColor,
              size: 44,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Alerta enviado!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Os contatos de emerg\u00EAncia cadastrados foram notificados.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              height: 1.3,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            ultimoAlerta,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
          if (ultimoMotivo != null) ...[
            const SizedBox(height: 5),
            Text(
              'Motivo: $ultimoMotivo',
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
    );
  }
}

class _MotivoAlerta {
  const _MotivoAlerta({
    required this.titulo,
    required this.descricao,
    required this.icone,
  });

  final String titulo;
  final String descricao;
  final IconData icone;
}

class _FolhaMotivoAlerta extends StatelessWidget {
  const _FolhaMotivoAlerta({required this.motivos});

  final List<_MotivoAlerta> motivos;

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
              'Escolha uma op\u00E7\u00E3o para avisar os contatos.',
              style: TextStyle(
                color: secondaryColor,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 14),
            ...motivos.map(
              (motivo) => _ItemMotivoAlerta(motivo: motivo),
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemMotivoAlerta extends StatelessWidget {
  const _ItemMotivoAlerta({required this.motivo});

  final _MotivoAlerta motivo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final secondaryColor = theme.textTheme.bodySmall?.color ?? Colors.grey;

    return InkWell(
      onTap: () => Navigator.pop(context, motivo),
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
                motivo.icone,
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
                    motivo.titulo,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    motivo.descricao,
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

class _ItemContatoEmergencia extends StatelessWidget {
  const _ItemContatoEmergencia({required this.contato});

  final Conexao contato;

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
                  '${contato.name} - ${contato.relationship}',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  contato.phone,
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
