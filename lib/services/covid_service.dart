import 'dart:convert';
import 'package:html/parser.dart' as html_parser;
import 'package:http/http.dart' as http;

import '../models/global_summary.dart';
import '../models/country_summary.dart';
import '../models/country.dart';
import '../models/Vietnam.dart';
import '../models/Vietnam_summary.dart';

class CovidService {
  Future<GlobalSummaryModel> getGlobalSummary() async {
    final data = await http.Client().get(Uri.parse("https://api.covid19api.com/summary"));

    if (data.statusCode != 200) throw Exception();

    GlobalSummaryModel summary =
        new GlobalSummaryModel.fromJson(json.decode(data.body));

    return summary;
  }

  Future<CountrySummaryModel> getCountrySummary(String slug) async {
    final data = await http.Client().get(Uri.parse("https://api.covid19api.com/summary"));

    if (data.statusCode != 200) throw Exception();

    CountrySummaryModel summaryList =
        new CountrySummaryModel.fromJson(json.decode(data.body), slug);

    return summaryList;
  }

  Future<List<CountryModel>> getCountryList() async {
    final data =
        await http.Client().get(Uri.parse("https://api.covid19api.com/countries"));

    if (data.statusCode != 200) throw Exception();

    List<CountryModel> countries = (json.decode(data.body) as List)
        .map((item) => new CountryModel.fromJson(item))
        .toList();

    return countries;
  }

  Future<List<VietnamModel>> getVietnamList() async {

    final response = await http.get(Uri.parse(
        "https://suckhoedoisong.vn/chi-tiet-ca-mac-covid-19-hom-nay-o-cac-tinh-thanh-169210830224629655.htm"));
    final document = html_parser.parse(response.body);

    if (response.statusCode != 200) throw Exception();

    final results = document.querySelectorAll('tr');
    List<VietnamModel> countries = [];

    for (final result in results) {
      String a = result.querySelector('th')!.text;
      VietnamModel? moi = new VietnamModel(a, '', '');
      countries.add(moi);
    }

    // List<VietnamModel> countries = (results as List).each((element) {element = new VietnamModel("Vietnam", "", "");});

    // return countries;
  
    return countries;
  }

  Future<VietnamSummaryModel> getVietnamSummary(String slug) async {
    final response = await http.get(Uri.parse(
        "https://suckhoedoisong.vn/chi-tiet-ca-mac-covid-19-hom-nay-o-cac-tinh-thanh-169210830224629655.htm"));
    final document = html_parser.parse(response.body);

    if (response.statusCode != 200) throw Exception();

    final results = document.querySelectorAll('tr');
    List<VietnamModel> countries = [];

    // for (final result in results) {
    //   String a = result.querySelector('th')!.text;
    //   VietnamModel? moi = new VietnamModel(a, '', '');
    //   countries.add(moi);
    // }

    for (final result in results) {
       String a = result.querySelector('th')!.text.trim();
      //  print(slug.length); 
       
      if(a == slug) {
      int tong = sangint(result.querySelectorAll('p')[0].text);
      int homnay = sangint(result.querySelectorAll('p')[1].text);
      int chot = sangint(result.querySelectorAll('p')[2].text);
      // int tong = 1;
      // int homnay = 1;
      // int chot = 1;

        VietnamSummaryModel moine = new VietnamSummaryModel(homnay, tong, 1, chot, 1, 1, DateTime.now());
        return moine;
      }
    }

    VietnamSummaryModel a = new VietnamSummaryModel(1, 1, 1, 1, 1, 1, DateTime.now());
    // List<VietnamModel> countries = (results as List).each((element) {element = new VietnamModel("Vietnam", "", "");});

    // return countries;
    return a;
  }
}

sangint (String a) {
  int dem = 0;
  for(int i = 0 ; i < a.length ; i++)
  {
    if(a[i] == '.') dem = i;
  }

  String b = a.substring(0, dem) + a.substring(dem + 1);
  if(dem == 0) b = a;

  return int.parse(b);
}
