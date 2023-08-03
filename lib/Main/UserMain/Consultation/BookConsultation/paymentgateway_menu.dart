import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentGatewayWebView extends StatefulWidget {
  const PaymentGatewayWebView({Key? key, required this.urlWebsite})
      : super(key: key);
  final String urlWebsite;

  @override
  State<PaymentGatewayWebView> createState() => _PaymentGatewayWebViewState();
}

class _PaymentGatewayWebViewState extends State<PaymentGatewayWebView> {
  late final WebViewController controller;
  bool isLoad = true;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(widget.urlWebsite));
    setState(() {
      isLoad = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_circle_left_rounded,
              size: 30,
              color: Color(0xFFFF4DCCC1),
            )),
        title: Text(
          'Pembayaran',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: isLoad
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : WebViewWidget(
              controller: controller,
            ),
    );
  }
}
