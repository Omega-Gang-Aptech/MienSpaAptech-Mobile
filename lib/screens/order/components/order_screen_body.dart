// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new, prefer_final_fields, avoid_unnecessary_containers, sized_box_for_whitespace, use_build_context_synchronously, library_private_types_in_public_api, unused_import, unused_field, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings, sort_child_properties_last, unused_local_variable, non_constant_identifier_names, constant_identifier_names, await_only_futures, unnecessary_null_comparison, prefer_adjacent_string_concatenation, avoid_print, deprecated_member_use

import 'dart:async';
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mien_spa_mobile/api/api_client.dart';
import 'package:mien_spa_mobile/api/base_author_client.dart';
import 'package:mien_spa_mobile/config/size_config.dart';
import 'package:mien_spa_mobile/config/validate.dart';
import 'package:mien_spa_mobile/dto/request/order_product_request.dart';
import 'package:mien_spa_mobile/dto/response/polyline_response.dart';
import 'package:mien_spa_mobile/dto/response/product_response.dart';
import 'package:mien_spa_mobile/dto/response/sign_in_response.dart';
import 'package:mien_spa_mobile/dto/response/user_response.dart';
import 'package:mien_spa_mobile/global_component/default_button.dart';
import 'package:mien_spa_mobile/models/UsePayPal.dart';
import 'package:mien_spa_mobile/models/cart_product.dart';
import 'package:mien_spa_mobile/models/cart_product_list.dart';
import 'package:mien_spa_mobile/models/information_order.dart';
import 'package:mien_spa_mobile/models/item_paypal.dart';
import 'package:mien_spa_mobile/models/location_map.dart';
import 'package:mien_spa_mobile/models/total.dart';
import 'package:mien_spa_mobile/screens/cart_product/cart_product_screen.dart';
import 'package:mien_spa_mobile/screens/cart_product/components/cart_product_body.dart';
import 'package:mien_spa_mobile/screens/main_container/main_container.dart';
import 'package:mien_spa_mobile/screens/order/components/order_product_item.dart';
import 'package:mien_spa_mobile/screens/search_and_select_address_order/search_and_select_address_order_screen.dart';
import 'package:mien_spa_mobile/theme/constants.dart';
import 'package:http/http.dart' as http;
import 'package:mien_spa_mobile/utilities/total_extension.dart';

class OrderScreenBody extends StatefulWidget {
  const OrderScreenBody({Key? key}) : super(key: key);

  @override
  _OrderScreenBodyState createState() => _OrderScreenBodyState();
}

enum SingingCharacter { Payment_on_delivery, Pay_by_Paypal }

class _OrderScreenBodyState extends State<OrderScreenBody> {
  SingingCharacter? _character = SingingCharacter.Payment_on_delivery;
  PolylineResponse polylineResponse = PolylineResponse();
  final storage = new FlutterSecureStorage();
  String kPLACES_API_KEY = "AIzaSyAk_xhIXIng69bvRBhD1XH1arZbtAXFj30";
  List<CartProduct> _cart = [];
  List<ItemPaypal> _itemListPaypal = [];
  final _formKey = GlobalKey<FormState>();
  var checkSign = false;
  late UserRespone user;
  var txtpay;
  var txtName;
  var txtPhone;
  var txtAddress;
  var txtUserId;
  bool _isLoading = true;
  late bool checkName = false;
  late bool checkPhone = false;
  late bool checkAddress = false;
  int ship = 0;
  int countLoad = 0;
  Timer? _timer;
  late String transportFee = "0";
  late int total = 0;
  late String totalConvert = "0";

  @override
  void initState() {
    super.initState();
    checkLogin();
    getTotal();
    getData();
    getItemInCart();
  }

  Future<void> checkLogin() async {
    var data = await storage.read(key: "api_account");
    if (data != null) {
      SignInReponse convertData = signInReponseFromJson(data);
      var respone = await BaseAuthorClient()
          .get('/api/Users/' + convertData.id)
          .catchError((err) {});
      if (respone != null) {
        user = userResponeFromJson(respone);
        setState(
          () {
            txtUserId = user.usId;
            txtName = user.usUserName;
            txtPhone = user.usPhoneNo;
            txtAddress = user.usAddress;
          },
        );
      } else {
        if (countLoad < 4) {
          checkLogin();
          setState(() {
            countLoad++;
          });
        }
      }
    }
    var dataName = await storage.read(key: "order_name");
    var dataAddress = await storage.read(key: "order_address");
    var dataPhone = await storage.read(key: "order_phone");
    if (dataName != null) {
      setState(
        () {
          txtName = dataName;
        },
      );
    }
    if (dataPhone != null) {
      setState(
        () {
          txtPhone = dataPhone;
        },
      );
    }
    if (dataAddress != null) {
      setState(
        () {
          txtAddress = dataAddress;
        },
      );
    }
    getTransportFee();
    delay();
  }

  Future<void> getData() async {
    if (await storage.read(key: "cart") != null) {
      var data = await storage.read(key: "cart");
      List<CartProductList> list = cartProductListFromJson(data!);
      for (var element in list) {
        CartProduct dataCart = CartProduct(
            ordProQuantity: element.ordProQuantity,
            productId: element.productId);
        setState(() {
          _cart.add(dataCart);
        });
      }
    }
  }

  Future<void> getItemInCart() async {
    var dataCart = await storage.read(key: "cart");
    var dataProduct =
        await ApiClient().get("/api/Product").catchError((err) {});
    if (dataProduct != null && dataCart != null) {
      List<CartProductList> listCart = cartProductListFromJson(dataCart);
      List<Product> listProduct = productFromJson(dataProduct);
      for (var itemPro in listProduct) {
        for (var itemCart in listCart) {
          if (itemPro.proId == itemCart.productId) {
            double money = itemPro.proPrice / 23000;
            ItemPaypal itemPaypal = ItemPaypal(
                name: itemPro.proName,
                quantity: itemCart.ordProQuantity.toString(),
                price: money.toStringAsFixed(2));
            setState(() {
              _itemListPaypal.add(itemPaypal);
            });
          }
        }
      }
    }
  }

  Future<void> getTotal() async {
    var data = await storage.read(key: "total");
    if (data != null) {
      setState(() {
        total = int.parse(data);
        Total tal = Total(total: int.parse(data));
        totalConvert = tal.dotPrice();
      });
    }
  }

  Future<void> getTransportFee() async {
    if (txtAddress != null) {
      String urlGetPlaceId =
          'https://maps.googleapis.com/maps/api/place/findplacefromtext/json';
      String requestPlaceId = urlGetPlaceId +
          '?input=' +
          txtAddress +
          '&inputtype=textquery&fields=place_id&key=' +
          kPLACES_API_KEY;
      var resPlaceId = await http.get(Uri.parse(requestPlaceId));
      if (resPlaceId.statusCode == 200) {
        var dataPlaceId =
            json.decode(resPlaceId.body)['candidates'][0]['place_id'];
        String urlGetLocation =
            'https://maps.googleapis.com/maps/api/place/details/json';
        String requestGetLocation = urlGetLocation +
            '?place_id=' +
            dataPlaceId.toString() +
            '&fields=geometry&key=' +
            kPLACES_API_KEY;
        var resGetLocation = await http.get(Uri.parse(requestGetLocation));
        var dataGetLocation =
            json.decode(resGetLocation.body)['result']['geometry']['location'];
        if (resGetLocation.statusCode == 200) {
          LocationMap locationMap =
              locationMapFromJson(jsonEncode(dataGetLocation));
          String urlGetKm =
              'https://maps.googleapis.com/maps/api/directions/json';
          String requestKm = urlGetKm +
              '?key=$kPLACES_API_KEY' +
              '&units=metric&origin=10.796719348500178,106.69185358181596' +
              '&destination=' +
              locationMap.lat.toString() +
              ',' +
              locationMap.lng.toString() +
              '&mode=driving';
          var reskm = await http.get(Uri.parse(requestKm));
          polylineResponse = PolylineResponse.fromJson(jsonDecode(reskm.body));
          int? distance = polylineResponse.routes![0].legs![0].distance!.value;
          double roundingDistance = distance! / 1000;
          ship = int.parse(roundingDistance.round().toString()) * 5000;
          Total convertTransportFee = Total(total: ship);
          total = total + ship;
          Total tal = Total(total: total);
          setState(() {
            totalConvert = tal.dotPrice();
            transportFee = convertTransportFee.dotPrice();
          });
        }
      }
    }
  }

  Future<void> delay() async {
    await Future.delayed(
      Duration(milliseconds: 3000),
      () {
        if (!mounted) {
          return;
        }
        setState(() {
          _isLoading = false;
        });
      },
    );
  }

  Future<void> create(dynamic order) async {
    var reponse = ApiClient().post("/api/OrdersPro", order);
    if (reponse != null) {
      AwesomeDialog(
        context: context,
        animType: AnimType.leftSlide,
        headerAnimationLoop: false,
        dialogType: DialogType.success,
        dismissOnTouchOutside: false,
        dismissOnBackKeyPress: false,
        title: 'Thành Công',
        desc: 'Bạn đã đặt hàng thành công !',
        btnOkOnPress: () async {
          await storage.write(key: "main_container_select", value: "1");
          Navigator.pushReplacementNamed(
            context,
            MainContainer.routeName,
          );
        },
        btnOkIcon: Icons.check_circle,
      ).show();
    } else {
      create(order);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(700),
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (_isLoading) ...[
              Center(
                child: CircularProgressIndicator(
                  color: KPrimaryColor,
                ),
                heightFactor: 16,
              ),
            ] else ...[
              Container(
                height: getProportionateScreenHeight(250),
                child: ListView.builder(
                  itemCount: _cart.length,
                  itemBuilder: (context, index) => OrderProductItem(
                    cart: _cart[index],
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.only(top: 20.0, right: 30.0, left: 30.0),
                  child: Column(
                    children: [
                      NameTextField(
                        txtName,
                      ),
                      PhoneTextField(
                        txtPhone,
                      ),
                      AddressTextField(
                        txtAddress,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: KGray,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: const Text('Thanh toán khi nhận hàng'),
                              leading: Radio<SingingCharacter>(
                                value: SingingCharacter.Payment_on_delivery,
                                groupValue: _character,
                                onChanged: (SingingCharacter? value) {
                                  setState(() {
                                    txtpay = value;
                                    _character = value;
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: const Text('Thanh toán bằng Paypal'),
                              leading: Radio<SingingCharacter>(
                                value: SingingCharacter.Pay_by_Paypal,
                                groupValue: _character,
                                onChanged: (SingingCharacter? value) {
                                  setState(() {
                                    txtpay = value;
                                    _character = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Giảm giá: ",
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            Text(
                              "0%",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Tiền Ship:",
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            Text(
                              transportFee,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Tổng cộng: ",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              totalConvert,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      DefaultButton(
                        text: Text(
                          "Đặt hàng",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        press: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                          }
                          DateTime now =
                              await DateTime.now().subtract(Duration(hours: 7));
                          if (_character ==
                                  SingingCharacter.Payment_on_delivery &&
                              txtName != null &&
                              txtAddress != null &&
                              txtPhone != null) {
                            EasyLoading.showToast(
                              'loading...',
                              duration: Duration(seconds: 30),
                              // _progress,
                              maskType: EasyLoadingMaskType.black,
                              dismissOnTap: true,
                            ).then(
                              (value) async {
                                _timer?.cancel();
                                EasyLoading.dismiss();
                                List<ListProId> listCart = [];
                                for (var element in _cart) {
                                  ListProId pro = ListProId(
                                    ordProQuantity: element.ordProQuantity,
                                    productId: element.productId,
                                  );
                                  listCart.add(pro);
                                }
                                OrderProductRequest order = OrderProductRequest(
                                  createdAt: DateFormat(
                                          'yyyy-MM-dd' + "T" + 'HH:mm:ss')
                                      .format(now),
                                  updatedAt: null,
                                  orProDob: DateFormat(
                                          'yyyy-MM-dd' + "T" + 'HH:mm:ss')
                                      .format(now.add(Duration(days: 5))),
                                  orProPayStatus: "Chưa thanh toán",
                                  orProPayment: "Thanh toán khi nhận hàng",
                                  orProPhoneNo: txtPhone,
                                  orProShip: ship,
                                  orProStatus: "Chờ xác nhận",
                                  orProAddress: txtAddress,
                                  orProTotal: total,
                                  orProUserName: txtName,
                                  orProNote: null,
                                  orProUserId: txtUserId,
                                  listProId: listCart,
                                );
                                AwesomeDialog(
                                  context: context,
                                  animType: AnimType.leftSlide,
                                  headerAnimationLoop: false,
                                  dialogType: DialogType.noHeader,
                                  showCloseIcon: true,
                                  desc: 'Bạn đã xác nhận đơn hàng ?',
                                  btnOkOnPress: () async {
                                    await storage.delete(key: "total");
                                    await storage.delete(key: "cart");
                                    await storage.delete(key: "phone");
                                    await storage.delete(key: "address");
                                    await storage.delete(key: "date_of_birth");
                                    var reponse = ApiClient()
                                        .post("/api/OrdersPro", order);
                                    if (reponse != null) {
                                      AwesomeDialog(
                                        context: context,
                                        animType: AnimType.leftSlide,
                                        headerAnimationLoop: false,
                                        dialogType: DialogType.success,
                                        dismissOnTouchOutside: false,
                                        dismissOnBackKeyPress: false,
                                        title: 'Thành Công',
                                        desc: 'Bạn đã đặt hàng thành công !',
                                        btnOkOnPress: () async {
                                          await storage.write(
                                              key: "main_container_select",
                                              value: "1");
                                          Navigator.pushReplacementNamed(
                                            context,
                                            MainContainer.routeName,
                                          );
                                        },
                                        btnOkIcon: Icons.check_circle,
                                      ).show();
                                    } else {
                                      AwesomeDialog(
                                        context: context,
                                        animType: AnimType.leftSlide,
                                        headerAnimationLoop: false,
                                        dialogType: DialogType.error,
                                        title: 'Đã có lỗi xảy ra',
                                        desc:
                                            'Đặt hàng thất bại xin vui lòng thử lại !',
                                        btnCancelText: "Ok",
                                        btnCancelOnPress: () {},
                                      ).show();
                                    }
                                  },
                                  btnCancelOnPress: () {},
                                  btnCancelText: "Hủy",
                                  btnOkText: "Xác nhận",
                                ).show();
                              },
                            );
                          }

                          if (_character == SingingCharacter.Pay_by_Paypal &&
                              txtName != null &&
                              txtAddress != null &&
                              txtPhone != null) {
                            EasyLoading.showToast(
                              'loading...',
                              duration: Duration(seconds: 30),
                              // _progress,
                              maskType: EasyLoadingMaskType.black,
                              dismissOnTap: true,
                            ).then(
                              (value) async {
                                _timer?.cancel();
                                EasyLoading.dismiss();
                                List<ListProId> listCart = [];
                                for (var element in _cart) {
                                  ListProId pro = ListProId(
                                    ordProQuantity: element.ordProQuantity,
                                    productId: element.productId,
                                  );
                                  listCart.add(pro);
                                }
                                OrderProductRequest order = OrderProductRequest(
                                  createdAt: DateFormat(
                                          'yyyy-MM-dd' + "T" + 'HH:mm:ss')
                                      .format(now),
                                  updatedAt: null,
                                  orProDob: DateFormat(
                                          'yyyy-MM-dd' + "T" + 'HH:mm:ss')
                                      .format(now.add(Duration(days: 5))),
                                  orProPayStatus: "Đã thanh toán",
                                  orProPayment: "Thanh toán bằng paypal",
                                  orProPhoneNo: txtPhone,
                                  orProShip: ship,
                                  orProStatus: "Chờ xác nhận",
                                  orProAddress: txtAddress,
                                  orProTotal: total,
                                  orProUserName: txtName,
                                  orProNote: null,
                                  orProUserId: txtUserId,
                                  listProId: listCart,
                                );
                                AwesomeDialog(
                                  context: context,
                                  animType: AnimType.leftSlide,
                                  headerAnimationLoop: false,
                                  dialogType: DialogType.noHeader,
                                  showCloseIcon: true,
                                  desc: 'Bạn đã xác nhận đơn hàng ?',
                                  btnOkOnPress: () {
                                    double convertShip = ship / 23000;
                                    double converttotal = total / 23000;
                                    double amountTotal =
                                        convertShip + converttotal;
                                    InformationOrder informationOrder =
                                        InformationOrder(
                                      fullName: txtName,
                                      address: txtAddress,
                                      phoneNumber: txtPhone,
                                      shippingDiscountCost: 0,
                                      shippingCost:
                                          convertShip.toStringAsFixed(2),
                                    );
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            UsePaypal(
                                          clientId:
                                              'AVr3gyFtITcWjOoS7-IjEDHnfgjG0SgnY_dbcCsJd7vx-IBxq2dIr6hhN_eMCK36HTlqi0WrkT9tqNg7',
                                          secretKey:
                                              'EKJ1MhQUjEQguQbpFLUDm69nW9Ptb1UndvOcfCM26xz-DlgDvGYkGOA9INv4mgwKxLSv-PyzdTHAveRN',
                                          informationOrder: informationOrder,
                                          items: _itemListPaypal,
                                          transactions_description:
                                              "Thanh toán sản phẩm tại Mien Spa",
                                          returnURL:
                                              "https://samplesite.com/return",
                                          cancelURL:
                                              "https://samplesite.com/cancel",
                                          onSuccess: (Map params) async {
                                            await storage.delete(key: "total");
                                            await storage.delete(key: "cart");
                                            await storage.delete(key: "phone");
                                            await storage.delete(
                                                key: "address");
                                            await storage.delete(
                                                key: "date_of_birth");
                                            create(order);
                                          },
                                          onError: (error) {
                                            // AwesomeDialog(
                                            //   context: context,
                                            //   animType:
                                            //       AnimType.leftSlide,
                                            //   headerAnimationLoop: false,
                                            //   dialogType:
                                            //       DialogType.error,
                                            //   title: 'Đã có lỗi xảy ra',
                                            //   desc:
                                            //       'Đặt hàng thất bại xin vui lòng thử lại !',
                                            //   btnCancelText: "Ok",
                                            //   btnCancelOnPress: () {},
                                            // ).show();
                                          },
                                          onCancel: (params) {
                                            print('cancelled: $params');
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  btnCancelOnPress: () {},
                                  btnCancelText: "Hủy",
                                  btnOkText: "Xác nhận",
                                ).show();
                              },
                            );
                          }
                        },
                        primary: KPrimaryColor,
                        onPrimary: KWhite,
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(100),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Column NameTextField(String? value) {
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.name,
          onChanged: (value) {
            txtName = value;
          },
          validator: (value) {
            if (value!.isEmpty) {
              setState(() {
                checkName = false;
              });
              return KNameNullError;
            } else if (value.length < 5 || value.length > 21) {
              setState(() {
                checkName = false;
              });
              return KNameLengthError;
            } else if (!nameValidatoRegExp.hasMatch(value)) {
              setState(() {
                checkName = false;
              });
              return KInvalidNameError;
            } else {
              txtName = value;
              setState(() {
                checkName = true;
              });
              return null;
            }
          },
          decoration: InputDecoration(
            label: Text("Name"),
            prefixIcon: Icon(
              FontAwesomeIcons.userAlt,
              color: KBlack,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: KWhite,
            floatingLabelStyle: TextStyle(
              color: KBlack,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: KBlack,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          controller: TextEditingController(text: value),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Column PhoneTextField(String? value) {
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.phone,
          onChanged: (value) {
            txtPhone = value;
          },
          validator: (value) {
            if (value!.isEmpty) {
              setState(() {
                txtPhone = value;
                checkPhone = false;
              });
              return KPhoneNullError;
            } else if (!phoneValidatoRegExp.hasMatch(value)) {
              setState(() {
                txtPhone = value;
                checkPhone = false;
              });
              return KInvalidPhoneError;
            } else {
              setState(() {
                txtPhone = value;
                checkPhone = true;
              });
              return null;
            }
          },
          decoration: InputDecoration(
            label: Text("Phone"),
            prefixIcon: Icon(
              FontAwesomeIcons.phone,
              color: KBlack,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: KWhite,
            floatingLabelStyle: TextStyle(
              color: KBlack,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: KBlack,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          controller: TextEditingController(text: value),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Column AddressTextField(String? value) {
    return Column(
      children: [
        TextFormField(
          readOnly: true,
          validator: (value) {
            if (value!.isEmpty) {
              setState(() {
                checkAddress = false;
              });
              return KAddressNullError;
            } else {
              setState(() {
                checkAddress = true;
              });
              return null;
            }
          },
          onTap: () async {
            await storage.write(key: "order_phone", value: txtPhone);
            await storage.write(key: "order_name", value: txtName);
            Navigator.pushNamed(
                context, SearchAndSelectAddressOrderScreen.routeName);
          },
          decoration: InputDecoration(
            label: Text("Address"),
            prefixIcon: Icon(
              FontAwesomeIcons.mapMarkedAlt,
              color: KBlack,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: KWhite,
            floatingLabelStyle: TextStyle(
              color: KBlack,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: KBlack,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          controller: TextEditingController(text: value),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
