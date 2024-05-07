import 'package:carea/commons/colors.dart';
import 'package:carea/commons/constants.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';

part 'AppStore.g.dart';

class AppStore = AppStoreBase with _$AppStore;

abstract class AppStoreBase with Store {
  @observable
  double i = 0;

  @observable
  bool isDarkModeOn = false;

  @observable
  bool isHover = false;

  @observable
  Color? scaffoldBackground;

  @observable
  Color? backgroundColor;

  @observable
  Color? backgroundSecondaryColor;

  @observable
  Color? textPrimaryColor;

  @observable
  Color? appColorPrimaryLightColor;

  @observable
  Color? textSecondaryColor;

  @observable
  Color? txtPrimaryColor;

  @observable
  Color? txtSecondaryColor;

  @observable
  Color? buttonPrimaryColor;

  @observable
  Color? buttonSecondaryColor;

  @observable
  Color? buttonPrimaryColorGlobal;

  @observable
  Color? buttonSecondaryColorGlobal;

  @observable
  Color? appBarColor;

  @observable
  Color? iconColor;

  @observable
  Color? iconSecondaryColor;

  @observable
  var selectedDrawerItem = -1;

  @action
  Future<void> toggleDarkMode({bool? value}) async {
    isDarkModeOn = value ?? !isDarkModeOn;

    if (isDarkModeOn) {
      scaffoldBackground = appBackgroundColorDark;

      appBarColor = appBackgroundColorDark;
      backgroundColor = Colors.white;
      backgroundSecondaryColor = Colors.white;
      appColorPrimaryLightColor = cardBackgroundBlackDark;

      iconColor = iconColorPrimary;
      iconSecondaryColor = iconColorSecondary;

      textPrimaryColor = whiteColor;
      textSecondaryColor = Colors.white54;

      txtPrimaryColor = blackColor;
      txtSecondaryColor = whiteColor;

      buttonPrimaryColor = Colors.grey.shade700;
      buttonSecondaryColor = blackColor;

      buttonPrimaryColorGlobal = blackColor;
      buttonSecondaryColorGlobal = whiteColor;

      textPrimaryColorGlobal = whiteColor;
      textSecondaryColorGlobal = Colors.white54;
      shadowColorGlobal = appShadowColorDark;
    } else {
      scaffoldBackground = whiteColor;

      appBarColor = Colors.white;
      backgroundColor = Colors.black;
      backgroundSecondaryColor = appSecondaryBackgroundColor;
      appColorPrimaryLightColor = appColorPrimaryLight;

      iconColor = iconColorPrimaryDark;
      iconSecondaryColor = iconColorSecondaryDark;

      textPrimaryColor = appTextColorPrimary;
      textSecondaryColor = appTextColorSecondary;

      txtPrimaryColor = whiteColor;
      txtSecondaryColor = blackColor;

      buttonPrimaryColor = blackColor;
      buttonSecondaryColor = whiteColor;

      buttonPrimaryColorGlobal = black;
      buttonSecondaryColorGlobal = whiteColor;

      textPrimaryColorGlobal = appTextColorPrimary;
      textSecondaryColorGlobal = appTextColorSecondary;
      shadowColorGlobal = appShadowColor;
    }
    setStatusBarColor(scaffoldBackground!);

    setValue(isDarkModeOnPref, isDarkModeOn);
  }

  @observable
  bool isVi = false;

  @observable
  String company = "Company";
  @observable
  String student = "Student";
  @observable
  String profile = "Profile";
  @observable
  String changePassword = "Change Password";
  @observable
  String language = "Language";
  @observable
  String logout = "Logout";
  @observable
  String companyName = "Company name";
  @observable
  String description = "Description";
  @observable
  String howManyPeopleAreInYourCompany = "How many people are in your company?";
  @observable
  String edit = "Edit";
  @observable
  String cancel = "Cancel";
  @observable
  String postAProject = "Post a project";
  @observable
  String yourProject = "Your projects";
  @observable
  String project = "Project";
  @observable
  String dashboard = "Dashboard";
  @observable
  String message = "Message";
  @observable
  String alert = "Alert";
  @observable
  String favoriteProjects = "Favorite Projects";
  @observable
  String extraInformation = "Extra Information";
  @observable
  String projectScope = "Project Scope";
  @observable
  String studentrequired = "Student required";
  @observable
  String editProject = 'Edit project';
  @observable
  String deletPproject = 'Delete project';
  @observable
  String viewProposals = "View proposals";
  @observable
  String viewMessages = "View messages";
  @observable
  String viewHired = "View hired";
  @observable
  String viewJobPosting = "View job posting";
  @observable
  String editPosting = "Edit posting";
  @observable
  String removePosting = "Remove posting";
  @observable
  String manageProject = "Manage project";
  @observable
  String startWorkingThisProject = "Start working this project";
  @observable
  String proposal = "Proposal";
  @observable
  String hired = "Hired";
  @observable
  String hire = "Hire";
  @observable
  String sentHiredOffer = 'Sent Hired Offer';
  @observable
  String send = 'Send';
  @observable
  String hiredOffer = 'Hired offer';
  @observable
  String projectInformation = "Project information";

  @action
  Future<void> toggleLanguage() async {
    isVi = !isVi;

    if (isVi) {
      company = "Công ty";
      student = "Sinh viên";
      profile = "Hồ sơ";
      changePassword = "Đổi mật khẩu";
      language = "Ngôn ngữ";
      logout = "Đăng xuất";
      companyName = "Tên công ty";
      description = "Mô tả";
      howManyPeopleAreInYourCompany = "Công ty bạn có bao nhiêu người?";
      edit = "Lưu";
      cancel = "Hủy";
      postAProject = "Tạo dự án";
      yourProject = "Dự án của bạn";
      project = "Dự án";
      dashboard = "Bảng điều khiển";
      message = "Tin nhắn";
      alert = "Thông báo";
      favoriteProjects = "Dự án ưa thích";
      extraInformation = "Thông tin thêm";
      projectScope = "Phạm vi dự án";
      studentrequired = "Yêu cầu sinh viên";
      editProject = 'Chỉnh sửa dự án';
      deletPproject = 'Xóa dự án';
      viewProposals = "Xem đề xuất";
      viewMessages = "Xem tin nhắn";
      viewHired = "Xem sinh viên đã thuê";
      viewJobPosting = "Xem thông tin bài đăng";
      editPosting = "Chỉnh sửa bài đăng";
      removePosting = "Xóa bài đăng";
      manageProject = "Quản lý dự án";
      startWorkingThisProject = "Bắt đàu dự án";
      proposal = "Đề xuất";
      hired = "Đã thuê";
      hire = "Thuê";
      sentHiredOffer = 'Đã gửi yêu cầu';
      send = 'Gửi';
      hiredOffer = 'Gửi yêu cầu thuê';
      projectInformation = "Thông tin dự án";
    } else {
      company = "Company";
      student = "Student";
      profile = "Profile";
      changePassword = "Change Password";
      language = "Language";
      logout = "Logout";
      companyName = "Company name";
      description = "Description";
      howManyPeopleAreInYourCompany = "How many people are in your company?";
      edit = "Edit";
      cancel = "Cancel";
      postAProject = "Post a project";
      yourProject = "Your projects";
      project = "Project";
      dashboard = "Dashboard";
      message = "Message";
      alert = "Alert";
      favoriteProjects = "Favorite Projects";
      extraInformation = "Extra Information";
      projectScope = "Project Scope";
      studentrequired = "Student required";
      editProject = 'Edit project';
      deletPproject = 'Delete project';
      viewProposals = "View proposals";
      viewMessages = "View messages";
      viewHired = "View hired";
      viewJobPosting = "View job posting";
      editPosting = "Edit posting";
      removePosting = "Remove posting";
      manageProject = "Manage project";
      startWorkingThisProject = "Start working this project";
      proposal = "Proposal";
      hired = "Hired";
      hire = "Hire";
      sentHiredOffer = 'Sent Hired Offer';
      send = 'Send';
      hiredOffer = 'Hired offer';
      projectInformation = "Project information";
      // scaffoldBackground = whiteColor;

      // appBarColor = Colors.white;
      // backgroundColor = Colors.black;
      // backgroundSecondaryColor = appSecondaryBackgroundColor;
      // appColorPrimaryLightColor = appColorPrimaryLight;

      // iconColor = iconColorPrimaryDark;
      // iconSecondaryColor = iconColorSecondaryDark;

      // textPrimaryColor = appTextColorPrimary;
      // textSecondaryColor = appTextColorSecondary;

      // txtPrimaryColor = whiteColor;
      // txtSecondaryColor = blackColor;

      // buttonPrimaryColor = blackColor;
      // buttonSecondaryColor = whiteColor;

      // buttonPrimaryColorGlobal = black;
      // buttonSecondaryColorGlobal = whiteColor;

      // textPrimaryColorGlobal = appTextColorPrimary;
      // textSecondaryColorGlobal = appTextColorSecondary;
      // shadowColorGlobal = appShadowColor;
    }
    // setStatusBarColor(scaffoldBackground!);
  }

  @action
  void toggleHover({bool value = false}) => isHover = value;

  @action
  void setDrawerItemIndex(int aIndex) {
    selectedDrawerItem = aIndex;
  }
}
