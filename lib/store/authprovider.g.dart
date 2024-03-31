// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authprovider.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthProvider on _AuthProvider, Store {
  Computed<bool>? _$isLoggedInComputed;

  @override
  bool get isLoggedIn =>
      (_$isLoggedInComputed ??= Computed<bool>(() => super.isLoggedIn,
              name: '_AuthProvider.isLoggedIn'))
          .value;

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

  @override
  String toString() {
    return '''
token: ${token},
isLoggedIn: ${isLoggedIn}
    ''';
  }
}
