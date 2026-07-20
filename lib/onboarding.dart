import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/home.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<StatefulWidget> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20.0),
          SizedBox(
            child: Image.asset("assets/images/onboard.png", fit: BoxFit.cover),
          ),
          SizedBox(height: 20.0),
          Text(
            "The Fastest \nFood Delivery",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.0),
          Text(
            "Craving something delicious?\nOrder now and get your favourites\n delivered fast!",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black54,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40.0),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                color: Color(0xff8c592a),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
