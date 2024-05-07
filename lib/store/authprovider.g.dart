// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authprovider.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthProvider on _AuthProvider, Store {
  late final _$tokenAtom = Atom(name: '_AuthProvider.token', context: context);

  @override
  String? get token {
    _$tokenAtom.reportRead();
    return super.token;
  }

  @override
  set token(String? value) {
    _$tokenAtom.reportWrite(value, super.token, () {
      super.token = value;
    });
  }

  late final _$authSignUpAtom =
      Atom(name: '_AuthProvider.authSignUp', context: context);

  @override
  UserRole get authSignUp {
    _$authSignUpAtom.reportRead();
    return super.authSignUp;
  }

  @override
  set authSignUp(UserRole value) {
    _$authSignUpAtom.reportWrite(value, super.authSignUp, () {
      super.authSignUp = value;
    });
  }

  late final _$isLoggedInAtom =
      Atom(name: '_AuthProvider.isLoggedIn', context: context);

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('_AuthProvider.login', context: context);

  @override
  Future<void> login(String token) {
    return _$loginAsyncAction.run(() => super.login(token));
  }

  late final _$logoutAsyncAction =
      AsyncAction('_AuthProvider.logout', context: context);

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$checkLoggedInAsyncAction =
      AsyncAction('_AuthProvider.checkLoggedIn', context: context);

  @override
  Future<void> checkLoggedIn() {
    return _$checkLoggedInAsyncAction.run(() => super.checkLoggedIn());
  }

  late final _$_AuthProviderActionController =
      ActionController(name: '_AuthProvider', context: context);

  @override
  void setLoggedIn(bool value) {
    final _$actionInfo = _$_AuthProviderActionController.startAction(
        name: '_AuthProvider.setLoggedIn');
    try {
      return super.setLoggedIn(value);
    } finally {
      _$_AuthProviderActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAuthSignUp(UserRole role) {
    final _$actionInfo = _$_AuthProviderActionController.startAction(
        name: '_AuthProvider.setAuthSignUp');
    try {
      return super.setAuthSignUp(role);
    } finally {
      _$_AuthProviderActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
token: ${token},
authSignUp: ${authSignUp},
isLoggedIn: ${isLoggedIn}
    ''';
  }
}
