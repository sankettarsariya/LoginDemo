


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

  
}
