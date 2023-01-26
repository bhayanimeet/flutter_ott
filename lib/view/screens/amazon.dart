import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../../main.dart';

class AmazonPrime extends StatefulWidget {
  const AmazonPrime({Key? key}) : super(key: key);

  @override
  State<AmazonPrime> createState() => _AmazonPrimeState();
}

class _AmazonPrimeState extends State<AmazonPrime> {

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
                      url: Uri.parse('https://www.primevideo.com/?ref_=dvm_pds_amz_in_as_s_b_brand27_mkw_4mEHKPKZ-dc&mrntrk=pcrid_75454108097584_slid__pgrid_1207264149347696_pgeo_163489_x__ptid_kwd-75454277835072:loc-90'),
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
                child: const SingleChildScrollView(scrollDirection: Axis.horizontal,child: Text("https://www.primevideo.com/?ref_=dvm_pds_amz_in_as_s_b_brand27_mkw_4mEHKPKZ-dc&mrntrk=pcrid_75454108097584_slid__pgrid_1207264149347696_pgeo_163489_x__ptid_kwd-75454277835072:loc-90")),
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
            "https://www.primevideo.com/?ref_=dvm_pds_amz_in_as_s_b_brand27_mkw_4mEHKPKZ-dc&mrntrk=pcrid_75454108097584_slid__pgrid_1207264149347696_pgeo_163489_x__ptid_kwd-75454277835072:loc-90",
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