import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../app/theme.dart';
import '../../shared/widgets/campo_texto_customizado.dart';
import '../../shared/widgets/botao_principal.dart';
import '../../shared/widgets/logo_soma.dart';

class PaginaLogin extends StatefulWidget {
  const PaginaLogin({super.key});

  @override
  State<PaginaLogin> createState() => _PaginaLoginState();
}

class _PaginaLoginState extends State<PaginaLogin> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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

  String? _validatePassword(String? value) {
    if ((value ?? '').isEmpty) {
      return 'Digite sua senha';
    }

    return null;
  }

  void _login() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Navigator.pushReplacementNamed(context, RotasApp.inicio);
  }

  @override
  Widget build(BuildContext context) {
    final secondaryColor =
        Theme.of(context).textTheme.bodySmall?.color ?? SomaColors.placeholder;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 26),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight > 52
                      ? constraints.maxHeight - 52
                      : 0,
                ),
                child: Center(
                  child: SizedBox(
                    width: 320,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const LogoSoma(width: 170),
                          const SizedBox(height: 78),
                          CampoTextoCustomizado(
                            controller: _emailController,
                            hintText: 'Email',
                            validator: _validateEmail,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            prefixIcon: Icons.person,
                          ),
                          const SizedBox(height: 28),
                          CampoTextoCustomizado(
                            controller: _passwordController,
                            hintText: 'Digite sua senha aqui...',
                            validator: _validatePassword,
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            prefixIcon: Icons.lock_outline,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  RotasApp.recuperarSenhaEmail,
                                );
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: secondaryColor,
                                padding: const EdgeInsets.only(top: 4),
                                textStyle: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 14,
                                ),
                              ),
                              child: const Text('Esqueceu a senha ?'),
                            ),
                          ),
                          const SizedBox(height: 42),
                          BotaoPrincipal(
                            text: 'Entrar',
                            width: 230,
                            onPressed: _login,
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                'Ainda não tem uma conta? ',
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 12,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    RotasApp.cadastro,
                                  );
                                },
                                child: const Text(
                                  'Cadastre-se',
                                  style: TextStyle(
                                    color: SomaColors.primaryBlue,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
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
