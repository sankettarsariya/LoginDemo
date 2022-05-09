


class AppConst {
  static const String doctor = "Doctor";
  static const String patient = "PATIENT";
  static const String odpMessage = "ODP";
  static const String textMessage = "TEXT";
  
    void loginUser() async {
    try {
      response = await dio.post(
        'apiurl',
        data: {
          'email': emailController.text,
          'password': passController.text,
          'device_id': deviceID,
          'device_token': deviceToken,
          'device_type': deviceType,
        },
      );

      if (response!.statusCode == 200) {
        setState(() {
          jsonData = jsonDecode(response.toString());
        });
        if (jsonData['status'] == 1) {
          setUserData();
          // Navigator.of(context).pushNamedAndRemoveUntil(
          //     '/home', (Route<dynamic> route) => false);
        }
        if (jsonData['status'] == 0) {
          // Toasty.showtoast(jsonData['message']);
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getPrefData({var key}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var data = prefs.getString(key);
  return data;
}

Future setPrefIntData({var key, var value}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, value);
}

class InitialData {
  var deviceToken;
  var deviceID;
  var deviceType;
  Future<void> getDeviceTypeId() async {
    var deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      deviceType = 0;
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceID = androidDeviceInfo.androidId;
      // print('Device Type: ${deviceType.toString()}, ' + 'Device ID: $deviceID');
    } else {
      deviceType = 1;
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceID = iosDeviceInfo.identifierForVendor;
      // print('Device Type: ${deviceType.toString()}, ' + 'Device ID: $deviceID');
    }
  }

  getDeviceToken() {
    var random = Random();
    var values = List<int>.generate(200, (i) => random.nextInt(255));
    deviceToken = base64UrlEncode(values);
    // print('Device Token: ' + deviceToken);
  }
  
}
