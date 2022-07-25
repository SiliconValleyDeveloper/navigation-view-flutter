import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:nav_view/app/model/model.dart';
import 'package:nav_view/app/modules/home/views/spam.dart';
import 'package:nav_view/app/widgets/Txt.dart';

class CreateComplexNav extends StatefulWidget {
  const CreateComplexNav({Key? key}) : super(key: key);

  @override
  State<CreateComplexNav> createState() => _CreateComplexNavState();
}

class _CreateComplexNavState extends State<CreateComplexNav> {
  bool isExpanded = false;
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: drawerRow(),
      color: Colors.transparent,
    );
  }

  Widget drawerRow() {
    return Row(children: [
      isExpanded ? blackIconTiles() : blackIconMenu(),
      invisibleSubMenus(),
    ]);
  }

  Widget invisibleSubMenus() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: isExpanded ? 0 : 150,
      color: Colors.transparent,
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: model.length,
                itemBuilder: (context, index) {
                  Model cmd = model[index];
                  // if(index==0) return Container(height:95);
                  //controll button has 45 h + 20 top + 30 bottom = 95

                  bool selected = selectedIndex == index;
                  bool isValidSubMenu = selected && cmd.submenus.isNotEmpty;
                  return GestureDetector(
                    onTap: () {
                      print('new INDEx');
                    },
                    child: subMenuWidget(
                        [cmd.title]..addAll(cmd.submenus), isValidSubMenu),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget blackIconMenu() {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      width: 100,
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: model.length,
                itemBuilder: (contex, index) {
                  // if(index==0) return controlButton();
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      height: 45,
                      alignment: Alignment.center,
                      child: Icon(model[index].icon, color: Colors.black),
                    ),
                  );
                }),
          ),

          controlButton(),
          // accountButton(),
        ],
      ),
    );
  }

  Widget blackIconTiles() {
    return Container(
      width: 200,
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: model.length,
              itemBuilder: (BuildContext context, int index) {
                //  if(index==0) return controlTile();

                Model cdm = model[index];
                bool selected = selectedIndex == index;
                return ExpansionTile(
                    onExpansionChanged: (z) {
                      setState(() {
                        selectedIndex = z ? index : -1;
                      });
                    },
                    leading: Icon(cdm.icon, color: Colors.black),
                    title: Txt(
                      text: cdm.title,
                      color: Colors.black,
                    ),
                    trailing: cdm.submenus.isEmpty
                        ? null
                        : Icon(
                            selected
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
                    children: cdm.submenus.map((subMenu) {
                      return sMenuButton(subMenu, index, false);
                    }).toList());
              },
            ),
          ),
          controlButton()
          // accountTile(),
        ],
      ),
    );
  }

  Widget controlButton() {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 30),
      child: InkWell(
          onTap: expandOrShrinkDrawer,
          child: isExpanded
              ? Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                )
              : Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                )),
    );
  }

  Widget subMenuWidget(List<String> submenus, bool isValidSubMenu) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: isValidSubMenu ? submenus.length.toDouble() * 37.5 : 45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: isValidSubMenu ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          )),
      child: ListView.builder(
          padding: EdgeInsets.all(6),
          itemCount: isValidSubMenu ? submenus.length : 0,
          itemBuilder: (context, index) {
            String subMenu = submenus[index];
            return GestureDetector(
                onTap: () {
                  print('NEW INDEX');
                },
                child: sMenuButton(subMenu, index, false));
          }),
    );
  }

  Widget sMenuButton(String subMenu, int index, bool isTitle) {
    return InkWell(
      onTap: () {
        //handle the function
        // index == 0 ? print('YOUR LOGIN') : print('doyourlogic here');
        if (subMenu.contains("Spam")) {
          Navigator.of(context).pop();
          Get.to(() => Spamview());
        } else {
          print('idfd');
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Txt(
          text: subMenu,
          fontSize: subMenu.contains('Mail') ? 17 : 14,
          color: subMenu.contains('Mail')
              ? Colors.grey.shade800
              : Colors.grey.shade700,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static List<Model> model = [
    // CDM(Icons.grid_view, "Control", []),

    Model(Icons.grid_view, "Dashboard", []),
    Model(Icons.mail_lock, "Mail", ["Spam", "Sent", "Indox"]),
    //  Model(Icons.markunread_mailbox, "News", ["Current", "Static", "Mix"]),
    Model(Icons.pie_chart, "Analytics", []),
    Model(Icons.trending_up, "Chart", []),

    // Model(Icons.power, "Plugins",
    //     ["Ad Blocker", "Everything Https", "Dark Mode"]),
    Model(Icons.explore, "Explore", []),
    Model(Icons.settings, "Setting", []),
  ];

  void expandOrShrinkDrawer() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }
}
