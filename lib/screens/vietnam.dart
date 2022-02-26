import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../screens/Vietnam_statistics.dart';
import '../screens/country_loading.dart';

import '../services/covid_service.dart';

import '../models/Vietnam_summary.dart';
import '../models/Vietnam.dart';

CovidService covidService = CovidService();

class Vietnam extends StatefulWidget {
  @override
  _VietnamState createState() => _VietnamState();
}

class _VietnamState extends State<Vietnam> {
  final TextEditingController _typeAheadController = TextEditingController();
  late Future<List<VietnamModel>> vietnamList;
  late Future<VietnamSummaryModel> summaryList;

  @override
  initState() {
    super.initState();

    vietnamList = covidService.getVietnamList();

    this._typeAheadController.text = "Kiên Giang";
    summaryList = covidService.getVietnamSummary("Kiên Giang");
  }


  List<String> _getSuggestions(List<VietnamModel> list, String query) {
    List<String> matches = [];

    for (var item in list) {
      matches.add(item.Vietnam);
    }
    

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: vietnamList,
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return Center(
            child: Text("Error"),
          );
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const CircularProgressIndicator();
          // VietnamLoading(
          //     // inputTextLoading: true
          //     );
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
                          "Tên tỉnh",
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
                            hintText: 'Tên tỉnh',
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
                              snapshot.data as List<VietnamModel>, pattern);
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
                            summaryList = covidService.getVietnamSummary(
                                suggestion.trim());
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
                              return const CircularProgressIndicator();
                            default:
                              return !snapshot.hasData
                                  ? Center(
                                      child: Text("Empty"),
                                    )
                                  : VietnamStatistics(
                                      summary: snapshot.data
                                          as VietnamSummaryModel,
                                    );

                                  
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
