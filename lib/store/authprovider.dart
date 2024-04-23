import 'package:carea/model/student.dart';
import 'package:carea/model/company.dart';

import 'package:mobx/mobx.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'authprovider.g.dart';

class AuthProvider = _AuthProvider with _$AuthProvider;

enum UserRole {
  STUDENT,
  COMPANY,
}

Map<UserRole, String> userRoleToText = {
  UserRole.STUDENT: 'Student',
  UserRole.COMPANY: 'Company',
};

abstract class _AuthProvider with Store {
  final _storage = new FlutterSecureStorage();

  @observable
  String? token = '';

  // @observable
  // Student? student;

  // @observable
  // Company? company;

  // @action
  // void setStudent(Student student) {
  //   this.student = student;
  // }

  // @action
  // void setCompany(Company company) {
  //   this.company = company;
  // }

  @observable
  UserRole authSignUp = UserRole.STUDENT;

  // @computed
  // bool get isLoggedIn => token != null;
  @observable
  bool isLoggedIn = false;

  @action
  void setLoggedIn(bool value) {
    isLoggedIn = value;
  }

  @action
  void setAuthSignUp(UserRole role) {
    authSignUp = role;
  }

  @action
  Future<void> login(String token) async {
    this.token = token;
    await _storage.write(key: 'token', value: token);
  }

  @action
  Future<void> logout() async {
    token = null;
    await _storage.delete(key: 'token');
  }

  @action
  Future<void> checkLoggedIn() async {
    token = await _storage.read(key: 'token');
  }
}
