import 'package:calories_counter_project/screens/listsfood_screen.dart';
import 'package:calories_counter_project/screens/stats_screen.dart';
import 'package:calories_counter_project/widgets/tabbar.dart';
import 'package:flutter/material.dart';
import 'package:calories_counter_project/screens/home_screen.dart';
import 'package:calories_counter_project/screens/profile_user.dart';


class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  int currentTab = 0;
  final List<Widget> screens = [
    HomeScreen(),
    const UserProfile(),
    const FoodList(),
    const StatScreen()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen();

  @override
  Widget build(BuildContext context) {
    bool useKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(

      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: Visibility(
        visible: !useKeyboard,
        child: FloatingActionButton(
          backgroundColor: const Color(0xFF5fb27c),
          foregroundColor: Colors.white,
          child: const Icon(Icons.add),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return TabBarWidget();
            }));
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 5,
        color: Colors.white,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 5,),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen = HomeScreen();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: currentTab == 0 ? Color(0xFF5fb27c) : Colors.grey,
                        ),
                        Text(
                          "หน้าหลัก",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                            color: currentTab == 0 ? Color(0xFF5fb27c) : Colors.grey
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 5,),

                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen = const FoodList();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.fastfood,
                          color: currentTab == 3 ? Color(0xFF5fb27c) : Colors.grey,
                        ),
                        Text(
                          "อาหาร",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: currentTab == 3 ? Color(0xFF5fb27c) : Colors.grey
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen = const StatScreen();
                        currentTab = 4;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.stacked_bar_chart,
                          color: currentTab == 4 ?  Color(0xFF5fb27c) : Colors.grey,
                        ),
                        Text(
                          "สถิติ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: currentTab == 4 ?  Color(0xFF5fb27c) : Colors.grey
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 15,),
                  MaterialButton(

                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen = const UserProfile();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.account_circle,
                          color: currentTab == 1 ? Color(0xFF5fb27c) : Colors.grey,
                        ),
                        Text(
                          "ข้อมูล",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: currentTab == 1 ? Color(0xFF5fb27c) : Colors.grey
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 5,),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
