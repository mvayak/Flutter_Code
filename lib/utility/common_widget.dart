import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'colors.dart';

AppBar commonAppBar({
  double? elevation = 0,
  bool? leading,
  Widget? leadingWidget,
  Color? leadingColor,
  Widget? titleWidget,
  String? title,
  TextStyle? titleStyle,
  List<Widget>? actions,
  Function? onPressed,
  Color? bgColor,
}) {
  return AppBar(
      toolbarHeight: 60,
      automaticallyImplyLeading: false,
      titleSpacing: 0.0,
      leading: Padding(
        padding: EdgeInsets.only(left: 8.0, right: leading == false ? 0 : 15),
        child: leading == false
            ? IconButton(
                onPressed: () => Get.back(result: true),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: leadingColor ?? color000000,
                ),
              )
            : leadingWidget ?? Container(),
      ),
      centerTitle: true,
      title: titleWidget ?? Text(title ?? "", textAlign: TextAlign.start, style: titleStyle ?? const TextStyle(color: Colors.black, fontSize: 18), maxLines: 1, overflow: TextOverflow.ellipsis),
      actions: actions ?? [],
      elevation: elevation!);
}

Widget commonFillButtonView(
    {required BuildContext context,
    required Function tapOnButton,
    required bool isLoading,
    String? title,
    double? height = 50.0,
    double? width}) {
  return SizedBox(
    width: width ?? MediaQuery.of(context).size.width,
    height: height,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ElevatedButton(
        onPressed: () {
          if (!isLoading) {
            tapOnButton();
          }
        },
        child: Text(title ?? ""),
        style: ElevatedButton.styleFrom(
          shadowColor: Theme.of(context).primaryColor,
          elevation: 12,
          textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    ),
  );
}

Widget commonTextFiled({
  String? title,
  required String hintText,
  bool isPassword = false,
  bool isRequired = true,
  required TextEditingController textEditingController,
  Function? validationFunction,
  int? maxLength,
  Function? onSavedFunction,
  Function? onFieldSubmit,
  TextInputType? keyboardType,
  Function? onTapFunction,
  Function? onChangedFunction,
  List<TextInputFormatter>? inputFormatter,
  bool isEnabled = true,
  bool isReadOnly = false,
  int? errorMaxLines,
  int? maxLine,
  FocusNode? textFocusNode,
  GlobalKey<FormFieldState>? key,
  TextAlign align = TextAlign.start,
  Widget? suffixIcon,
  Widget? preFixIcon,
  bool? border = false,
  bool isShowTitle = true,
  Color? bgColor,
  UnderlineInputBorder? underlineInputBorder,
  EdgeInsetsGeometry? contentPadding,
}) {
  bool passwordVisible = isPassword;
  return StatefulBuilder(
    builder: (context, newSetState) {
      return TextFormField(
        enabled: !isEnabled ? false : true,
        textAlign: align,
        showCursor: !isReadOnly,
        readOnly: isReadOnly,
        onTap: () {
          if (onTapFunction != null) {
            onTapFunction();
          }
        },
        key: key,
        focusNode: textFocusNode,
        onChanged: (value) {
          if (onChangedFunction != null) {
            onChangedFunction(value);
          }
        },
        validator: (value) {
          return validationFunction != null ? validationFunction(value) : null;
        },
        onSaved: (value) {
          return onSavedFunction != null ? onSavedFunction(value) : null;
        },
        onFieldSubmitted: (value) {
          return onFieldSubmit != null ? onFieldSubmit(value) : null;
        },
        maxLines: maxLine ?? 1,
        keyboardType: keyboardType,
        controller: textEditingController,
        cursorColor: color9E9E9E,
        obscureText: passwordVisible,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w400),
        inputFormatters: inputFormatter,
        decoration: InputDecoration(
          errorMaxLines: errorMaxLines ?? 1,
          filled: true,
          fillColor: bgColor ?? Theme.of(context).cardColor,
          contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
          focusedBorder: border == false ? textFieldBorderStyle : null,
          disabledBorder: border == false ? textFieldBorderStyle : null,
          enabledBorder: border == false ? textFieldBorderStyle : null,
          errorBorder: border == false ? textFieldBorderStyle : null,
          border: InputBorder.none,
          focusedErrorBorder: border == false ? textFieldBorderStyle : null,
          labelText: hintText,
          labelStyle:Theme.of(context).textTheme.titleMedium?.copyWith(color: color75808A,fontSize: 16, fontWeight: FontWeight.w400) ,
          alignLabelWithHint: true,
          prefixIcon: preFixIcon,
          hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(color: color75808A,fontSize: 14, fontWeight: FontWeight.w400),
          suffixIcon: isPassword
              ? InkWell(
              onTap: () {
                newSetState(() {
                  passwordVisible = !passwordVisible;
                });
              },
              child: passwordVisible
                  ? const Icon(Icons.visibility_off, color: color9E9E9E)
                  : const Icon(Icons.visibility_rounded, color: color9E9E9E))
              : suffixIcon,
        ),
      );
    },
  );
}

OutlineInputBorder textFieldBorderStyle =
OutlineInputBorder(borderSide: const BorderSide(color: Colors.transparent), borderRadius: commonButtonBorderRadius);

BorderRadius commonButtonBorderRadius = BorderRadius.circular(15.0);
