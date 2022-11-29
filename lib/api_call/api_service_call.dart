import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as get_x;
import 'package:marlo/controller/api_controller.dart';
import '../main.dart';
import '../models/models.dart';
import '../utility/common_method.dart';
import 'api_config.dart';
import 'api_utility.dart';

Future<void> apiServiceCall(
    {required Map<String, dynamic> params,
    required String serviceUrl,
    required Function success,
    required Function error,
    required bool isProgressShow,
    required String methodType,
    bool isFromLogout = false,
    FormData? formValues}) async {
  Map<String, dynamic>? tempParams = params;
  String? tempServiceUrl = serviceUrl;
  Function? tempSuccess = success;
  String? tempMethodType = methodType;
  Function? tempError = error;
  bool? tempIsProgressShow = isProgressShow;
  bool? tempIsFromLogout = isFromLogout;
  FormData? tempFormData = formValues;
  int serviceCallCount = 0;

  showErrorMessage({required String message, required bool isRecall, Function? callBack}) {
    serviceCallCount = 0;
    serviceCallCount++;
    apiAlertDialog(
        buttonTitle: serviceCallCount < 3 ? tryAgain : restartApp,
        message: message,
        buttonCallBack: () {
          if (serviceCallCount < 3) {
            if (isRecall) {
              get_x.Get.back();
              apiServiceCall(
                  params: tempParams,
                  serviceUrl: tempServiceUrl,
                  success: tempSuccess,
                  error: tempError,
                  isProgressShow: tempIsProgressShow,
                  methodType: tempMethodType,
                  formValues: tempFormData,
                  isFromLogout: tempIsFromLogout);
            } else {
              if (callBack != null) {
                callBack();
              } else {
                get_x.Get.back(); // For redirecting to back screen
              }
            }
          } else {
            get_x.Get.offAll(() => const MyApp());
          }
        });
  }

  if (await checkInternet()) {
    if (tempFormData != null) {
      Map<String, dynamic> tempMap = <String, dynamic>{};
      for (var element in tempFormData.fields) {
        tempMap[element.key] = element.value;
      }
      FormData reGenerateFormData = FormData.fromMap(tempMap);
      for (var element in tempFormData.files) {
        reGenerateFormData.files.add(MapEntry(element.key, element.value));
      }

      tempFormData = reGenerateFormData;
    }
    Map<String, dynamic> headerParameters;
    headerParameters = {};
    headerParameters = {"authtoken": ApiController.to.loginData.value.idToken ?? ""};

    // try {
    Response response;
    if (tempMethodType == ApiConfig.methodGET) {
      response = await APIProvider.getDio().get(tempServiceUrl,
          queryParameters: tempParams,
          options: Options(
            headers: headerParameters,
            responseType: ResponseType.plain,
          ));
    } else if (tempMethodType == ApiConfig.methodPUT) {
      response = await APIProvider.getDio().put(tempServiceUrl,
          data: tempParams,
          options: Options(
            headers: headerParameters,
            responseType: ResponseType.plain,
          ));
    } else if (tempMethodType == ApiConfig.methodDELETE) {
      response = await APIProvider.getDio().delete(tempServiceUrl, data: tempParams, options: Options(headers: headerParameters));
    } else {
      response = await APIProvider.getDio().post(tempServiceUrl,
          data: tempFormData != null ? tempFormData : tempParams,
          options: Options(
            headers: headerParameters,
            responseType: ResponseType.plain,
          ));
    }

    if (handleResponse(response)) {
      if (kDebugMode) {
        print(response);
        print(tempServiceUrl);
        print(tempParams);
        print(response.data);
      }
      if (response.statusCode == 200) {
        tempSuccess(response);
      }else if (response.statusCode == 201) {
        tempSuccess(response);
      } else {
        ///region 401 = Session Expired  Manage Authentication/Session Expire
        if (response.statusCode == 401) {
          // handleAuthentication(tempIsFromLogout, boolResponse: CommonModel.fromJson(jsonDecode(response.data)));
        } else {
          tempError(CommonModel.fromJson(jsonDecode(response.data)).message);
        }
      }
    } else {
      showErrorMessage(message: responseMessage, isRecall: true);
      tempError(response.toString());
    }
    // } on DioError catch (dioError) {
    //   dioErrorCall(
    //       dioError: dioError,
    //       onCallBack: (String message, bool isRecallError) {
    //         showErrorMessage(message: message, isRecall: isRecallError);
    //       });
    // } catch (e) {
    //   showErrorMessage(message: e.toString(), isRecall: true);
    // }
  } else {
    showErrorMessage(message: interNetMessage, isRecall: true);
  }
}

Future<bool> checkInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

bool handleResponse(Response response) {
  try {
    if (isNotEmptyString(response.toString())) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

dioErrorCall({required DioError dioError, required Function onCallBack}) {
  switch (dioError.type) {
    case DioErrorType.other:
    case DioErrorType.connectTimeout:
      // onCallBack(connectionTimeOutMessage, false);
      onCallBack(dioError.message, true);
      break;
    case DioErrorType.response:
    case DioErrorType.cancel:
    case DioErrorType.receiveTimeout:
    case DioErrorType.sendTimeout:
    default:
      onCallBack(dioError.message, true);
      break;
  }
}

apiAlertDialog({required String message, String? buttonTitle, Function? buttonCallBack, bool isShowGoBack = true}) {
  if (!get_x.Get.isDialogOpen!) {
    get_x.Get.dialog(
      WillPopScope(
        onWillPop: () {
          return isShowGoBack ? Future.value(true) : Future.value(false);
        },
        child: CupertinoAlertDialog(
          title: const Text(appName),
          content: Text(message),
          actions: isShowGoBack
              ? [
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Text(isNotEmptyString(buttonTitle) ? buttonTitle! : tryAgain),
                    onPressed: () {
                      if (buttonCallBack != null) {
                        buttonCallBack();
                      } else {
                        get_x.Get.back();
                      }
                    },
                  ),
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    child: const Text(goBack),
                    onPressed: () {
                      get_x.Get.back();
                      get_x.Get.back();
                    },
                  )
                ]
              : [
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Text(isNotEmptyString(buttonTitle) ? buttonTitle! : tryAgain),
                    onPressed: () {
                      if (buttonCallBack != null) {
                        buttonCallBack();
                      } else {
                        get_x.Get.back();
                      }
                    },
                  ),
                ],
        ),
      ),
      barrierDismissible: false,
      transitionCurve: Curves.easeInCubic,
      transitionDuration: const Duration(milliseconds: 400),
    );
  }
}
