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
    tabController = TabController(length: 3, vsync: this);
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
        centerTitle: true,
        title: Text("Food"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  // height: 50,
                  width: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: Colors.green,
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
                          labelColor: Colors.green,
                          controller: tabController,
                          tabs: [
                            Tab(
                              text: "Record",
                            ),
                            Tab(
                              text: "Camera",
                            ),
                            Tab(
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
                    children: [
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
      ),
    );
  }
}
