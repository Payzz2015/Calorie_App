import 'package:calories_counter_project/forms/FormBarcode.dart';
import 'package:calories_counter_project/forms/FormFood.dart';
import 'package:calories_counter_project/tabs/food_barcode.dart';
import 'package:calories_counter_project/tabs/food_select.dart';
import 'package:flutter/material.dart';

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({Key? key}) : super(key: key);

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget>
with SingleTickerProviderStateMixin
{

  late TabController tabController;

  @override
  void initState(){
    tabController = TabController(length: 2, vsync: this);
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
        backgroundColor: const Color(0xFF5fb27c),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text("อาหาร",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if(tabController.index == 0){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return const FormFood();
                }));
              }
              if(tabController.index == 1){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return const FormBarcode();
                }));
              }
            },
            icon: const Icon(
              Icons.add,
              size: 28,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: const Color(0xFF5fb27c),
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TabBar(
                        indicator: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        indicatorWeight: 2,
                        indicatorColor: Colors.white,
                        unselectedLabelColor: Colors.white,
                        labelColor: const Color(0xFF5fb27c),
                        controller: tabController,
                        tabs: const [
                          Tab(
                            icon: Icon(Icons.add),
                            text: "เพิ่มอาหาร",
                          ),
                          Tab(
                            icon: Icon(Icons.qr_code_scanner_rounded),
                            text: "บาร์โค้ด",
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
