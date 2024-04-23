import 'package:carea/store/authprovider.dart';
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

  //user information & current role

  @observable
  UserRole? currentRole = null;

  @observable
  User? user = new User();

  @observable
  ProjectCreate? projectCreate = new ProjectCreate();

  @observable
  Project? projectInfo = new Project();

  @action
  Future<void> setUser(dynamic us) async {
    this.user = us;
  }

  @action
  Future<void> setUserCurrentRole(int role) async {
    this.currentRole = role == 0 ? UserRole.STUDENT : UserRole.COMPANY;
  }

  @action
  Future<void> setUserCurrentRole2(UserRole role) async {
    this.currentRole = role;
  }

  @action
  Future<void> setProjectInfo(Project? prj) async {
    this.projectInfo = prj;
  }

  @action
  Future<void> setProjectCreateTitle(String title) async {
    this.projectCreate?.title = title;
  }

  @action
  Future<void> setProjectCreateCompanyId(int id) async {
    this.projectCreate?.companyId = id;
  }

  @action
  Future<void> setProjectCreateTimeSize(int time, int numb) async {
    this.projectCreate?.projectScopeFlag = time;
    this.projectCreate?.numberOfStudents = numb;
  }

  @action
  Future<void> setProjectCreateDecsription(String description) async {
    this.projectCreate?.description = description;
  }
}
