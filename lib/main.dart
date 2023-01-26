import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:multi_web_2/view/screens/amazon.dart';
import 'package:multi_web_2/view/screens/hotstar.dart';
import 'package:multi_web_2/view/screens/link.dart';
import 'package:multi_web_2/view/screens/netflix.dart';
import 'package:multi_web_2/view/screens/sony.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
        'hotstar': (context) => const Hotstar(),
        'netflix': (context) => const Netflix(),
        'amazon': (context) => const AmazonPrime(),
        'sony': (context) => const Sony(),
        'link': (context) => const Link(),
      },
    ),
  );
}

class Global {
  static List bookmarkList = [];
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List images = [
    'https://tse4.mm.bing.net/th?id=OIP.1kRGfJjf_nuhX9wZn7r6WQHaEK&pid=Api&P=0',
    'https://tse3.mm.bing.net/th?id=OIP.svzz1qbHxYFMDUxYOha04QHaHa&pid=Api&P=0',
    'https://tse3.mm.bing.net/th?id=OIP.mJ_ixkE6QECCP6L0ZvE3GwHaDt&pid=Api&P=0',
    'https://tse3.mm.bing.net/th?id=OIP.-HIOUULAjr2q87M1j4j0zgHaEK&pid=Api&P=0',
  ];

  int currentPage = 0;
  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Learning websites",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: 55,
              child: TextField(
                onSubmitted: (val){
                  setState((){
                    if(val=="hotstar" || val=="Hotstar"){Navigator.pushNamed(context, 'hotstar');}
                    else if(val=="netflix" || val=="Netflix"){Navigator.pushNamed(context, 'netfilx');}
                    else if(val=="amazon" || val == "Amazon"){Navigator.pushNamed(context, 'amazon');}
                    else if(val=="sony" || val == "Sony"){Navigator.pushNamed(context, 'sony');}
                  });
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.grey.shade400,height: 1),
                  prefixIcon: Icon(Icons.search,color: Colors.grey.shade400),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  enabled: true,
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
          ),
          const Spacer(),
          Container(
            color: Colors.white,
            height: 300,
            child: CarouselSlider(
              carouselController: carouselController,
              items: images
                  .map(
                    (e) => GestureDetector(
                  onTap: () {
                    setState(() {
                      if (images.indexOf(e) == 0) {
                        Navigator.pushNamed(context, 'hotstar');
                      } else if (images.indexOf(e) == 1) {
                        Navigator.pushNamed(context, 'netflix');
                      } else if (images.indexOf(e) == 2) {
                        Navigator.pushNamed(context, 'amazon');
                      } else if (images.indexOf(e) == 3) {
                        Navigator.pushNamed(context, 'sony');
                      }
                    });
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(e, fit: BoxFit.fill),
                  ),
                ),
              )
                  .toList(),
              options: CarouselOptions(
                initialPage: currentPage,
                onPageChanged: (val, _) {
                  setState(() {
                    currentPage = val;
                  });
                },
                enlargeCenterPage: true,
                height: 260,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 100,
            color: Colors.white,
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: images.map(
                    (e) {
                  int i = images.indexOf(e);
                  return GestureDetector(
                    onTap: () {
                      carouselController.animateToPage(
                        i,
                        curve: Curves.easeInOut,
                        duration: const Duration(milliseconds: 500),
                      );
                    },
                    child: CircleAvatar(
                      radius: 5,
                      backgroundColor: (currentPage == i)
                          ? Colors.blue.shade600
                          : Colors.grey.shade400,
                    ),
                  );
                },
              ).toList(),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
