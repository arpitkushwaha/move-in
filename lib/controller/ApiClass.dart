import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ApiClass {
  static String bearerToken = "";
  static String defaultFormation = "";

  ApiClass() {}

  static void getApiCall(data, onSuccess, onError) {
    final Map<String, String> defaultgetHeader = {
      "Content-Type": "application/json",
    };
    print("url ${data["url"]}");
    var header = data.containsKey("header") ? data["header"] : defaultgetHeader;

    http
        .get(data["url"], headers: header)
        .timeout(
          Duration(seconds: 20),
        )
        .then((http.Response response) {
      print("errror ${response.statusCode}");
      if (response.statusCode < 200 ||
          response.statusCode >= 400 ||
          response == null) {
        onError({"status": 0, "message": response.body});
      } else {
        onSuccess({"status": 1, "response": response.body});
      }
    }).catchError((error) {
      print("errror $error");
      if (error is TimeoutException || error is SocketException) {
        onError({
          "status": -1,
          "message":
              "Something went wrong, please check your internet connection."
        });
        return;
      }
      onError({"status": 0, "message": error});
    });
  }

  static void getApiCallWithAuth(data, onSuccess, onError) {
    print(data);
    print("token:$bearerToken");
    final Map<String, String> defaultgetHeader = {
      "Content-Type": "application/json",
      "Authorization": 'Bearer ${bearerToken}',
    };

    var header = data.containsKey("header") ? data["header"] : defaultgetHeader;

    http
        .get(data["url"], headers: header)
        .timeout(
          Duration(seconds: 20),
        )
        .then((http.Response response) {
      print("errror ${response.statusCode}");
      if (response.statusCode < 200 ||
          response.statusCode >= 400 ||
          response == null) {
        onError({"status": 0, "message": response.body});
      } else {
        onSuccess({"status": 1, "response": response.body});
      }
    }).catchError((error) {
      print("errror $error");
      if (error is TimeoutException || error is SocketException) {
        onError({
          "status": -1,
          "message":
              "Something went wrong, please check your internet connection."
        });
        return;
      }
      onError({"status": 0, "message": error});
    });
  }

  static getAsyncApiCall(data) async {
    final Map<String, String> defaultHeader = {
      "Content-Type": "application/json",
    };
    var header = data.containsKey("header") ? data["header"] : defaultHeader;
//print('djshgv $data["url"]');
    final response = await http.get(data["url"], headers: header);
    return response == null ||
            response.statusCode < 200 ||
            response.statusCode >= 400
        ? {"status": 0, "message": response.body}
        : {"status": 1, "response": json.decode(response.body)};
  }

  static void postApiCall(apiData, onSuccess, onError) {
    print("url: ${apiData["url"]}");
    final Map<String, String> defaultHeader = {
      "Content-Type": "application/json",
    };
    var header =
        apiData.containsKey("header") ? apiData["header"] : defaultHeader;
    print("post data ${apiData["data"]}");

    http
        .post(apiData["url"],
            headers: header, body: json.encode(apiData["data"] ?? {}))
        .timeout(Duration(seconds: 20))
        .then((http.Response response) {
      print("responce ${response.statusCode}");
      response.statusCode < 200 ||
              response.statusCode >= 400 ||
              response == null
          ? onError({
              "status": 0,
              "message": response.statusCode == 404
                  ? json.encode({"message": "Not Found"})
                  : response.body
            })
          : onSuccess({"status": 1, "response": response.body});
    })
          ..catchError((error) {
            print("errror $error");
            if (error is TimeoutException || error is SocketException) {
              onError({
                "status": -1,
                "message":
                    "Something went wrong, please check your internet connection."
              });
              return;
            }

            onError({"status": 0, "message": error});
          });
  }

  static void postApiCallWithAuthHeader(apiData, onSuccess, onError) {
    final Map<String, String> defaultHeader = {
      "Content-Type": "application/json",
      "Authorization": 'Bearer ${bearerToken}',
    };
    var header =
        apiData.containsKey("header") ? apiData["header"] : defaultHeader;
    print("post data ${apiData["data"]}");

    http.post(apiData["url"],
            headers: header, body: json.encode(apiData["data"] ?? {}))
        .timeout(Duration(seconds: 20))
        .then((http.Response response) {
      print("responce ${response.statusCode}");
      response.statusCode < 200 ||
              response.statusCode >= 400 ||
              response == null
          ? onError({
              "status": 0,
              "message": response.statusCode == 404
                  ? json.encode({"message": "Not Found"})
                  : response.body
            })
          : onSuccess({"status": 1, "response": response.body});
    })
          ..catchError((error) {
            print("errror $error");
            if (error is TimeoutException || error is SocketException) {
              onError({
                "status": -1,
                "message":
                    "Something went wrong, please check your internet connection."
              });
              return;
            }

            onError({"status": 0, "message": error});
          });
  }
  static void putApiCallWithAuthHeader(apiData, onSuccess, onError) {
    final Map<String, String> defaultHeader = {
      "Content-Type": "application/json",
      "Authorization": 'Bearer ${bearerToken}',
    };
    var header =
    apiData.containsKey("header") ? apiData["header"] : defaultHeader;
    print("post data ${apiData["data"]}");

    http.put(apiData["url"],
        headers: header, body: json.encode(apiData["data"] ?? {}))
        .timeout(Duration(seconds: 20))
        .then((http.Response response) {
      print("responce ${response.statusCode}");
      response.statusCode < 200 ||
          response.statusCode >= 400 ||
          response == null
          ? onError({
        "status": 0,
        "message": response.statusCode == 404
            ? json.encode({"message": "Not Found"})
            : response.body
      })
          : onSuccess({"status": 1, "response": response.body});
    })
      ..catchError((error) {
        print("errror $error");
        if (error is TimeoutException || error is SocketException) {
          onError({
            "status": -1,
            "message":
            "Something went wrong, please check your internet connection."
          });
          return;
        }

        onError({"status": 0, "message": error});
      });
  }
  static Future<void> uploadProfilePic(
      File img, String url, onSuccess, onError) async {
    var stream = new http.ByteStream(DelegatingStream.typed(img.openRead()));
    var length = await img.length();

    var uri = Uri.parse(url);

    var request = new http.MultipartRequest("POST", uri);
    request.headers["Authorization"] = 'Bearer $bearerToken';
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(img.path));
    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      if (value.contains("success")) {
        print(value);
        onSuccess(value);
      } else {
        print(value);
        onError(value);
      }
    });
  }

  static Future<void> uploadImageWithData(
      File img, String url, onSuccess, onError, var map) async {
    var uri = Uri.parse(url);
    var request = new http.MultipartRequest("POST", uri);
    request.headers["Authorization"] = 'Bearer ${bearerToken}';
    if (img != null) {
      var stream = new http.ByteStream(DelegatingStream.typed(img.openRead()));
      var length = await img.length();
      var multipartFile = new http.MultipartFile('group_image', stream, length,
          filename: basename(img.path));
      request.files.add(multipartFile);
    }
    print("map => $map");
    request.fields.addAll({"payload": jsonEncode(map)});
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      if (value.contains("success")) {
        print(value);
        onSuccess(value);
      } else {
        print(value);
        onError(value);
      }
    });
  }

}
