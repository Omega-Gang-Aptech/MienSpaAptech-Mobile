// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages, prefer_final_fields, prefer_const_constructors, unnecessary_new, use_build_context_synchronously, non_constant_identifier_names, unused_local_variable, unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mien_spa_mobile/models/google_map.dart';
import 'package:mien_spa_mobile/models/location_map.dart';
import 'package:mien_spa_mobile/screens/profile/profile_screen.dart';
import 'package:mien_spa_mobile/theme/constants.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class SearchAndSelectBody extends StatefulWidget {
  const SearchAndSelectBody({Key? key}) : super(key: key);

  @override
  _SearchAndSelectBodyState createState() => _SearchAndSelectBodyState();
}

class _SearchAndSelectBodyState extends State<SearchAndSelectBody> {
  var _controller = TextEditingController();
  var uuid = new Uuid();
  String _sessionToken = '';
  List<GoogleMapResponse> _placeList = [];
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _onChanged();
    });
  }

  _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    String kPLACES_API_KEY = "AIzaSyAk_xhIXIng69bvRBhD1XH1arZbtAXFj30";
    String type = 'vn';

    try {
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request =
          '$baseURL?input=$input&key=$kPLACES_API_KEY&components=country:vn&language=vn';
      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body)['predictions'];
      if (response.statusCode == 200) {
        setState(() {
          _placeList = googleMapResponseFromJson(jsonEncode(data));
          // (response.body)['predictions']
        });
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      // toastMessage('success');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: "Tìm kiếm vị trí của bạn ở đây",
              focusColor: Colors.white,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              floatingLabelStyle: TextStyle(
                color: KBlack,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: KBlack,
                ),
              ),
              prefixIcon: Icon(
                Icons.map,
                color: KBlack,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.cancel,
                  color: KBlack,
                ),
                onPressed: () {
                  _controller.clear();
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _placeList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  var address = _placeList[index].description;
                  String baseURL =
                      'https://maps.googleapis.com/maps/api/place/details/json';
                  String request =
                      '$baseURL?place_id=${_placeList[index].placeId}&key=AIzaSyAk_xhIXIng69bvRBhD1XH1arZbtAXFj30';
                  var response = await http.get(Uri.parse(request));
                  var data = json.decode(response.body)['result']['geometry']
                      ['location'];
                  if (response.statusCode == 200) {
                    LocationMap locationMap =
                        locationMapFromJson(jsonEncode(data));
                  }
                  await storage.write(key: "address", value: address);
                  Navigator.of(context).pop();
                  Navigator.popAndPushNamed(context, ProfileScreen.routeName);
                },
                child: ListTile(
                  title: Text(_placeList[index].description),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
