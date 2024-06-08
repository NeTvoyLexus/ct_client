import 'dart:async';

import 'package:client/api/image_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_drawing_board/paint_contents.dart';

class DrawScreen extends StatefulWidget {
  final int index;
  final String ierogliph;
  const DrawScreen({super.key, required this.index, required this.ierogliph});

  @override
  State<DrawScreen> createState() => _DrawScreenState(index, ierogliph);
}

class _DrawScreenState extends State<DrawScreen> {
  final int index;
  final String ierogliph;
  final DrawingController _drawingController = DrawingController(
      config: DrawConfig(color: Colors.grey, contentType: SimpleLine));
  final TransformationController _transformationController =
      TransformationController();

  _DrawScreenState(this.index, this.ierogliph);

  @override
  void dispose() {
    _drawingController.dispose();
    super.dispose();
  }

  Future<void> _sendPredict() async {
    final Uint8List? data =
        (await _drawingController.getImageData())?.buffer.asUint8List();
    if (data == null) {
      return;
    }

    if (mounted) {
      final answer = await PredictApi.predict(data, index);

      showDialog<void>(
        context: context,
        builder: (BuildContext c) {
          return Material(
              color: Colors.transparent,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(c),
                child: Text(
                  answer,
                  style: TextStyle(fontSize: 50),
                ),
              ));
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        centerTitle: true,
        title: Text(ierogliph),
        actions: [
          IconButton(
            icon: const Icon(Icons.file_upload),
            onPressed: _sendPredict,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          Expanded(
            flex: 4,
            child: DrawingBoard(
              transformationController: _transformationController,
              controller: _drawingController,
              background: Container(
                width: width,
                height: width,
                color: Colors.black,
              ),
              showDefaultActions: true,
              showDefaultTools: true,
              boardScaleEnabled: false,
              boardPanEnabled: false,
            ),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
