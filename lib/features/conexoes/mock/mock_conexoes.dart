import '../models/conexao.dart';

class MockConexoes {
  static final List<Conexao> conexoes = [
    Conexao(
      name: 'Ana Clara Mendes',
      phone: '(79) 99999-0001',
      relationship: 'Filha',
      secondPhone: '(79) 98888-0002',
      cpf: '12345678900',
    ),
    Conexao(
      name: 'Maria Mendes',
      phone: '(79) 99999-0002',
      relationship: 'Cuidadora',
      secondPhone: '',
      cpf: '98765432100',
    ),
  ];

  static void adicionarConexao(Conexao connection) {
    conexoes.add(connection);
  }
}
