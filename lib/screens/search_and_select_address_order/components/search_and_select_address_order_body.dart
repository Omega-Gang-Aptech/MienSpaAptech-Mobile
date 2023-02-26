// ignore_for_file: prefer_final_fields, library_private_types_in_public_api, prefer_const_constructors, unnecessary_new, unnecessary_null_comparison, non_constant_identifier_names, unused_local_variable, use_build_context_synchronously, prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mien_spa_mobile/models/google_map.dart';
import 'package:mien_spa_mobile/screens/order/order_screen.dart';
import 'package:mien_spa_mobile/theme/constants.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class SearchAndSelectAddressOrderBody extends StatefulWidget {
  const SearchAndSelectAddressOrderBody({Key? key}) : super(key: key);

  @override
  _SearchAndSelectAddressOrderBodyState createState() =>
      _SearchAndSelectAddressOrderBodyState();
}

class _SearchAndSelectAddressOrderBodyState
    extends State<SearchAndSelectAddressOrderBody> {
  var _controller = TextEditingController();
  var uuid = new Uuid();
  String _sessionToken = '';
  List<GoogleMapResponse> _placeList = [];
  final storage = new FlutterSecureStorage();
  String kPLACES_API_KEY = "AIzaSyAk_xhIXIng69bvRBhD1XH1arZbtAXFj30";
  String type = 'vn';

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
    try {
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request =
          '$baseURL?input=$input&key=$kPLACES_API_KEY&components=country:vn&language=$type';
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
                  FocusManager.instance.primaryFocus?.unfocus();
                  var address = _placeList[index].description;
                  await storage.write(key: "order_address", value: address);
                  Navigator.of(context).pop();
                  Navigator.popAndPushNamed(context, OrderScreen.routeName);
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
