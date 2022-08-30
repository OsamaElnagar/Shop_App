import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/screens/login.dart';
import 'package:shop_app/shared/network/remote/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../shared/styles/colors.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/OB.jpg',
      title: 'On Boarding 1 Title',
      body: 'On Boarding 1 Body',
    ),
    BoardingModel(
      image: 'assets/images/OIP.jpg',
      title: 'On Boarding 2 Title',
      body: 'On Boarding 2 Body',
    ),
    BoardingModel(
      image: 'assets/images/OIP (1).jpg',
      title: 'On Boarding 3 Title',
      body: 'On Boarding 3 Body',
    ),
  ];

  var boardController = PageController();
  bool isLast = false;

  void submit() {
    CacheHelper.saveLoginData('onBoarding', true).then((value) {
      if (value) {
        navigate2(
          context,
           ShopLogin(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20.0,
              top: 20.0,
            ),
            child: ElevatedButton(
              onPressed: () {
                submit();
              },
              child: Text(
                'Skip'.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                physics: const BouncingScrollPhysics(),
                scrollBehavior: const ScrollBehavior(),
                itemBuilder: (context, index) {
                  //required parameter
                  return buildBoardingItem(boarding[index]);
                },
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemCount: boarding.length, //required parameter
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: myColor,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,
                  ),
                  count: boarding.length,
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                          duration: const Duration(
                            milliseconds: 450,
                          ),
                          curve: Curves.fastOutSlowIn);
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(model.image),
          ),
        ),
        Text(
          model.title,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Text(
          model.body,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
