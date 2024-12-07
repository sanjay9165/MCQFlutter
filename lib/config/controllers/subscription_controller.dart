import 'package:get/get.dart';

class SubscriptionController extends GetxController{
  RxInt selectedIndex=0.obs;

  onChangedIndex(int index){
    selectedIndex(index);
  }
}