import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/model/food_list.dart';

class Details extends StatelessWidget {
  final FoodList food;
  const Details({
    super.key,
    required this.food,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50, left: 15),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xffef2b39),
              borderRadius: BorderRadius.circular(25),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0),

                Image.asset(
                  food.Image,
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 20),

                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    food.Title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    food.Price,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffef2b39)
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    food.Description,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}