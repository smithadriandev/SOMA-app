import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../shared/widgets/botao_principal.dart';
import 'mock/mock_ofertas_medicamentos.dart';
import 'models/oferta_medicamento.dart';
import 'widgets/card_oferta_medicamento.dart';

class PaginaBuscaMedicamentos extends StatefulWidget {
  const PaginaBuscaMedicamentos({super.key});

  @override
  State<PaginaBuscaMedicamentos> createState() =>
      _PaginaBuscaMedicamentosState();
}

class _PaginaBuscaMedicamentosState extends State<PaginaBuscaMedicamentos> {
  final _searchController = TextEditingController();
  List<OfertaMedicamento> _ofertas = [];
  bool _hasSearched = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _search([String? query]) {
    final searchText = (query ?? _searchController.text).trim();

    if (searchText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Digite um medicamento para buscar')),
      );
      return;
    }

    final results = MockOfertasMedicamentos.buscarOfertas(searchText);
    setState(() {
      _hasSearched = true;
      _ofertas = results;
    });

    if (results.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Medicamento não encontrado')),
      );
    }
  }

  void _selectCommonMedicine(String medicine) {
    _searchController.text = medicine;
    _search(medicine);
  }

  void _clearSearch() {
    setState(() {
      _hasSearched = false;
      _ofertas = [];
      _searchController.clear();
    });
  }

  void _abrirMapa() {
    Navigator.pushNamed(context, RotasApp.mapaFarmacias);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final secondaryColor = theme.textTheme.bodySmall?.color ?? textColor;
    final fieldColor = theme.inputDecorationTheme.fillColor ?? theme.cardColor;

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
                      Expanded(
                        child: Text(
                          'Encontrar medicamento',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: theme.dividerColor),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(22, 22, 22, 18),
                    children: [
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: fieldColor,
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: TextField(
                          controller: _searchController,
                          textInputAction: TextInputAction.search,
                          onSubmitted: _search,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Digite medicamento',
                            prefixIcon: Icon(
                              Icons.search,
                              color: secondaryColor,
                            ),
                            suffixIcon: IconButton(
                              onPressed: _search,
                              icon: Icon(
                                Icons.arrow_forward,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 13,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),
                      Text(
                        'Medicamentos favoritos',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children:
                            MockOfertasMedicamentos.medicamentosComuns.map(
                          (medicine) {
                            return ActionChip(
                              label: Text(medicine),
                              onPressed: () => _selectCommonMedicine(medicine),
                              backgroundColor: fieldColor,
                              side: BorderSide(
                                color: theme.dividerColor,
                                width: 0.8,
                              ),
                              labelStyle: TextStyle(
                                color: textColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                      const SizedBox(height: 14),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme.cardColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: theme.dividerColor),
                        ),
                        child: Text(
                          'Prioridade indica a import\u00E2ncia do medicamento na rotina do paciente.',
                          style: TextStyle(
                            color: secondaryColor,
                            fontSize: 12,
                            height: 1.3,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (_hasSearched) ...[
                        const SizedBox(height: 26),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Ofertas encontradas',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            Text(
                              '${_ofertas.length}',
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        if (_ofertas.isEmpty)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: theme.cardColor,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text(
                              'Nenhuma oferta encontrada para este medicamento',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: secondaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        else ...[
                          CardOfertaMedicamento(
                            offer: _ofertas.first,
                            isBestOffer: true,
                            onViewMap: _abrirMapa,
                          ),
                          if (_ofertas.length > 1) ...[
                            const SizedBox(height: 4),
                            Text(
                              'Outras ofertas',
                              style: TextStyle(
                                color: textColor,
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ..._ofertas.skip(1).map(
                                  (offer) => CardOfertaMedicamento(
                                    offer: offer,
                                    isBestOffer: false,
                                    onViewMap: _abrirMapa,
                                  ),
                                ),
                          ],
                        ],
                      ],
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 8, 22, 20),
                  child: Center(
                    child: BotaoPrincipal(
                      text: _hasSearched ? 'Nova busca' : 'Buscar medicamento',
                      width: 220,
                      height: 48,
                      fontSize: 16,
                      onPressed: _hasSearched ? _clearSearch : _search,
                    ),
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
