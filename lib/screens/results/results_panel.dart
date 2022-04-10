import 'dart:convert';
import 'package:color_assist/screens/results/results_page.dart';
import 'package:color_assist/services/provider.dart';
import 'package:color_assist/services/rectangle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class Panel extends ConsumerStatefulWidget {
  const Panel({Key? key}) : super(key: key);

  @override
  ConsumerState<Panel> createState() => _PanelState();
}

class _PanelState extends ConsumerState<Panel> {
  Future<List<dynamic>> getAPIData(String event) async {
    List<dynamic> data = [];
    var response = await http.get(Uri.parse(Uri.encodeFull('')), headers: {});
    try {
      data = json.decode(response.body);
    } catch (e) {}
    return data;
  }

  Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
    String finalImage = ref.watch(imageProvider);
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        //make the container rounded
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: const [
              Spacer(),
              Expanded(
                  child: Divider(
                color: Colors.grey,
                thickness: 3,
              )),
              Spacer(),
            ],
          ),
          finalImage.isEmpty
              ? Container()
              : FutureBuilder(
                  //TODO
                  future: Future.delayed(const Duration(seconds: 5), () => {"Name": "Blue", "Hex Code": "#0000FF", "RGB": "0,0,255"}),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Shimmer.fromColors(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 48.0,
                                  height: 48.0,
                                  color: Colors.white,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                      Container(
                                        width: 40.0,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          baseColor: Colors.grey.shade600,
                          highlightColor: Colors.white);
                    }
                    Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
                    print(snapshot.data);
                    panelController.animatePanelToPosition(1);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CustomPaint(
                                    painter: Rectangle(Color(hexToColor(data["Hex Code"]).value)),
                                  ),
                                ),
                                Text(
                                  data['Name'],
                                  style: TextStyle(fontSize: 15, color: Colors.grey.shade200),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Hex Code:",
                                  style: TextStyle(fontSize: 15, color: Colors.grey.shade200),
                                ),
                                Text(
                                  data['Hex Code'],
                                  style: TextStyle(fontSize: 15, color: Colors.grey.shade200),
                                ),
                                Text(
                                  "RGB Value:",
                                  style: TextStyle(fontSize: 15, color: Colors.grey.shade200),
                                ),
                                Text(
                                  "(${data['RGB']})",
                                  style: TextStyle(fontSize: 15, color: Colors.grey.shade200),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Complementary Colors", style: TextStyle(fontSize: 20, color: Colors.grey.shade200)),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 555,
                            separatorBuilder: (context, index) => const SizedBox(
                              width: 10,
                            ),
                            itemBuilder: (context, index) {
                              return SizedBox(
                                width: 50,
                                height: 50,
                                child: CustomPaint(
                                  painter: Rectangle(Color(hexToColor(data["Hex Code"]).value)),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    );
                  },
                )
        ],
      ),
    );
  }
}
