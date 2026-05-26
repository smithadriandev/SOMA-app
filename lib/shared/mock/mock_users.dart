class MockUser {
  MockUser({
    required this.name,
    required this.username,
    required this.email,
    required this.password,
    required this.cpf,
  });

  final String name;
  final String username;
  String email;
  String password;
  final String cpf;
}

class MockUsers {
  static final List<MockUser> _users = [
    MockUser(
      name: 'Usuario Teste',
      username: 'usuario',
      email: 'usuario@email.com',
      password: '123456',
      cpf: '12345678901',
    ),
  ];

  static bool authenticate({required String email, required String password}) {
    return _users.any(
      (user) =>
          user.email.toLowerCase() == email.toLowerCase() &&
          user.password == password,
    );
  }

  static bool emailExists(String email) {
    return _users.any(
      (user) => user.email.toLowerCase() == email.toLowerCase(),
    );
  }

  static bool updatePassword({
    required String email,
    required String newPassword,
  }) {
    final index = _users.indexWhere(
      (user) => user.email.toLowerCase() == email.toLowerCase(),
    );

    if (index == -1) {
      return false;
    }

    _users[index].password = newPassword;
    return true;
  }

  static void addUser({
    required String name,
    required String email,
    required String password,
    required String cpf,
  }) {
    _users.add(
      MockUser(
        name: name,
        username: email,
        email: email,
        password: password,
        cpf: cpf,
      ),
    );
  }
}
