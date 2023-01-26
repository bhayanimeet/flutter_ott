import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../../main.dart';

class Netflix extends StatefulWidget {
  const Netflix({Key? key}) : super(key: key);

  @override
  State<Netflix> createState() => _NetflixState();
}

class _NetflixState extends State<Netflix> {

  late InAppWebViewController inAppWebViewController;
  late PullToRefreshController pullToRefreshController;

  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(color: Colors.blue),
      onRefresh: () async {
        await inAppWebViewController.reload();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Colors.white,
        flexibleSpace: Container(
          margin: const EdgeInsets.only(top: 40,bottom: 20),
          child: Row(
            children: [
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () async {
                  await inAppWebViewController.loadUrl(
                    urlRequest: URLRequest(
                      url: Uri.parse('https://media.netflix.com/en/'),
                    ),
                  );
                },
                child: const Icon(Icons.home,size: 30),
              ),
              const SizedBox(width: 10),
              Container(
                height:35,
                width: 180,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const SingleChildScrollView(scrollDirection: Axis.horizontal,child: Text("https://media.netflix.com/en/")),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () async {
                  await inAppWebViewController.goBack();
                },
                child: const Icon(Icons.arrow_back,size: 30),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () async {
                  await inAppWebViewController.goForward();
                },
                child: const Icon(Icons.arrow_forward,size: 30),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () async {
                  await inAppWebViewController.reload();
                },
                child: const Icon(Icons.refresh,size: 30),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
        elevation: 0,
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse(
            "https://media.netflix.com/en/",
          ),
        ),
        onWebViewCreated: (controller) {
          setState(() {
            inAppWebViewController = controller;
          });
        },
        pullToRefreshController: pullToRefreshController,
        onLoadStart: (controller, url) async {
          await pullToRefreshController.endRefreshing();
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              Uri? uri = await inAppWebViewController.getUrl();
              String url = uri.toString();
              Global.bookmarkList.add(url);
            },
            child: const Icon(Icons.bookmark_add),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, 'link', arguments: Global.bookmarkList);
            },
            child: const Icon(Icons.bookmark),
          ),
        ],
      ),
    );
  }
}