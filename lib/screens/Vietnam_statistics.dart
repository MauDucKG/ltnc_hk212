import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../utils/constants.dart';
import 'package:intl/intl.dart';

import '../models/Vietnam_summary.dart';

class VietnamStatistics extends StatelessWidget {

  final VietnamSummaryModel summary;

  VietnamStatistics({required this.summary});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        buildCard(
          "CONFIRMED", 
          summary.totalConfirmed,
          summary.newConfirmed,
          kConfirmedColor
        ),

        buildCard1(
          "DEATH", 
          summary.totalDeaths,
          kDeathColor
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: Text(
            "Statistics updated " + DateFormat('dd-MM-yyyy').format(summary.date),

            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),

      ],
    );
  }

  Widget buildCard(String title, int totalCount, int todayCount, Color color){
    return Card(
      elevation: 1,
      child: Container(
        height: 100,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: <Widget>[

            Text(
              title,
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),

            Expanded(
              child: Container(),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Text(
                      "Total",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),

                    Text(
                      totalCount.toString().replaceAllMapped(reg, (match) => '${match[1]}.'),
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),

                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[

                    Text(
                      "Today",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),

                    Text(
                      todayCount.toString().replaceAllMapped(reg, (match) => '${match[1]}.'),
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),

                  ],
                ),

                
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard1(String title, int totalCount, Color color){
    return Card(
      elevation: 1,
      child: Container(
        height: 100,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: <Widget>[

            Text(
              title,
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),

            Expanded(
              child: Container(),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    Text(
                      "Total",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),

                    Text(
                      totalCount.toString().replaceAllMapped(reg, (match) => '${match[1]}.'),
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),

                  ],
                )
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}