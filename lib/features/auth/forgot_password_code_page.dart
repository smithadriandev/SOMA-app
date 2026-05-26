import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../shared/widgets/custom_text_field.dart';
import '../../shared/widgets/primary_button.dart';

class ForgotPasswordCodePage extends StatefulWidget {
  const ForgotPasswordCodePage({super.key});

  @override
  State<ForgotPasswordCodePage> createState() => _ForgotPasswordCodePageState();
}

class _ForgotPasswordCodePageState extends State<ForgotPasswordCodePage> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  String _maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) {
      return '****';
    }

    final name = parts.first;
    final domain = parts.last;
    final visible = name.length <= 2 ? '' : name.substring(name.length - 2);

    return '****$visible@$domain';
  }

  String? _validateCode(String? value) {
    final code = (value ?? '').trim();

    if (code.isEmpty) {
      return 'Digite o código';
    }

    if (!RegExp(r'^\d+$').hasMatch(code)) {
      return 'Digite apenas números';
    }

    return null;
  }

  void _confirmCode(String email) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Navigator.pushNamed(
      context,
      AppRoutes.forgotPasswordNewPassword,
      arguments: {'email': email},
    );
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
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.only(left: 48),
                            child: Text(
                              'Foi enviado um código de\n'
                              'verificação para o email\n'
                              '${_maskEmail(email)}',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.color,
                                fontSize: 13,
                                height: 1.25,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 28),
                            child: CustomTextField(
                              controller: _codeController,
                              hintText: 'Digite o código de alteração',
                              validator: _validateCode,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              contentVerticalPadding: 9,
                            ),
                          ),
                          const Spacer(),
                          Center(
                            child: PrimaryButton(
                              text: 'Confirmar código',
                              width: 170,
                              height: 48,
                              fontSize: 14,
                              onPressed: () => _confirmCode(email),
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
