import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../shared/widgets/botao_principal.dart';
import 'mock/mock_conexoes.dart';
import 'widgets/card_conexao.dart';

class PaginaConexoes extends StatefulWidget {
  const PaginaConexoes({super.key});

  @override
  State<PaginaConexoes> createState() => _PaginaConexoesState();
}

class _PaginaConexoesState extends State<PaginaConexoes> {
  Future<void> _openAddConexao() async {
    await Navigator.pushNamed(context, RotasApp.adicionarConexao);
    if (mounted) {
      setState(() {});
    }
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
            constraints: const BoxConstraints(maxWidth: 520),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 18, 20, 12),
                  child: Row(
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
                      Text(
                        'Conexões',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: theme.dividerColor),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(18, 18, 18, 22),
                    children: [
                      Text(
                        'Contatos de emergência cadastrados',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Essas pessoas podem ser avisadas em situações de emergência.',
                        style: TextStyle(
                          color: secondaryColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...MockConexoes.conexoes.map(
                        (connection) => CardConexao(connection: connection),
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: BotaoPrincipal(
                          text: 'Adicionar conexão',
                          width: 220,
                          height: 48,
                          fontSize: 16,
                          onPressed: _openAddConexao,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
