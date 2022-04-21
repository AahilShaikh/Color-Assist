import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  String image;
  TestPage(this.image);




  @override
  Widget build(BuildContext context) {
    return Image.memory(base64Decode(image));
  }
}
