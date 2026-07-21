import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/home.dart';
import 'package:fooddeliveryapp/order.dart';
import 'package:fooddeliveryapp/profile.dart';
import 'package:fooddeliveryapp/wallet.dart';


class BottomNav extends StatefulWidget {

  const BottomNav({super.key});

  @override
  State<StatefulWidget> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final List<Widget> pages = [
    const Home(),
    const Order(),
    const Wallet(),
    const Profile(),
  ];
  late Home home;
  late Order order;
  late Wallet wallet;
  late Profile profile;


  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 70,
        backgroundColor: Colors.white,
        color: Colors.black,
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          Icon(Icons.home_outlined, color: Colors.white, size: 25.0),
          Icon(Icons.shopping_bag, color: Colors.white, size: 25.0),
          Icon(Icons.wallet, color: Colors.white, size: 25.0),
          Icon(Icons.person, color: Colors.white, size: 25.0),

        ],
      ),
      body: pages[currentIndex],
    );
  }
}
