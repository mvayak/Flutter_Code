import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marlo/controller/api_controller.dart';
import 'package:marlo/controller/common_controller.dart';
import 'package:marlo/utility/common_widget.dart';

import '../../utility/colors.dart';
import '../../utility/constants.dart';

class InviteScreen extends StatefulWidget {
  const InviteScreen({Key? key}) : super(key: key);

  @override
  State<InviteScreen> createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  RxString selectedRole = "Admin".obs;
  RxList<String> rolesList = ["Admin", "Approver", "Preparer", "Viewer", "Employee"].obs;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
        child: commonFillButtonView(
            context: context,
            tapOnButton: () async {
              if (_formKey.currentState!.validate()) {
                FocusScope.of(context).unfocus();
                Map<String, dynamic> params = {
                  "email": emailTextEditingController.text.trim(),
                  "role": (rolesList.indexOf(selectedRole.value) + 1)
                };
                await ApiController.to.sendInviteAPI(params,(){});
              }
              // Get.to(() => const DashboardScreen(),transition: Transition.noTransition);
            },
            isLoading: false,
            title: continueText),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: commonAppBar(leading: false, leadingColor: Theme.of(context).iconTheme.color),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(invite, style: Theme.of(context).textTheme.displaySmall),
                const SizedBox(height: 10),
                commonTextFiled(
                    hintText: "Business email",
                    textEditingController: emailTextEditingController,
                    validationFunction: (val) {
                      if (val == "") {
                        return "Enter Value";
                      } else if (!GetUtils.isEmail(val)) {
                        return "Please Enter right email";
                      }
                    }),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        backgroundColor: Theme.of(context).backgroundColor,
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.0),
                          ),
                        ),
                        builder: (context) {
                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: 15),
                                  Center(
                                      child:
                                          Container(width: 50, height: 5, decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Theme.of(context).primaryColor.withOpacity(0.5)))),
                                  SizedBox(height: 15),
                                  Text(teamRoles, style: Theme.of(context).textTheme.titleMedium),
                                  SizedBox(height: 20),
                                  Obx(() => ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: rolesList.length,
                                      itemBuilder: (context, index) {
                                        return Obx(() => Padding(
                                              padding: const EdgeInsets.only(bottom: 10.0),
                                              child: InkWell(
                                                onTap: () {
                                                  selectedRole.value = rolesList[index];
                                                },
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(15),
                                                        color: rolesList[index] == selectedRole.value
                                                            ? Theme.of(context).primaryColor.withOpacity(0.5)
                                                            : CommonController.to.isLightTheme.value
                                                                ? colorFFFFFF
                                                                : color161618),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(15.0),
                                                      child: Text(rolesList[index],
                                                          style: TextStyle(
                                                              color: rolesList[index] == selectedRole.value ? Theme.of(context).primaryColor : color75808A, fontSize: 16, fontFamily: "Heebo")),
                                                    )),
                                              ),
                                            ));
                                      }))
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Theme.of(context).cardColor),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(selectedRole.value, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: color75808A, fontSize: 14, fontWeight: FontWeight.w400)),
                          Icon(Icons.keyboard_arrow_down, color: Theme.of(context).primaryColor, size: 25)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
