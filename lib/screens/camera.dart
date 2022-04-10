import 'package:color_assist/screens/results/results_page.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import '../main.dart';
import '../services/custom_clipper.dart';

class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<Camera> with WidgetsBindingObserver {
  late CameraController cameraController;

  @override
  void initState() {
    super.initState();
    cameraController = CameraController(cameras.first, ResolutionPreset.max, enableAudio: false, imageFormatGroup: ImageFormatGroup.jpeg);
    cameraController.initialize().then((value) async {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      cameraController.initialize();
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!cameraController.value.isInitialized) {
      return const CircularProgressIndicator();
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: ClipRect(
            clipper: MediaSizeClipper(MediaQuery.of(context).size),
            child: Transform.scale(
                scale: 1 / (cameraController.value.aspectRatio * MediaQuery.of(context).size.aspectRatio),
                alignment: Alignment.topCenter,
                child: CameraPreview(cameraController)),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            
            onTap: () async {
              try {
                final XFile image = await cameraController.takePicture();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultsPage(image),
                  ),
                );
              } catch (e) {
                print("Error: ----------------------------- $e");
              }
            },
            child: Stack(
              alignment: Alignment.center,
              children: const [
                Icon(Icons.circle, color: Colors.white38, size: 80),
                Icon(Icons.circle, color: Colors.white, size: 65),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
