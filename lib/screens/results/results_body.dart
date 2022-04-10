import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:color_assist/screens/results/results_page.dart';
import 'package:color_assist/screens/testPage.dart';
import 'package:color_assist/services/provider.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
//import consumer
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultsBody extends ConsumerStatefulWidget {
  final XFile imagePath;
  const ResultsBody(this.imagePath, {Key? key}) : super(key: key);

  @override
  ConsumerState<ResultsBody> createState() => _ResultsBodyState();
}

class _ResultsBodyState extends ConsumerState<ResultsBody> {
  final CropController cropController = CropController();
  @override
  Widget build(BuildContext context) {
    File file = File(widget.imagePath.path);
    Uint8List bytes = file.readAsBytesSync();
    return Stack(
      children: [
        Crop(
          controller: cropController,
          image: bytes,
          onCropped: (image) {
            ref.read(imageProvider.notifier).setImage(base64Encode(image));
            panelController.animatePanelToPosition(0.3);
            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => TestPage(base64Encode(image))));
          },
          initialSize: 0.4,
          interactive: true,
        ),
        Positioned(
          bottom: 200,
          left: (MediaQuery.of(context).size.width / 2) - 30,
          child: ElevatedButton(
            //make the button into a circle shape
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(const Size(50, 50)),
              shape: MaterialStateProperty.all(const CircleBorder()),
            ),

            child: const Icon(
              Icons.check,
              size: 30,
            ),
            onPressed: () {
              cropController.crop();
            },
          ),
        )
      ],
    );
  }
}
