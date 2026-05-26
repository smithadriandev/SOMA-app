import '../models/connection.dart';

class MockConnections {
  static final List<Connection> connections = [
    Connection(
      name: 'Ana Clara Mendes',
      phone: '(79) 99999-0001',
      relationship: 'Filha',
      secondPhone: '(79) 98888-0002',
      cpf: '12345678900',
    ),
  ];

  static void addConnection(Connection connection) {
    connections.add(connection);
  }
}
