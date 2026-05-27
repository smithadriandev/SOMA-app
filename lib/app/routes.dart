import 'package:flutter/material.dart';

import '../features/alerta_acidente/pagina_alerta_acidente.dart';
import '../features/acessibilidade/pagina_acessibilidade.dart';
import '../features/acompanhamento_medico/pagina_acompanhamento_medico.dart';
import '../features/ajuda/pagina_ajuda.dart';
import '../features/autenticacao/login_page.dart';
import '../features/autenticacao/pagina_cadastro.dart';
import '../features/autenticacao/pagina_codigo_recuperacao.dart';
import '../features/autenticacao/pagina_nova_senha.dart';
import '../features/autenticacao/pagina_recuperar_senha_email.dart';
import '../features/autenticacao/pagina_senha_sucesso.dart';
import '../features/busca_medicamentos/pagina_busca_medicamentos.dart';
import '../features/conexoes/pagina_adicionar_conexao.dart';
import '../features/conexoes/pagina_conexoes.dart';
import '../features/configuracoes/pagina_configuracoes.dart';
import '../features/farmacias/pagina_mapa_farmacias.dart';
import '../features/inicio/pagina_inicio.dart';
import '../features/sobre/pagina_sobre.dart';
import '../features/splash/splash_page.dart';
import '../features/tarefas_diarias/pagina_tarefas_diarias.dart';

class RotasApp {
  static const splash = '/splash';
  static const login = '/login';
  static const cadastro = '/cadastro';
  static const recuperarSenha = '/recuperar-senha-email';
  static const recuperarSenhaEmail = '/recuperar-senha-email';
  static const codigoRecuperacao = '/codigo-recuperacao';
  static const novaSenha = '/nova-senha';
  static const senhaAlterada = '/senha-alterada';
  static const inicio = '/inicio';
  static const sobre = '/sobre';
  static const acessibilidade = '/acessibilidade';
  static const configuracoes = '/configuracoes';
  static const conexoes = '/conexoes';
  static const adicionarConexao = '/adicionar-conexao';
  static const tarefasDiarias = '/tarefas-diarias';
  static const acompanhamentoMedico = '/acompanhamento-medico';
  static const buscarMedicamento = '/buscar-medicamento';
  static const mapaFarmacias = '/mapa-farmacias';
  static const alertaAcidente = '/alerta-acidente';
  static const ajuda = '/ajuda';

  // Aliases antigos mantidos para evitar quebra de links internos antigos.
  static const register = cadastro;
  static const forgotPassword = recuperarSenha;
  static const forgotPasswordEmail = recuperarSenhaEmail;
  static const forgotPasswordCode = codigoRecuperacao;
  static const forgotPasswordNewPassword = novaSenha;
  static const forgotPasswordSuccess = senhaAlterada;
  static const home = inicio;
  static const settings = configuracoes;
  static const pharmaciesMap = mapaFarmacias;
  static const dailyTasks = tarefasDiarias;
  static const medicalTracking = acompanhamentoMedico;
  static const accidentAlert = alertaAcidente;
  static const about = sobre;
  static const medicineSearch = buscarMedicamento;
  static const accessibility = acessibilidade;
  static const help = ajuda;

  static Map<String, WidgetBuilder> get routes => {
        splash: (_) => const PaginaSplash(),
        login: (_) => const PaginaLogin(),
        cadastro: (_) => const PaginaCadastro(),
        recuperarSenhaEmail: (_) => const PaginaRecuperarSenhaEmail(),
        codigoRecuperacao: (_) => const PaginaCodigoRecuperacao(),
        novaSenha: (_) => const PaginaNovaSenha(),
        senhaAlterada: (_) => const PaginaSenhaSucesso(),
        inicio: (_) => const PaginaInicio(),
        sobre: (_) => const PaginaSobre(),
        acessibilidade: (_) => const PaginaAcessibilidade(),
        configuracoes: (_) => const PaginaConfiguracoes(),
        conexoes: (_) => const PaginaConexoes(),
        adicionarConexao: (_) => const PaginaAdicionarConexao(),
        tarefasDiarias: (_) => const PaginaTarefasDiarias(),
        acompanhamentoMedico: (_) => const PaginaAcompanhamentoMedico(),
        buscarMedicamento: (_) => const PaginaBuscaMedicamentos(),
        mapaFarmacias: (_) => const PaginaMapaFarmacias(),
        alertaAcidente: (_) => const PaginaAlertaAcidente(),
        ajuda: (_) => const PaginaAjuda(),
        '/register': (_) => const PaginaCadastro(),
        '/forgot-password': (_) => const PaginaRecuperarSenhaEmail(),
        '/forgot-password-email': (_) => const PaginaRecuperarSenhaEmail(),
        '/forgot-password-code': (_) => const PaginaCodigoRecuperacao(),
        '/forgot-password-new-password': (_) => const PaginaNovaSenha(),
        '/forgot-password-success': (_) => const PaginaSenhaSucesso(),
        '/home': (_) => const PaginaInicio(),
        '/about': (_) => const PaginaSobre(),
        '/accessibility': (_) => const PaginaAcessibilidade(),
        '/settings': (_) => const PaginaConfiguracoes(),
        '/connections': (_) => const PaginaConexoes(),
        '/add-connection': (_) => const PaginaAdicionarConexao(),
        '/daily-tasks': (_) => const PaginaTarefasDiarias(),
        '/medical-tracking': (_) => const PaginaAcompanhamentoMedico(),
        '/medicine-search': (_) => const PaginaBuscaMedicamentos(),
        '/pharmacies-map': (_) => const PaginaMapaFarmacias(),
        '/accident-alert': (_) => const PaginaAlertaAcidente(),
        '/help': (_) => const PaginaAjuda(),
      };
}