import 'package:api_demo_office2/Modules/CountriesData/countriesdata_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CountriesDataScreen extends StatefulWidget {
  final String? countryName;
  const CountriesDataScreen({Key? key, this.countryName,}) : super(key: key);

  @override
  State<CountriesDataScreen> createState() => _CountriesDataScreenState();
}

class _CountriesDataScreenState extends State<CountriesDataScreen> {
  final CountriesDatacontroller countriesDatacontroller =
  Get.put(CountriesDatacontroller());

  @override
  void initState() {
    // TODO: implement initState
    countriesDatacontroller.getDataApi(widget.countryName!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.countryName.toString()),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        key: countriesDatacontroller.refreshkey,
        onRefresh: ()=> countriesDatacontroller.getDataApi(widget.countryName!),
        child: Obx(() {
          if (countriesDatacontroller.getcountriesData.isNotEmpty) {
            return countriesDatacontroller.isLoading.value ? const Center(child: CircularProgressIndicator(),):
            ListView.builder(
                itemCount: countriesDatacontroller.getcountriesData.length,
                shrinkWrap: true,
                itemBuilder: (context, index,) {
                  return Card(
                    shadowColor: Colors.indigo,
                    elevation: 5,
                    child: ListTile(
                      leading: Text('${1 + index}'),
                      title: Row(
                        children: [
                          Text(countriesDatacontroller.getcountriesData[index].stateProvince.toString()),
                          countriesDatacontroller.getcountriesData[index].stateProvince!.isNotEmpty ?
                          const SizedBox(width: 10,) :
                          const SizedBox(width: 0,),
                          Text(countriesDatacontroller.getcountriesData[index].country.toString()),
                        ],
                      ),
                      subtitle: Text(
                        countriesDatacontroller.getcountriesData[index].name
                            .toString(),
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.lightBlue,
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: () async {
                              if (!await launchUrl(
                                  Uri.parse(countriesDatacontroller
                                      .getcountriesData[index].webPages.first))) {
                                throw Exception(
                                    'Could not launch ${countriesDatacontroller
                                        .getcountriesData[index].country
                                        .toString()}');
                              }
                            },
                            icon: const Icon(
                              Icons.location_pin,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return  const Center(
              child: Text("Data Not Found", style: TextStyle(fontSize: 20,),),
            );
          }
        }),
      ),
    );
  }
}
