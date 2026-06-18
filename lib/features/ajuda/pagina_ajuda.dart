import 'package:flutter/material.dart';

class PaginaAjuda extends StatelessWidget {
  const PaginaAjuda({super.key});

  static const _items = [
    _ItemAjuda(
      icon: Icons.touch_app_outlined,
      title: 'Como usar o Soma',
      description: 'Aprenda as fun\u00E7\u00F5es principais do app.',
      content:
          'Tarefas Di\u00E1rias:\nUse para marcar atividades importantes da rotina.\n\nAcompanhamento M\u00E9dico:\nUse para registrar humor, sono, medica\u00E7\u00E3o, sintomas e informa\u00E7\u00F5es de sa\u00FAde.\n\nConex\u00F5es:\nCadastre familiares ou cuidadores de confian\u00E7a.\n\nMapa:\nVeja farm\u00E1cias pr\u00F3ximas.\n\nEncontrar Medicamento:\nBusque medicamentos mockados e veja ofertas em farm\u00E1cias.\n\nAlerta:\nSimule o envio de alerta para contatos de emerg\u00EAncia.',
    ),
    _ItemAjuda(
      icon: Icons.volunteer_activism_outlined,
      title: 'Dicas para cuidadores',
      description:
          'Orienta\u00E7\u00F5es simples para apoiar a rotina di\u00E1ria.',
      content:
          'Mantenha uma rotina di\u00E1ria simples.\n\nUse lembretes visuais.\n\nEvite mudan\u00E7as bruscas no ambiente.\n\nFale com calma e use frases curtas.\n\nDeixe objetos importantes sempre no mesmo lugar.\n\nRegistre mudan\u00E7as de humor, sono ou alimenta\u00E7\u00E3o.',
    ),
    _ItemAjuda(
      icon: Icons.health_and_safety_outlined,
      title: 'Em caso de crise',
      description: 'Passos de apoio para momentos de maior aten\u00E7\u00E3o.',
      content:
          'Mantenha a calma.\n\nFale devagar e com voz tranquila.\n\nEvite discutir ou corrigir de forma brusca.\n\nLeve a pessoa para um local seguro.\n\nEntre em contato com um cuidador ou familiar.\n\nEm caso de emerg\u00EAncia real, ligue para o servi\u00E7o de emerg\u00EAncia.\n\nO Soma n\u00E3o substitui atendimento m\u00E9dico ou servi\u00E7o de emerg\u00EAncia.',
    ),
    _ItemAjuda(
      icon: Icons.quiz_outlined,
      title: 'Perguntas frequentes',
      description: 'Respostas r\u00E1pidas para d\u00FAvidas comuns.',
      content:
          'Como cadastrar uma conex\u00E3o?\nAcesse a sidebar e toque em \u201CConex\u00F5es\u201D. Depois toque em \u201CAdicionar conex\u00E3o\u201D.\n\nComo marcar uma tarefa?\nEntre em Tarefas Di\u00E1rias e toque na tarefa desejada.\n\nComo ativar o tema escuro?\nAcesse Configura\u00E7\u00F5es e ative \u201CTema escuro\u201D.\n\nComo encontrar farm\u00E1cias?\nToque no \u00EDcone de mapa na barra inferior.\n\nComo buscar medicamentos?\nToque no \u00EDcone de medicamento na barra inferior.',
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
                      return _CardAjuda(item: _items[index]);
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

class _CardAjuda extends StatelessWidget {
  const _CardAjuda({required this.item});

  final _ItemAjuda item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final secondaryColor = theme.textTheme.bodySmall?.color ?? textColor;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: isDark ? 0.8 : 0.65),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.16 : 0.06),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          childrenPadding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
          leading: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              item.icon,
              color: theme.colorScheme.primary,
              size: 27,
            ),
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
            padding: const EdgeInsets.only(top: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.description,
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 13,
                    height: 1.3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 7),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.touch_app_outlined,
                      color: theme.colorScheme.primary,
                      size: 15,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Toque para ver mais',
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          iconColor: theme.colorScheme.primary,
          collapsedIconColor: theme.colorScheme.primary,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor.withValues(
                  alpha: isDark ? 0.28 : 0.7,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: theme.dividerColor.withValues(alpha: 0.6)),
              ),
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

class _ItemAjuda {
  const _ItemAjuda({
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
