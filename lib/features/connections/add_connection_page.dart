import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../shared/formatters/cpf_input_formatter.dart';
import '../../shared/widgets/custom_text_field.dart';
import '../../shared/widgets/primary_button.dart';
import 'mock/mock_connections.dart';
import 'models/connection.dart';

class AddConnectionPage extends StatefulWidget {
  const AddConnectionPage({super.key});

  @override
  State<AddConnectionPage> createState() => _AddConnectionPageState();
}

class _AddConnectionPageState extends State<AddConnectionPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _relationshipController = TextEditingController();
  final _secondContactController = TextEditingController();
  final _cpfController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _relationshipController.dispose();
    _secondContactController.dispose();
    _cpfController.dispose();
    super.dispose();
  }

  String? _required(String? value, String message) {
    if ((value ?? '').trim().isEmpty) {
      return message;
    }

    return null;
  }

  String? _validateCpf(String? value) {
    final cpf = (value ?? '').replaceAll(RegExp(r'\D'), '');

    if (cpf.isEmpty) {
      return 'Digite o CPF';
    }

    if (cpf.length != 11) {
      return 'O CPF deve ter 11 dígitos numéricos';
    }

    return null;
  }

  String? _validateRequiredPhone(String? value) {
    final message = _required(value, 'Digite o telefone de contato');
    if (message != null) {
      return message;
    }

    return _validatePhoneDigits(value);
  }

  String? _validateOptionalPhone(String? value) {
    if ((value ?? '').trim().isEmpty) {
      return null;
    }

    return _validatePhoneDigits(value);
  }

  String? _validatePhoneDigits(String? value) {
    final digits = (value ?? '').replaceAll(RegExp(r'\D'), '');

    if (digits.length != 11) {
      return 'Digite DDD + 9 números';
    }

    return null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    MockConnections.addConnection(
      Connection(
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        relationship: _relationshipController.text.trim(),
        secondPhone: _secondContactController.text.trim(),
        cpf: _cpfController.text.replaceAll(RegExp(r'\D'), ''),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Conexão cadastrada com sucesso')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 38, 24, 18),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight > 56
                      ? constraints.maxHeight - 56
                      : 0,
                ),
                child: Center(
                  child: SizedBox(
                    width: 330,
                    child: Form(
                      key: _formKey,
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
                                  size: 28,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(
                                  minWidth: 36,
                                  minHeight: 36,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Adicionar conexão',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 52),
                          Center(
                            child: SizedBox(
                              width: 250,
                              child: Column(
                                children: [
                                  CustomTextField(
                                    controller: _nameController,
                                    hintText: 'Digite seu nome',
                                    validator: (value) => _required(
                                      value,
                                      'Digite seu nome',
                                    ),
                                    textInputAction: TextInputAction.next,
                                    contentVerticalPadding: 8,
                                  ),
                                  const SizedBox(height: 10),
                                  CustomTextField(
                                    controller: _phoneController,
                                    hintText: 'Digite telefone de contato',
                                    validator: _validateRequiredPhone,
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: const [
                                      PhoneInputFormatter(),
                                    ],
                                    textInputAction: TextInputAction.next,
                                    contentVerticalPadding: 8,
                                  ),
                                  const SizedBox(height: 10),
                                  CustomTextField(
                                    controller: _relationshipController,
                                    hintText: 'Digite grau de parentesco',
                                    validator: (value) => _required(
                                      value,
                                      'Digite o grau de parentesco',
                                    ),
                                    textInputAction: TextInputAction.next,
                                    contentVerticalPadding: 8,
                                  ),
                                  const SizedBox(height: 10),
                                  CustomTextField(
                                    controller: _secondContactController,
                                    hintText: 'Digite um segundo contato',
                                    validator: _validateOptionalPhone,
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: const [
                                      PhoneInputFormatter(),
                                    ],
                                    textInputAction: TextInputAction.next,
                                    contentVerticalPadding: 8,
                                  ),
                                  const SizedBox(height: 10),
                                  CustomTextField(
                                    controller: _cpfController,
                                    hintText: 'Digite o seu cpf',
                                    validator: _validateCpf,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: const [
                                      CpfInputFormatter(),
                                    ],
                                    textInputAction: TextInputAction.done,
                                    contentVerticalPadding: 8,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: constraints.maxHeight < 700 ? 90 : 180,
                          ),
                          Center(
                            child: PrimaryButton(
                              text: 'Cadastrar',
                              width: 170,
                              height: 46,
                              fontSize: 15,
                              onPressed: _submit,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class PhoneInputFormatter extends TextInputFormatter {
  const PhoneInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final limitedDigits = digits.length > 11 ? digits.substring(0, 11) : digits;
    final formatted = _format(limitedDigits);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  String _format(String digits) {
    if (digits.isEmpty) {
      return '';
    }

    if (digits.length <= 2) {
      return '($digits';
    }

    return '(${digits.substring(0, 2)}) ${digits.substring(2)}';
  }
}
