import 'dart:convert';
import 'package:api_demo_office2/Model/countriesdata_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class Homecontroller extends GetxController{
  RxBool isLoading = false.obs;
  var getcountriesData = [].obs;
  final GlobalKey<RefreshIndicatorState> refreshkey = GlobalKey<RefreshIndicatorState>();

  @override
  void onInit() {
    countriesData();
    super.onInit();
  }

  countriesData() async {
    try{
      isLoading.value = true;
      getcountriesData.clear();
      var url = Uri.parse("https://api.first.org/data/v1/countries");
      final response =
          await http.get(url, headers: {"Content-Type": "application/json"});
      CountryDataModel countryData = CountryDataModel.fromJson(jsonDecode(response.body));
      for (var element in countryData.data.values) {
        getcountriesData.add(element.country);
      }
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }finally{
      isLoading.value = true;
    }
    update();
  }
}