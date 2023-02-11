import 'package:get/get.dart';

import '../../data/model/user_model.dart';

enum ViewState{
  idle,
  busy,
  retrieved,
  error,
}
class BaseController extends GetxController{

  var viewState = ViewState.idle.obs;
  RxBool isBusy = false.obs;
  UserModel? appUser;

  void setBusy(bool value){
    isBusy.value=value;
  }
  void setState(ViewState newState) {
    viewState.value = newState;
  }

}