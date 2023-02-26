// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables, non_constant_identifier_names, unused_local_variable, unnecessary_import, depend_on_referenced_packages, file_names, unused_field, avoid_print

library flutter_paypal;

import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mien_spa_mobile/models/information_order.dart';
import 'package:mien_spa_mobile/models/item_paypal.dart';
import 'package:mien_spa_mobile/providers/paypal/comple_payment.dart';
import 'package:mien_spa_mobile/screens/errors/network_error.dart';
import 'package:mien_spa_mobile/services/paypal_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UsePaypal extends StatefulWidget {
  final Function onSuccess, onCancel, onError;
  final String returnURL,
      cancelURL,
      note,
      clientId,
      secretKey,
      transactions_description;
  final InformationOrder informationOrder;
  final List<ItemPaypal> items;
  const UsePaypal({
    Key? key,
    required this.clientId,
    required this.secretKey,
    required this.informationOrder,
    required this.transactions_description,
    required this.items,
    required this.returnURL,
    required this.cancelURL,
    required this.onSuccess,
    required this.onError,
    required this.onCancel,
    this.note = "",
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return UsePaypalState();
  }
}

class UsePaypalState extends State<UsePaypal> {
  var checkoutUrl;
  var executeUrl;
  var accessToken;
  String navUrl = '';
  bool loading = true;
  bool pageloading = true;
  bool loadingError = false;
  PaypalServices services = PaypalServices();
  late final WebViewController _controller;
  int pressed = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
    Future.delayed(Duration.zero, () async {
      try {
        Map getToken = await services.getAccessToken();
        if (getToken['token'] != null) {
          accessToken = getToken['token'];
          final transactions = getOrderParams();
          final res =
              await services.createPaypalPayment(transactions, accessToken);
          if (res["approvalUrl"] != null) {
            if (!mounted) {
              return;
            }
            setState(() {
              checkoutUrl = res["approvalUrl"];
              executeUrl = res["executeUrl"];
              navUrl = res["approvalUrl"].toString();
              executeUrl = res["executeUrl"].toString();
              loading = false;
              pageloading = false;
              loadingError = false;
            });
          } else {
            widget.onError(res);
            if (!mounted) {
              return;
            }
            setState(() {
              loading = false;
              pageloading = false;
              loadingError = true;
            });
          }
        } else {
          widget.onError("${getToken['message']}");
          if (!mounted) {
            return;
          }
          setState(() {
            loading = false;
            pageloading = false;
            loadingError = true;
          });
        }
      } catch (e) {
        widget.onError(e);
        if (!mounted) {
          return;
        }
        setState(() {
          loading = false;
          pageloading = false;
          loadingError = true;
        });
      }
    });
  }

  Map getOrderParams() {
    List convertData = [];
    double subTotalAmount = 0.0;
    var totalAmount;
    for (var element in widget.items) {
      convertData.add({
        "name": element.name,
        "quantity": element.quantity,
        "price": element.price,
        "currency": element.currency,
      });
      double totalPro =
          double.parse(element.price) * double.parse(element.quantity);
      subTotalAmount = subTotalAmount + totalPro;
    }
    var cvSubTotal = subTotalAmount.toStringAsFixed(2);
    String check = cvSubTotal
        .toString()
        .substring(cvSubTotal.length - 1, cvSubTotal.length);
    if (check == "0") {
      cvSubTotal = subTotalAmount.toStringAsFixed(1);
    }
    totalAmount = (double.parse(cvSubTotal) +
            double.parse(widget.informationOrder.shippingCost))
        .toString();

    //checkout invoice details
    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": totalAmount.toString(),
            "currency": "USD",
            "details": {
              "subtotal": cvSubTotal.toString(),
              "shipping": widget.informationOrder.shippingCost.toString(),
              "shipping_discount":
                  widget.informationOrder.shippingDiscountCost.toString(),
            }
          },
          "description": widget.transactions_description,
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          "item_list": {
            "items": convertData,
          }
        }
      ],
      if (widget.note != "") "note_to_payer": widget.note,
      "redirect_urls": {
        "return_url": widget.returnURL,
        "cancel_url": widget.cancelURL
      }
    };
    return temp;
  }

  loadPayment() async {
    try {
      Map getToken = await services.getAccessToken();
      if (getToken['token'] != null) {
        accessToken = getToken['token'];
        final transactions = getOrderParams();
        final res =
            await services.createPaypalPayment(transactions, accessToken);
        if (res["approvalUrl"] != null) {
          if (!mounted) {
            return;
          }
          setState(() {
            checkoutUrl = res["approvalUrl"];
            executeUrl = res["executeUrl"];
            navUrl = res["approvalUrl"].toString();
            executeUrl = res["executeUrl"].toString();
            loading = false;
            pageloading = false;
            loadingError = false;
          });
        } else {
          widget.onError(res);
          if (!mounted) {
            return;
          }
          setState(() {
            loading = false;
            pageloading = false;
            loadingError = true;
          });
        }
      } else {
        widget.onError("${getToken['message']}");
        if (!mounted) {
          return;
        }
        setState(() {
          loading = false;
          pageloading = false;
          loadingError = true;
        });
      }
    } catch (e) {
      widget.onError(e);
      if (!mounted) {
        return;
      }
      setState(() {
        loading = false;
        pageloading = false;
        loadingError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (pressed < 2) {
          setState(() {
            pressed++;
          });
          final snackBar = SnackBar(
              content: Text(
                  'Press back ${3 - pressed} more times to cancel transaction'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF272727),
            leading: GestureDetector(
              child: const Icon(Icons.arrow_back_ios),
              onTap: () => Navigator.pop(context),
            ),
            title: Row(
              children: [
                Expanded(
                    child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.lock_outline,
                        color: Uri.parse(navUrl).hasScheme
                            ? Colors.green
                            : Colors.blue,
                        size: 18,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          navUrl,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(width: pageloading ? 5 : 0),
                      pageloading == true
                          ? const SpinKitFadingCube(
                              color: Color(0xFFEB920D),
                              size: 10.0,
                            )
                          : const SizedBox()
                    ],
                  ),
                ))
              ],
            ),
            elevation: 0,
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: loading == true
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
                : loadingError == true
                    ? Column(
                        children: [
                          Expanded(
                            child: Center(
                              child: NetworkError(
                                loadData: loadPayment,
                                message: "Something went wrong,",
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: WebViewWidget(
                              controller: WebViewController()
                                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                                ..setBackgroundColor(const Color(0x00000000))
                                ..setNavigationDelegate(
                                  NavigationDelegate(
                                    onProgress: (int progress) {},
                                    onPageStarted: (String url) {
                                      pageloading = true;
                                      loadingError = false;
                                    },
                                    onPageFinished: (String url) {
                                      navUrl = url;
                                      pageloading = false;
                                    },
                                    onWebResourceError:
                                        (WebResourceError error) {
                                      print('''
                                        Page resource error:
                                          code: ${error.errorCode}
                                          description: ${error.description}
                                          errorType: ${error.errorType}
                                          isForMainFrame: ${error.isForMainFrame}
                                      ''');
                                    },
                                    onNavigationRequest:
                                        (NavigationRequest request) {
                                      if (request.url
                                          .contains(widget.returnURL)) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CompletePayment(
                                                      url: request.url,
                                                      services: services,
                                                      executeUrl: executeUrl,
                                                      accessToken: accessToken,
                                                      onSuccess:
                                                          widget.onSuccess,
                                                      onCancel: widget.onCancel,
                                                      onError: widget.onError)),
                                        );
                                      }
                                      if (request.url
                                          .contains(widget.cancelURL)) {
                                        final uri = Uri.parse(request.url);
                                        widget.onCancel(uri.queryParameters);
                                        Navigator.of(context).pop();
                                      }
                                      return NavigationDecision.navigate;
                                    },
                                  ),
                                )
                                ..addJavaScriptChannel(
                                  'Toaster',
                                  onMessageReceived:
                                      (JavaScriptMessage message) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message.message)),
                                    );
                                  },
                                )
                                ..loadRequest(
                                  Uri.parse(checkoutUrl),
                                ),
                            ),
                          ),
                        ],
                      ),
          )),
    );
  }
}
