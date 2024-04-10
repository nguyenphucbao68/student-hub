import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:carea/model/user_info.dart';
import 'package:carea/model/project.dart';
part 'profile_ob.g.dart';

class ProfileOb = _ProfileOb with _$ProfileOb;

abstract class _ProfileOb with Store {
  @observable
  XFile? pickedFile;

  @observable
  double pickedValuseOfDropDownMenu1 = 0;

  @observable
  double pickedValuseOfDropDownMenu2 = 0;

  @action
  Future<void> pickImage() async {
    ImagePicker picker = ImagePicker();
    pickedFile = await picker.pickImage(source: ImageSource.gallery);
  }

  @observable
  UserInfo? userInfo = new UserInfo();

  @observable
  ProjectCreate? projectCreate = new ProjectCreate();

  @action
  Future<void> setUserInfo(dynamic us) async {
    this.userInfo = us;
  }

  @action
  Future<void> setUserInfoCurrentRole(dynamic role) async {
    this.userInfo?.currentRole = role;
  }

  @action
  Future<void> setUserInfoCompany(dynamic comp) async {
    this.userInfo?.company = comp;
  }

  @action
  Future<void> setProjectTitle(String title) async {
    this.projectCreate?.title = title;
  }

  @action
  Future<void> setProjectCompanyId(int id) async {
    this.projectCreate?.companyId = id;
  }

  @action
  Future<void> setProjectTimeSize(int time, int numb) async {
    this.projectCreate?.projectScopeFlag = time;
    this.projectCreate?.numberOfStudents = numb;
  }

  @action
  Future<void> setProjectDecsription(String description) async {
    this.projectCreate?.description = description;
  }
}
