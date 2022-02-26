import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../screens/country_statistics.dart';
import '../screens/country_loading.dart';

import '../services/covid_service.dart';

import '../models/country_summary.dart';
import '../models/country.dart';

CovidService covidService = CovidService();

class Country extends StatefulWidget {
  @override
  _CountryState createState() => _CountryState();
}

class _CountryState extends State<Country> {
  final TextEditingController _typeAheadController = TextEditingController();
  late Future<List<CountryModel>> countryList;
  late Future<CountrySummaryModel> summaryList;

  @override
  initState() {
    super.initState();

    countryList = covidService.getCountryList();

    this._typeAheadController.text = "Viet Nam";
    summaryList = covidService.getCountrySummary("vietnam");
  }

  List<String> _getSuggestions(List<CountryModel> list, String query) {
    List<String> matches = [];

    for (var item in list) {
      matches.add(item.country);
    }

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: countryList,
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return Center(
            child: Text("Error"),
          );
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const CircularProgressIndicator();
          default:
            return !snapshot.hasData
                ? Center(
                    child: Text("Empty"),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                        child: Text(
                          "Type the country name",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      TypeAheadFormField(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: this._typeAheadController,
                          decoration: InputDecoration(
                            hintText: 'Type here country name',
                            hintStyle: TextStyle(fontSize: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                            contentPadding: EdgeInsets.all(20),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 24.0, right: 16.0),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                        suggestionsCallback: (pattern) {
                          return _getSuggestions(
                              snapshot.data as List<CountryModel>, pattern);
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion as String),
                          );
                        },
                        transitionBuilder:
                            (context, suggestionsBox, controller) {
                          return suggestionsBox;
                        },
                        onSuggestionSelected: (suggestion) {
                          this._typeAheadController.text = suggestion as String;
                          setState(() {
                            summaryList = covidService.getCountrySummary(
                              (snapshot.data as List<CountryModel>).firstWhere((element) => element.country == suggestion).slug);
                          });
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      FutureBuilder(
                        future: summaryList,
                        builder: (context, snapshot) {
                          if (snapshot.hasError)
                            return Center(
                              child: Text("Error"),
                            );
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Center(child: Text('load'),);
                            default:
                              return !snapshot.hasData
                                  ? Center(
                                      child: Text("Empty"),
                                    )
                                  : CountryStatistics(
                                      summaryList: snapshot.data
                                          as CountrySummaryModel,
                                    );
                                  // :Center(child: Text('data'),);
                          }
                        },
                      ),
                    ],
                  );
        }
      },
    );
  }
}
