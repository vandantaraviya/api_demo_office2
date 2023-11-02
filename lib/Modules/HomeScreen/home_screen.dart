import 'package:api_demo_office2/Modules/CountriesData/countriesdata_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);
  final Homecontroller homescreencontroller =
      Get.put(Homecontroller());

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        key: homescreencontroller.refreshkey,
        onRefresh: () => homescreencontroller.countriesData(),
        child: Obx(() {
          if (homescreencontroller.getcountriesData.isNotEmpty) {
            return ListView.builder(
                itemExtent: 80,
                itemCount: homescreencontroller.getcountriesData.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    shadowColor: Colors.indigo,
                    elevation: 5,
                    child: ListTile(
                      onTap: () => Get.to(CountriesDataScreen(
                        countryName: homescreencontroller
                            .getcountriesData[index]
                            .toString(),
                      )),
                      leading: Text('${1 + index}'),
                      title: Text(homescreencontroller.getcountriesData[index]
                          .toString()),
                    ),
                  );
                });
          } else {
            return  Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                   Text("Countriesdata Not Found", style: TextStyle(fontSize: 20,),),
                   SizedBox(height: 10,),
                   CircularProgressIndicator(),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
