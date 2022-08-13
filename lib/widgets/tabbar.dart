import 'package:calories_counter_project/tabs/food_barcode.dart';
import 'package:calories_counter_project/tabs/food_photo.dart';
import 'package:calories_counter_project/tabs/food_select.dart';
import 'package:flutter/material.dart';

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({Key? key}) : super(key: key);

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget>
with SingleTickerProviderStateMixin {

  late TabController tabController;

  @override
  void initState(){
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose(){
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5fb27c),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text("Food"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                height: 7,
              ),
              Container(
                width: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: Color(0xFF5fb27c),
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: TabBar(
                        indicator: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        indicatorWeight: 2,
                        indicatorColor: Colors.white,
                        unselectedLabelColor: Colors.white,
                        labelColor: Color(0xFF5fb27c),
                        controller: tabController,
                        tabs: const [
                          Tab(
                            icon: Icon(Icons.history),
                            text: "Recent",
                          ),
                          Tab(
                            icon: Icon(Icons.add),
                            text: "Record",
                          ),
                          Tab(
                            icon: Icon(Icons.camera_alt_rounded),
                            text: "Camera",
                          ),
                          Tab(
                            icon: Icon(Icons.qr_code_scanner_rounded),
                            text: "Barcode",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    FoodSelect(),
                    FoodSelect(),
                    FoodPhoto(),
                    FoodBarcode()
                  ],
                ),
              )
            ],
          ),
        ),

      ),
    );
  }
}
