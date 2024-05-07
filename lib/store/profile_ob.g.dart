// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_ob.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileOb on _ProfileOb, Store {
  late final _$pickedFileAtom =
      Atom(name: '_ProfileOb.pickedFile', context: context);

  @override
  XFile? get pickedFile {
    _$pickedFileAtom.reportRead();
    return super.pickedFile;
  }

  @override
  set pickedFile(XFile? value) {
    _$pickedFileAtom.reportWrite(value, super.pickedFile, () {
      super.pickedFile = value;
    });
  }

  late final _$pickedValuseOfDropDownMenu1Atom =
      Atom(name: '_ProfileOb.pickedValuseOfDropDownMenu1', context: context);

  @override
  double get pickedValuseOfDropDownMenu1 {
    _$pickedValuseOfDropDownMenu1Atom.reportRead();
    return super.pickedValuseOfDropDownMenu1;
  }

  @override
  set pickedValuseOfDropDownMenu1(double value) {
    _$pickedValuseOfDropDownMenu1Atom
        .reportWrite(value, super.pickedValuseOfDropDownMenu1, () {
      super.pickedValuseOfDropDownMenu1 = value;
    });
  }

  late final _$pickedValuseOfDropDownMenu2Atom =
      Atom(name: '_ProfileOb.pickedValuseOfDropDownMenu2', context: context);

  @override
  double get pickedValuseOfDropDownMenu2 {
    _$pickedValuseOfDropDownMenu2Atom.reportRead();
    return super.pickedValuseOfDropDownMenu2;
  }

  @override
  set pickedValuseOfDropDownMenu2(double value) {
    _$pickedValuseOfDropDownMenu2Atom
        .reportWrite(value, super.pickedValuseOfDropDownMenu2, () {
      super.pickedValuseOfDropDownMenu2 = value;
    });
  }

  late final _$currentRoleAtom =
      Atom(name: '_ProfileOb.currentRole', context: context);

  @override
  UserRole? get currentRole {
    _$currentRoleAtom.reportRead();
    return super.currentRole;
  }

  @override
  set currentRole(UserRole? value) {
    _$currentRoleAtom.reportWrite(value, super.currentRole, () {
      super.currentRole = value;
    });
  }

  late final _$userAtom = Atom(name: '_ProfileOb.user', context: context);

  @override
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$projectCreateAtom =
      Atom(name: '_ProfileOb.projectCreate', context: context);

  @override
  ProjectCreate? get projectCreate {
    _$projectCreateAtom.reportRead();
    return super.projectCreate;
  }

  @override
  set projectCreate(ProjectCreate? value) {
    _$projectCreateAtom.reportWrite(value, super.projectCreate, () {
      super.projectCreate = value;
    });
  }

  late final _$projectInfoAtom =
      Atom(name: '_ProfileOb.projectInfo', context: context);

  @override
  Project? get projectInfo {
    _$projectInfoAtom.reportRead();
    return super.projectInfo;
  }

  @override
  set projectInfo(Project? value) {
    _$projectInfoAtom.reportWrite(value, super.projectInfo, () {
      super.projectInfo = value;
    });
  }

  late final _$pickImageAsyncAction =
      AsyncAction('_ProfileOb.pickImage', context: context);

  @override
  Future<void> pickImage() {
    return _$pickImageAsyncAction.run(() => super.pickImage());
  }

  late final _$setUserAsyncAction =
      AsyncAction('_ProfileOb.setUser', context: context);

  @override
  Future<void> setUser(dynamic us) {
    return _$setUserAsyncAction.run(() => super.setUser(us));
  }

  late final _$setUserCurrentRoleAsyncAction =
      AsyncAction('_ProfileOb.setUserCurrentRole', context: context);

  @override
  Future<void> setUserCurrentRole(int role) {
    return _$setUserCurrentRoleAsyncAction
        .run(() => super.setUserCurrentRole(role));
  }

  late final _$setUserCurrentRole2AsyncAction =
      AsyncAction('_ProfileOb.setUserCurrentRole2', context: context);

  @override
  Future<void> setUserCurrentRole2(UserRole role) {
    return _$setUserCurrentRole2AsyncAction
        .run(() => super.setUserCurrentRole2(role));
  }

  late final _$setProjectInfoAsyncAction =
      AsyncAction('_ProfileOb.setProjectInfo', context: context);

  @override
  Future<void> setProjectInfo(Project? prj) {
    return _$setProjectInfoAsyncAction.run(() => super.setProjectInfo(prj));
  }

  late final _$setProjectCreateTitleAsyncAction =
      AsyncAction('_ProfileOb.setProjectCreateTitle', context: context);

  @override
  Future<void> setProjectCreateTitle(String title) {
    return _$setProjectCreateTitleAsyncAction
        .run(() => super.setProjectCreateTitle(title));
  }

  late final _$setProjectCreateCompanyIdAsyncAction =
      AsyncAction('_ProfileOb.setProjectCreateCompanyId', context: context);

  @override
  Future<void> setProjectCreateCompanyId(int id) {
    return _$setProjectCreateCompanyIdAsyncAction
        .run(() => super.setProjectCreateCompanyId(id));
  }

  late final _$setProjectCreateTimeSizeAsyncAction =
      AsyncAction('_ProfileOb.setProjectCreateTimeSize', context: context);

  @override
  Future<void> setProjectCreateTimeSize(int time, int numb) {
    return _$setProjectCreateTimeSizeAsyncAction
        .run(() => super.setProjectCreateTimeSize(time, numb));
  }

  late final _$setProjectCreateDecsriptionAsyncAction =
      AsyncAction('_ProfileOb.setProjectCreateDecsription', context: context);

  @override
  Future<void> setProjectCreateDecsription(String description) {
    return _$setProjectCreateDecsriptionAsyncAction
        .run(() => super.setProjectCreateDecsription(description));
  }

  @override
  String toString() {
    return '''
pickedFile: ${pickedFile},
pickedValuseOfDropDownMenu1: ${pickedValuseOfDropDownMenu1},
pickedValuseOfDropDownMenu2: ${pickedValuseOfDropDownMenu2},
currentRole: ${currentRole},
user: ${user},
projectCreate: ${projectCreate},
projectInfo: ${projectInfo}
    ''';
  }
}
