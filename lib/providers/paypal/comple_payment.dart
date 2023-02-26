// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, library_private_types_in_public_api, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mien_spa_mobile/config/size_config.dart';
import 'package:mien_spa_mobile/screens/errors/network_error.dart';
import 'package:mien_spa_mobile/services/paypal_service.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class CompletePayment extends StatefulWidget {
  final Function onSuccess, onCancel, onError;
  final PaypalServices services;
  final String url, executeUrl, accessToken;
  const CompletePayment({
    Key? key,
    required this.onSuccess,
    required this.onError,
    required this.onCancel,
    required this.services,
    required this.url,
    required this.executeUrl,
    required this.accessToken,
  }) : super(key: key);

  @override
  _CompletePaymentState createState() => _CompletePaymentState();
}

class _CompletePaymentState extends State<CompletePayment> {
  bool loading = true;
  bool loadingError = false;

  complete() async {
    final uri = Uri.parse(widget.url);
    final payerID = uri.queryParameters['PayerID'];
    if (payerID != null) {
      Map params = {
        "payerID": payerID,
        "paymentId": uri.queryParameters['paymentId'],
        "token": uri.queryParameters['token'],
      };
      setState(() {
        loading = true;
        loadingError = false;
      });

      Map resp = await widget.services
          .executePayment(widget.executeUrl, payerID, widget.accessToken);
      if (resp['error'] == false) {
        params['status'] = 'success';
        params['data'] = resp['data'];
        setState(() {
          loading = false;
          loadingError = false;
        });
        Navigator.of(context).pop();
        await widget.onSuccess(params);
      } else {
        if (resp['exception'] != null && resp['exception'] == true) {
          widget.onError({"message": resp['message']});
          setState(() {
            loading = false;
            loadingError = true;
          });
        } else {
          Navigator.pop(context);
          await widget.onError(resp['data']);
        }
      }
      //return NavigationDecision.prevent;
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    complete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: loading
            ? Column(
                children: const [
                  Expanded(
                    child: Center(
                      child: SpinKitFadingCube(
                        color: Color(0xFFEB920D),
                        size: 30.0,
                      ),
                    ),
                  ),
                ],
              )
            : loadingError
                ? Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: NetworkError(
                              loadData: complete,
                              message: "Something went wrong,"),
                        ),
                      ),
                    ],
                  )
                : Container(
                    margin: EdgeInsets.only(
                      left: getProportionateScreenWidth(65),
                      top: getProportionateScreenHeight(200),
                      right: getProportionateScreenWidth(65),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/payment-success.png",
                          height: SizeConfig.screenHeight * 0.3,
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.04,
                        ),
                        Text(
                          "Payment Success",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(30),
                            fontWeight: FontWeight.bold,
                            color: KGreeen,
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
