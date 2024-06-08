import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

class PredictApi {
  static Future<String> predict(Uint8List data, int index) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse("http://localhost:8000/predict"),
    );
    request.fields['title'] = 'predictImage';
    var picture = http.MultipartFile.fromBytes(
      'file',
      data,
      filename: "$index.png",
    );
    request.files.add(picture);

    var response = await request.send();
    final respStr = await response.stream.single;

    if (response.statusCode == 200) {
      var body = json.decode(utf8.decode(respStr));
      var equals = body['equals'];
      print('Validation: $equals');

      if (equals) {
        return 'Правильно!';
      }

      return 'Не правильно!';
    }

    return Future.error('Server has problems');
  }
}
