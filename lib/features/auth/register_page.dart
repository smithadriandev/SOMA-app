import 'package:flutter/material.dart';

import '../../shared/formatters/cpf_input_formatter.dart';
import '../../shared/mock/mock_users.dart';
import '../../shared/widgets/custom_text_field.dart';
import '../../shared/widgets/primary_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();
  final _cpfController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    _cpfController.dispose();
    super.dispose();
  }

  String? _required(String? value, String message) {
    if ((value ?? '').trim().isEmpty) {
      return message;
    }

    return null;
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) {
      return 'Digite seu email';
    }

    if (!email.contains('@') || !email.endsWith('.com')) {
      return 'Digite um email válido terminado em .com';
    }

    return null;
  }

  String? _validateRepeatPassword(String? value) {
    final message = _required(value, 'Repita a senha');
    if (message != null) {
      return message;
    }

    if (value != _passwordController.text) {
      return 'As senhas precisam ser iguais';
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

  void _createAccount() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    MockUsers.addUser(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      cpf: _cpfController.text.replaceAll(RegExp(r'\D'), ''),
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Conta criada com sucesso')));
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
              padding: const EdgeInsets.fromLTRB(28, 24, 28, 28),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight > 52
                      ? constraints.maxHeight - 52
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
                                  size: 34,
                                  color: textColor,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(
                                  minWidth: 40,
                                  minHeight: 40,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Cadastro',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 72),
                          CustomTextField(
                            controller: _nameController,
                            hintText: 'Digite seu nome',
                            validator: (value) =>
                                _required(value, 'Digite seu nome'),
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 14),
                          CustomTextField(
                            controller: _emailController,
                            hintText: 'Email',
                            validator: _validateEmail,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 14),
                          CustomTextField(
                            controller: _passwordController,
                            hintText: 'Digite sua senha',
                            validator: (value) =>
                                _required(value, 'Digite sua senha'),
                            obscureText: true,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 14),
                          CustomTextField(
                            controller: _repeatPasswordController,
                            hintText: 'Repita a senha novamente',
                            validator: _validateRepeatPassword,
                            obscureText: true,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 14),
                          CustomTextField(
                            controller: _cpfController,
                            hintText: 'Digite o seu cpf',
                            validator: _validateCpf,
                            keyboardType: TextInputType.number,
                            inputFormatters: const [
                              CpfInputFormatter(),
                            ],
                            textInputAction: TextInputAction.done,
                          ),
                          SizedBox(
                            height: constraints.maxHeight < 700 ? 90 : 220,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: PrimaryButton(
                              text: 'Criar nova conta',
                              width: 220,
                              onPressed: _createAccount,
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
