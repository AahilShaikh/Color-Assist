import 'package:riverpod/riverpod.dart';

class ImageToSend extends StateNotifier<String> {
  ImageToSend() : super("");

  void setImage(String image) {
    state = image;
    print(state);
  }
}
