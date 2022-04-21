import 'package:camera/camera.dart';
import 'package:color_assist/screens/results/results_body.dart';
import 'package:color_assist/screens/results/results_panel.dart';
import 'package:color_assist/services/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ResultsPage extends ConsumerStatefulWidget {
  final XFile image;
  const ResultsPage(this.image, {Key? key}) : super(key: key);

  @override
  ConsumerState<ResultsPage> createState() => _ResultsPageState();
}

late PanelController panelController;

class _ResultsPageState extends ConsumerState<ResultsPage> {
  @override
  void initState() {
    panelController = PanelController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a part of your image'),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              ref.read(imageProvider.notifier).setImage("");
              Navigator.of(context).pop();
            },
          )
      ),
      body: SlidingUpPanel(
        controller: panelController,
        parallaxEnabled: true,
        minHeight: 100,
        maxHeight: MediaQuery.of(context).size.height * 0.8,
        borderRadius: BorderRadius.circular(20),
        backdropEnabled: true,
        panel: const Panel(),
        // body:
        body: ResultsBody(widget.image),
      ),
    );
  }
}
