import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_truecaller_auth/Services/sharedPreferencesServices.dart';

import '../main.dart';




class Attendance{


  final url = Uri.parse('${BASEURL}/register');
  Future<String> getData({required String image, required String link, required String status, required String name, required String email}) async {

    try {
      // Map<String, dynamic> data = jsonDecode(DemoJson);
      // return UserDataModel.fromJson(data);

      // var request = http.MultipartRequest('POST', url);
      String fileName = image.split('/').last;
      Dio dio = Dio();

      print("  $image $status $link $email #$name ");
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(image, filename: fileName),
        'link': link,
        'status': status,
     //   'latitude': '0.00000',
       // 'longitude': '0.00000',
        'email': email,
        'name': name,
      });

      Response responseData = await dio.post(url.toString(), data:formData).timeout(Duration(seconds: 20));
      if(responseData.statusCode == 200){
        log(responseData.data.toString());
        final jsonData = responseData.data.map((key, value) => MapEntry(key, value.toString()));
        final jsonString = json.encode(jsonData);
        storeData(userData: jsonString);
        return "User successfully registered";
      }else{
        print("responseData.data = ${responseData.data}");
        final jsonData = responseData.data.map((key, value) => MapEntry(key, value.toString()));
        log("${jsonData['message']}");
        throw Exception("${responseData}"); 
      }

    }on DioException catch (e){
      var dio_error;
        print("error response data =  ${e.response!.data.toString()}");
        dio_error = e.response!.data['error'];
        String jsonString = json.encode(e.response!.data['raw_data']);
        List<dynamic> dynamicList  = [jsonString,dio_error];
        List<String> stringList = dynamicList.map((e) => e.toString()).toList();
      throw Exception(dio_error);
    }
    on TimeoutException catch (e) {throw Exception("Timeout try after some time");
    } catch (error) {
      String s = error.toString();
      int idx = s.indexOf(":");
      print("main error : ${error}");
      var s_error = s.substring(idx+1).trim();
      throw Exception("${error.toString()}");
    }
  }
}



String DemoJson = '''{
	"employee_id": "12345",
	"request_type": "Check IN",
	"employee_name": "Utsav",
	"current_time": "10:45",
	"total_work_hours": "09:00",
	"status": "true",
	"start_time": "08:00",
	"end_time": "08:00",
	"user_id": "12344",
	"gender":"MALE"
}'''