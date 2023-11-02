import 'dart:convert';
import 'package:api_demo_office2/Model/data_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CountriesDatacontroller extends GetxController{
  final GlobalKey<RefreshIndicatorState> refreshkey = GlobalKey<RefreshIndicatorState>();
  RxBool isLoading = false.obs;
  var getcountriesData = <Datamodel>[].obs;

   getDataApi(String country) async {
    try {
      isLoading.value = true;
      getcountriesData.clear();
      final response = await http.get(Uri.parse('http://universities.hipolabs.com/search?country=$country'));
      final datamodel =  json.decode(response.body).cast<Map<String, dynamic>>();
       getcountriesData.value = datamodel.map<Datamodel>((json)=> Datamodel.fromJson(json)).toList();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }finally{
      isLoading.value = false;
    }
  }
}