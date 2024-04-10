import 'package:mobx/mobx.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'authprovider.g.dart';

class AuthProvider = _AuthProvider with _$AuthProvider;

class UserInfo {
  int? id;
  String? fullName;
  int? currentRole;
  dynamic roles;
  dynamic student;
  dynamic company;
  UserInfo({
    this.id,
    this.fullName,
    this.currentRole,
    this.roles,
    this.student,
    this.company,
  });
}

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

  @observable
  UserInfo? userInfo = new UserInfo();

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

  @action
  Future<void> setUserInfo(dynamic us) async {
    this.userInfo = us;
    this.userInfo?.currentRole = us.roles[0];
  }

  @action
  Future<void> setUserInfoCompany(dynamic comp) async {
    this.userInfo?.company = comp;
  }
}
