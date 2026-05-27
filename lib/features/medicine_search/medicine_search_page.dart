import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../shared/widgets/primary_button.dart';
import 'mock/mock_medicine_offers.dart';
import 'models/medicine_offer.dart';
import 'widgets/medicine_offer_card.dart';

class MedicineSearchPage extends StatefulWidget {
  const MedicineSearchPage({super.key});

  @override
  State<MedicineSearchPage> createState() => _MedicineSearchPageState();
}

class _MedicineSearchPageState extends State<MedicineSearchPage> {
  final _searchController = TextEditingController();
  List<MedicineOffer> _offers = [];
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

    final results = MockMedicineOffers.searchOffers(searchText);
    setState(() {
      _hasSearched = true;
      _offers = results;
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
      _offers = [];
      _searchController.clear();
    });
  }

  void _openMap() {
    Navigator.pushNamed(context, AppRoutes.pharmaciesMap);
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
                        children: MockMedicineOffers.commonMedicines.map(
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
                              '${_offers.length}',
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        if (_offers.isEmpty)
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
                          MedicineOfferCard(
                            offer: _offers.first,
                            isBestOffer: true,
                            onViewMap: _openMap,
                          ),
                          if (_offers.length > 1) ...[
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
                            ..._offers.skip(1).map(
                                  (offer) => MedicineOfferCard(
                                    offer: offer,
                                    isBestOffer: false,
                                    onViewMap: _openMap,
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
                    child: PrimaryButton(
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