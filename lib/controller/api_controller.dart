import 'dart:convert';

import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:marlo/models/models.dart';
import 'package:marlo/models/team_model.dart';
import '../api_call/api_config.dart';
import '../api_call/api_service_call.dart';
import '../models/token_model.dart';
import '../utility/common_method.dart';

class ApiController extends GetxController {
  static ApiController get to => Get.find(); // add this
  Rx<TokenModel> loginData = TokenModel().obs;

  Future<void> getTokenAPI(Function callBack) async {
    await apiServiceCall(
      params: {"email": "xihoh55496@dineroa.com", "password": "Marlo@123", "returnSecureToken": true},
      serviceUrl: ApiConfig.tokenGet,
      success: (dio.Response<dynamic> response) {
        loginData.value = TokenModel.fromJson(jsonDecode(response.data));
        callBack();
      },
      error: (String response) {
        showSnackBar(title: ApiConfig.error, message: response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

  Rx<TeamModel> teamData = TeamModel().obs;

  Future<void> getTeamAPI(Function callBack) async {
    await apiServiceCall(
      params: {},
      serviceUrl: ApiConfig.teamGet,
      success: (dio.Response<dynamic> response) {
        teamData.value = TeamModel();
        teamData.value = TeamModel.fromJson(jsonDecode(response.data));
        print(teamData.value);
        callBack();
      },
      error: (String response) {
        showSnackBar(title: ApiConfig.error, message: response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodGET,
    );
  }

  Future<void> sendInviteAPI(Map<String, dynamic> params, Function callBack) async {
    await apiServiceCall(
      params: params,
      serviceUrl: ApiConfig.inviteSend,
      success: (dio.Response<dynamic> response) {
        if (CommonModel.fromJson(jsonDecode(response.data)).error_flag == "EMAIL_EXISTS") {
          showSnackBar(title: ApiConfig.error, message: CommonModel.fromJson(jsonDecode(response.data)).message ?? "");
        } else {
          Get.back();
          showSnackBar(title: ApiConfig.success, message: CommonModel.fromJson(jsonDecode(response.data)).message ?? "");
        }
        callBack();
      },
      error: (String response) {
        showSnackBar(title: ApiConfig.error, message: response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }
}
