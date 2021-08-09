import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:move_in/utilities/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String countryValue = "India";
  String stateValue = "";
  String cityValue = "";
  String address = "";
  Map<String, String> cityStateMap = new Map<String, String>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.menu),
                    Row(
                      children: [
                        Icon(
                          Icons.my_location,
                          size: 20,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Location',
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                    Icon(Icons.settings),
                  ],
                ),
              ),
            ),
            preferredSize: Size.fromHeight(100),
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 40, bottom: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Hello User,',
                          style: TextStyle(
                            fontFamily: 'Itim',
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Where do ',
                          style: TextStyle(
                            fontFamily: 'Itim',
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Row(
                        children: [
                          Text(
                            'you wanna move?',
                            style: TextStyle(
                              fontFamily: 'Itim',
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 40,
                    ),

                    CSCPicker(
                      ///Enable disable state dropdown
                      showStates: true,

                      /// Enable disable city drop down
                      showCities: true,

                      ///Enable (get flat with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only)
                      flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,

                      ///triggers once country selected in dropdown
                      onCountryChanged: (value) {
                        setState(() {
                          ///store value in country variable
                          countryValue = value;
                        });
                      },

                      ///triggers once state selected in dropdown
                      onStateChanged: (value) {
                        setState(() {
                          ///store value in state variable
                          stateValue = value;
                        });
                      },

                      ///triggers once city selected in dropdown
                      onCityChanged: (value) {
                        setState(() {
                          ///store value in city variable
                          cityValue = value;
                        });
                      },
                    ),

                    ///print newly selected country state and city in Text Widget
                    TextButton(
                        onPressed: () {
                          setState(() {
                            if (cityValue != null && stateValue != null) {
                              address =
                                  "$cityValue, $stateValue, $countryValue";
                              cityStateMap[cityValue] = stateValue;
                            }
                          });
                        },
                        child: Text("Add City")),

                    SizedBox(
                      height: 10,
                    ),

                    ListView.builder(
                        itemCount: cityStateMap.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                              leading: Icon(Icons.circle, color: Colors.green,),
                              trailing: TextButton(
                                onPressed: () {
                                  setState(() {
                                    cityStateMap.remove(
                                        cityStateMap.keys.toList()[index]);
                                  });
                                },
                                child: Icon(Icons.clear, color: Colors.red,size: 24,),
                                // child: Text(
                                //   "Remove",
                                //   style: TextStyle(
                                //       color: Colors.red, fontSize: 15),
                                // ),
                              ),
                              title: Text(
                                  "${cityStateMap.keys.toList()[index]}, ${cityStateMap.values.toList()[index]}, India"));
                        }),

                    _buildCompareBtn(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompareBtn() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {

          Navigator.pushNamed(context, Constants.compareCitiesScreenRoute, arguments: cityStateMap);

        },
        padding: EdgeInsets.only(top: 12, left: 30, right: 30, bottom: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.black,
        child: Text(
          'Compare',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Itim',
          ),
        ),
      ),
    );
  }
}
