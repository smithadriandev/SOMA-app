import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../shared/mock/mock_usuarios.dart';
import '../../shared/widgets/campo_texto_customizado.dart';
import '../../shared/widgets/botao_principal.dart';

class PaginaNovaSenha extends StatefulWidget {
  const PaginaNovaSenha({super.key});

  @override
  State<PaginaNovaSenha> createState() =>
      _PaginaNovaSenhaState();
}

class _PaginaNovaSenhaState
    extends State<PaginaNovaSenha> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  String? _validatePassword(String? value) {
    if ((value ?? '').isEmpty) {
      return 'Digite sua nova senha';
    }

    return null;
  }

  String? _validateRepeatPassword(String? value) {
    if ((value ?? '').isEmpty) {
      return 'Repita a senha';
    }

    return null;
  }

  void _resetPassword(String email) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_passwordController.text != _repeatPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('As senhas não são iguais')),
      );
      return;
    }

    MockUsuarios.updatePassword(
      email: email,
      newPassword: _passwordController.text,
    );

    Navigator.pushReplacementNamed(context, RotasApp.senhaAlterada);
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, Object?>?;
    final email = args?['email'] as String? ?? '';

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 50, 24, 22),
              child: SizedBox(
                height: constraints.maxHeight > 72
                    ? constraints.maxHeight - 72
                    : 600,
                child: Center(
                  child: SizedBox(
                    width: 320,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _ForgotPasswordHeader(),
                          const SizedBox(height: 72),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 28),
                            child: Column(
                              children: [
                                CampoTextoCustomizado(
                                  controller: _passwordController,
                                  hintText: 'Digite sua nova senha',
                                  validator: _validatePassword,
                                  obscureText: true,
                                  textInputAction: TextInputAction.next,
                                  contentVerticalPadding: 10,
                                ),
                                const SizedBox(height: 14),
                                CampoTextoCustomizado(
                                  controller: _repeatPasswordController,
                                  hintText: 'Repita a senha novamente',
                                  validator: _validateRepeatPassword,
                                  obscureText: true,
                                  textInputAction: TextInputAction.done,
                                  contentVerticalPadding: 10,
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Center(
                            child: BotaoPrincipal(
                              text: 'Redefinir senha',
                              width: 170,
                              height: 48,
                              fontSize: 14,
                              onPressed: () => _resetPassword(email),
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

class _ForgotPasswordHeader extends StatelessWidget {
  const _ForgotPasswordHeader();

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;

    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            size: 30,
            color: textColor,
          ),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
        ),
        const SizedBox(width: 8),
        Text(
          'Redefinir Senha',
          style: TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
