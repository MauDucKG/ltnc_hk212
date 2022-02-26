import 'package:flutter/material.dart';
import 'package:ltnc_app_1/screens/country.dart';
import 'package:ltnc_app_1/screens/global.dart';
import 'package:ltnc_app_1/screens/vietnam.dart';
import '../utils/constants.dart';
import '../screens/navigation_option.dart';

enum NavigationStatus {
  GLOBAL,
  COUNTRY,
  VIETNAM,
}

class Tracker extends StatefulWidget {
  const Tracker({ Key? key }) : super(key: key);

  @override
  _TrackerState createState() => _TrackerState();
}

class _TrackerState extends State<Tracker> {
  NavigationStatus navigationStatus = NavigationStatus.COUNTRY;
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: Text(
          "Covid-19 Tracker Live Data"
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                // borderRadius: BorderRadius.only(
                //   bottomLeft: Radius.circular(50),
                //   bottomRight: Radius.circular(50)
                // )
              ),

              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 250),
                child: navigationStatus == NavigationStatus.GLOBAL ? Global() : (navigationStatus == NavigationStatus.VIETNAM) ? Vietnam() : Country(),
              ),
            ),

          ),

          Container(
            height: size.height* 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                NavigationOption(
                  title: "Global",
                  selected: navigationStatus == NavigationStatus.GLOBAL,
                  onSelected: () {
                    setState(() {
                      navigationStatus = NavigationStatus.GLOBAL;
                    });
                  },
                ),

                NavigationOption(
                  title: "Country",
                  selected: navigationStatus == NavigationStatus.COUNTRY,
                  onSelected: () {
                    setState(() {
                      navigationStatus = NavigationStatus.COUNTRY;
                    });
                  },
                ),

                NavigationOption(
                  title: "VietNam",
                  selected: navigationStatus == NavigationStatus.VIETNAM,
                  onSelected: () {
                    setState(() {
                      navigationStatus = NavigationStatus.VIETNAM;
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}