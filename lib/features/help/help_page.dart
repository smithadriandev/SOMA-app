import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  static const _items = [
    _HelpItem(
      icon: Icons.touch_app_outlined,
      title: 'Como usar o Soma',
      description: 'Conheça as principais áreas do aplicativo.',
      content: 'Tarefas Diárias:\nUse para marcar atividades importantes da rotina.\n\nAcompanhamento Médico:\nUse para registrar humor, sono, medicação, sintomas e informações de saúde.\n\nConexões:\nCadastre familiares ou cuidadores de confiança.\n\nMapa:\nVeja farmácias próximas.\n\nEncontrar Medicamento:\nBusque medicamentos e veja ofertas em farmácias.\n\nAlerta:\nEnvie um alerta para contatos de emergência.',
    ),
    _HelpItem(
      icon: Icons.volunteer_activism_outlined,
      title: 'Dicas para cuidadores',
      description: 'Orientações simples para apoiar a rotina diária.',
      content: 'Mantenha uma rotina diária simples.\n\nUse lembretes visuais.\n\nEvite mudanças bruscas no ambiente.\n\nFale com calma e use frases curtas.\n\nDeixe objetos importantes sempre no mesmo lugar.\n\nRegistre mudanças de humor, sono ou alimentação.',
    ),
    _HelpItem(
      icon: Icons.health_and_safety_outlined,
      title: 'Em caso de crise',
      description: 'Passos de apoio para momentos de maior atenção.',
      content: 'Mantenha a calma.\n\nFale devagar e com voz tranquila.\n\nEvite discutir ou corrigir de forma brusca.\n\nLeve a pessoa para um local seguro.\n\nEntre em contato com um cuidador ou familiar.\n\nEm caso de emergência real, ligue para o serviço de emergência.\n\nO Soma não substitui atendimento médico ou serviço de emergência.',
    ),
    _HelpItem(
      icon: Icons.quiz_outlined,
      title: 'Perguntas frequentes',
      description: 'Respostas rápidas para dúvidas comuns.',
      content: 'Como cadastrar uma conexão?\nAcesse a sidebar e toque em “Adicionar conexão”.\n\nComo marcar uma tarefa?\nEntre em Tarefas Diárias e toque na tarefa desejada.\n\nComo ativar o tema escuro?\nAcesse Configurações e ative “Tema escuro”.\n\nComo encontrar farmácias?\nToque no ícone de mapa na barra inferior.\n\nComo buscar medicamentos?\nToque no ícone de farmácia na barra inferior.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        'Ajuda',
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
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(22, 22, 22, 28),
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      return _HelpCard(item: _items[index]);
                    },
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

class _HelpCard extends StatelessWidget {
  const _HelpCard({required this.item});

  final _HelpItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final secondaryColor = theme.textTheme.bodySmall?.color ?? textColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          childrenPadding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
          leading: Icon(
            item.icon,
            color: theme.colorScheme.primary,
            size: 30,
          ),
          title: Text(
            item.title,
            style: TextStyle(
              color: textColor,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              item.description,
              style: TextStyle(
                color: secondaryColor,
                fontSize: 13,
                height: 1.3,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          iconColor: theme.colorScheme.primary,
          collapsedIconColor: textColor,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                item.content,
                style: TextStyle(
                  color: textColor,
                  fontSize: 15,
                  height: 1.45,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HelpItem {
  const _HelpItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.content,
  });

  final IconData icon;
  final String title;
  final String description;
  final String content;
}