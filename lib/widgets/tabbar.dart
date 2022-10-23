import 'package:calories_counter_project/tabs/scan_barcode.dart';
import 'package:calories_counter_project/tabs/scan_photo.dart';
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Color(0xFF5fb27c),
        backgroundColor: Colors.white,
        centerTitle: true,
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
                            text: "ถ่ายภาพ",
                          ),
                          Tab(
                            icon: Icon(Icons.qr_code_scanner_rounded),
                            text: "สแกนบาร์โค้ด",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: BouncingScrollPhysics(),
                  controller: tabController,
                  children: [
                    ScanPhoto(),
                    ScanBarcode()
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


