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
    const HomeScreen(),
    const Food(),
    const UserProfile(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomeScreen();

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
            setState(() {
              currentScreen = const Food();
              currentTab = 2;
            });
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 3,
        color: const Color(0xFF5fb27c),

        child: SizedBox(
          height: 60,
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
                          color: currentTab == 0 ? Colors.white : const Color(0xFFc3fff5),
                        ),
                        Text(
                          "Home",
                          style: TextStyle(
                              fontWeight: currentTab == 0 ? FontWeight.bold : FontWeight.normal,
                            color: currentTab == 0 ? Colors.white : const Color(0xFFc3fff5)
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
                        currentScreen = const UserProfile();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.account_circle,
                          color: currentTab == 1 ? Colors.white : const Color(0xFFc3fff5),
                        ),
                        Text(
                          "Profile",
                          style: TextStyle(
                              fontWeight: currentTab == 1 ? FontWeight.bold : FontWeight.normal,
                              color: currentTab == 1 ? Colors.white : const Color(0xFFc3fff5)
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
