import 'package:flash360_news/ui/pages/homepage.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF200505),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
        child: Column(
          children: [
            Container(
              height: 400,
              width: 800,
              child: Center(
                child: Image.asset(
                  "assets/images/logo_lp.png",
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Text(
                "Stay Informed\n   Stay Ahead",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              "  Stay alert with FlashNews, dive into\n                 the latest updates",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 150.0,),
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width/1.2,
                child: Material(
                    borderRadius: BorderRadius.circular(30.0),
                  elevation: 5.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Center(
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          color: Color(0xFF200505),
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
