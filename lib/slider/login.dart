import 'package:flutter/material.dart';
import 'package:hermeslogistics/auth/login.dart';
import 'package:hermeslogistics/screens/home.dart';
import 'package:introduction_screen/introduction_screen.dart';



class Splash extends StatelessWidget {


  List<PageViewModel> getPages(){
    return [
      PageViewModel(
          decoration: PageDecoration(
              boxDecoration: BoxDecoration (
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage ('assets/schedule.png'),
                  fit: BoxFit.fitWidth,
                ),
              )
          ),
          titleWidget: Padding(
            padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
            child: Text(''
                'Pick Up',
              style: TextStyle(color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 50),
            ),
          ),
          bodyWidget:
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 340, 0, 0),
            child: Text ('Schedule a Pick Up that is convenient for you',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 25,
              ),),
          )


      ),
      PageViewModel(
          decoration: PageDecoration(
              boxDecoration: BoxDecoration (
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage ('assets/track.png'),
                  fit: BoxFit.fitWidth,
                ),
              )
          ),
          titleWidget: Padding(
            padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
            child: Text(''
                'Pick Up',
              style: TextStyle(color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 50),
            ),
          ),
          bodyWidget:
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 340, 0, 0),
            child: Text ('Track your package to your Doorstep',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 25,
              ),),
          )


      ),

      PageViewModel(
          decoration: PageDecoration(
              boxDecoration: BoxDecoration (
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage ('assets/customer.png'),
                  fit: BoxFit.fitWidth,
                ),
              )
          ),
          titleWidget: Padding(
            padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
            child: Text(''
                'Pick Up',
              style: TextStyle(color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 50),
            ),
          ),
          bodyWidget:
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 340, 0, 0),
            child: Text ('24-hour Customer service to assist you',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 25,
              ),),
          )


      ),


    ];

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: getPages(),
        done: FlatButton(
          onPressed: () {
            return Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyHomePage()));
          },

          hoverColor: Colors.orangeAccent,
          color: Colors.black,
          splashColor: Colors.black,
          child: Text(
            'Get Started',
          style: TextStyle(
            color: Colors.white,
            fontSize: 11
          ),),


        ) ,



        onDone: (){
          return Navigator.push(context,
              MaterialPageRoute(builder: (context) => MyHomePage()));
        },
        skip: Text('Skip',
          style: TextStyle(
              color: Colors.black,
              fontSize: 25
          ),),
        showSkipButton: true,
        showNextButton: true,
        next:  Icon(
          Icons.arrow_forward,
          color: Colors.black,
          size: 30,
        ),


      ),
    );
  }
}
