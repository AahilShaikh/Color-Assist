import 'package:riverpod/riverpod.dart';

class CropStatus extends StateNotifier<bool>{
  CropStatus() : super(false);

  void setCropStatus(bool cropStatus){
    state = cropStatus;
  }

}