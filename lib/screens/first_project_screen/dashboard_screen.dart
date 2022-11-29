import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marlo/controller/api_controller.dart';
import 'package:marlo/utility/common_widget.dart';

import '../../controller/common_controller.dart';
import '../../utility/colors.dart';
import '../../utility/constants.dart';
import 'invite_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  _getData() async {
    await ApiController.to.getTeamAPI(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        width: 65.0,
        height: 65.0,
        child: FloatingActionButton(
          onPressed: () {
            Get.to(() => const InviteScreen());
          },
          backgroundColor: color0CABDF,
          child: Icon(Icons.add, color: Theme.of(context).primaryIconTheme.color, size: 25),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Obx(() {
        return ApiController.to.teamData.value.data == null
            ? CupertinoActivityIndicator()
            : Column(
                children: [
                  const SizedBox(height: 40),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text(teams, style: Theme.of(context).textTheme.displaySmall), Image.asset("assets/icons/charm_search.png", scale: 4)],
                            ),
                            const SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(allPeople + (ApiController.to.teamData.value.data?.contacts?.length.toString() ?? ""),
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500, fontSize: 18, color: color75808A, letterSpacing: 0.5)),
                                Text(seeAll, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600, fontSize: 18, color: color0CABDF, letterSpacing: 0.5)),
                              ],
                            ),
                            const SizedBox(height: 15),
                            ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: ApiController.to.teamData.value.data?.contacts?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10.0),
                                    child: commonItem(
                                        context: context,
                                        title: (ApiController.to.teamData.value.data?.contacts?[index].firstname ?? "") + " " + (ApiController.to.teamData.value.data?.contacts?[index].lastname ?? ""),
                                        subtitle: (ApiController.to.teamData.value.data?.contacts?[index].isactive ?? false) ? "Un active" : "Active",
                                        stats: ApiController.to.teamData.value.data?.contacts?[index].roleName ?? ""),
                                  );
                                }),
                            const SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(invitedPeople + (ApiController.to.teamData.value.data?.invites?.length.toString() ?? ""),
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500, fontSize: 18, color: color75808A, letterSpacing: 0.5)),
                                Text(seeAll, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600, fontSize: 18, color: color0CABDF, letterSpacing: 0.5)),
                              ],
                            ),
                            const SizedBox(height: 15),
                            ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: ApiController.to.teamData.value.data?.invites?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10.0),
                                    child: commonItem(
                                        context: context,
                                        title: ApiController.to.teamData.value.data?.invites?[index].email ?? "",
                                        subtitle: ApiController.to.teamData.value.data?.invites?[index].configName ?? "",
                                        stats: ""),
                                  );
                                })
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
      }),
    );
  }
}

Widget commonItem({required BuildContext context, required String title, required String subtitle, required String stats}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Theme.of(context).cardColor,
    ),
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: color0CABDF,
            ),
            child: Center(child: Text(title.trim().isNotEmpty ? "${(title.split(" ").first[0])}" : "", style: Theme.of(context).textTheme.titleMedium)),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(title, style: Theme.of(context).textTheme.titleMedium,maxLines: 1,overflow: TextOverflow.ellipsis)),
                    Text(stats, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 15, fontWeight: FontWeight.w400)),
                  ],
                ),
                Text(subtitle, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w400, color: color75808A)),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
