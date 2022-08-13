import 'package:flutter/material.dart';
import 'package:calories_counter_project/screens/home_screen.dart';
import 'package:calories_counter_project/screens/profile_user.dart';
import 'package:calories_counter_project/screens/record_food.dart';


class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  int currentTab = 0;
  final List<Widget> screens = [
    HomeScreen(),
    Food(),
    UserProfile(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen();

  @override
  Widget build(BuildContext context) {
    bool useKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: Visibility(
        visible: !useKeyboard,
        child: FloatingActionButton(
          backgroundColor: Color(0xFF5fb27c),
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
          onPressed: (){
            setState(() {
              currentScreen = const Food();
              currentTab = 2;
            });
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 2,

        child: Container(
          height: 53,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen = const HomeScreen();
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
                          "Home",
                          style: TextStyle(
                              color: currentTab == 0 ? Color(0xFF5fb27c) : Colors.grey
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen = UserProfile();
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
                          "Profile",
                          style: TextStyle(
                              color: currentTab == 1 ? Color(0xFF5fb27c) : Colors.grey
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
