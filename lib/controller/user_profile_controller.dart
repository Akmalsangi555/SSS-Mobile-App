import 'package:get/get.dart';
import 'package:sssmobileapp/model/auth_models/login_user_model.dart';

class UserProfileController extends GetxController {
  final Rxn<LoginUserModel> _userData = Rxn<LoginUserModel>();

  LoginUserModel? get userData => _userData.value;

  void setUserData(LoginUserModel userData) {
    _userData.value = userData;
  }
}
