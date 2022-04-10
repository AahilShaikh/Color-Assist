import 'package:color_assist/services/crop_status.dart';
import 'package:color_assist/services/image_to_send.dart';
import 'package:riverpod/riverpod.dart';

final imageProvider = StateNotifierProvider<ImageToSend, String>((ref) {
  return ImageToSend();
});

final cropStatusProvider = StateNotifierProvider<CropStatus, bool>((ref) {
  return CropStatus();
});