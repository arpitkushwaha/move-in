import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:move_in/utilities/constants.dart';
import 'package:move_in/views/loginScreen.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  final pageDecoration = PageDecoration(
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontFamily: 'Itim',
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),

    imageAlignment: Alignment.topCenter,
    imagePadding: EdgeInsets.only(top: 40,right: 10,left: 10),
    contentMargin: EdgeInsets.only(top: 20,right: 20,left: 20),
    bodyTextStyle: TextStyle(
      color : Colors.black,
      fontFamily: 'Itim',
      fontSize: 25,
    )
  );

  List<PageViewModel> getPages(){
    return [
      PageViewModel(
        image: Image.asset('assets/images/city.png'),
        title: 'Select Cities',
        body: 'Select the cities and specific areas you wish to compare.',
        decoration: pageDecoration,
      ),
      PageViewModel(
        image: Image.asset('assets/images/compare.png'),
        title: 'Compare Them',
        body: 'Compare the areas based on multiple factors like job rate, cost of living, crime rate etc. ',
        decoration: pageDecoration,

      ),
      PageViewModel(
          image: Image.asset('assets/images/movein.png'),
          title: 'MoveIn',
          body: ' Move In (Collect exciting discounts and rewards on the way)',
        decoration: pageDecoration,
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IntroductionScreen(
          globalBackgroundColor: Color(Constants.introScreenBackgroundColor),
          pages: getPages(),
          done: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              'Done',
              style: TextStyle(
                fontFamily: 'Itim',
                fontSize: 20,
              ),
            ),
          ),
          dotsDecorator: DotsDecorator(
              shape: RoundedRectangleBorder(),
          ),
          isTopSafeArea: true,
          isBottomSafeArea: true,
          curve: Curves.decelerate,
          animationDuration: 10,
          showSkipButton: true,
          skip: const Text(
              'Skip',
            style: TextStyle(
              fontFamily: 'Itim',
              fontSize: 20,
            ),
          ),
          skipColor: Colors.black,
          showNextButton: true,
          next:  const Icon(Icons.arrow_forward),
          nextColor: Colors.black,
          onDone: (){
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
          },
          doneColor: Colors.black,
        ),
      ),
    );
  }
}
