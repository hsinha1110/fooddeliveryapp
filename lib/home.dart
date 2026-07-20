import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/model/category_model.dart';
import 'package:fooddeliveryapp/model/food_list.dart';
import 'package:fooddeliveryapp/services/category_data.dart';
import 'package:fooddeliveryapp/services/details.dart';
import 'package:fooddeliveryapp/services/food_data.dart' hide getCategories;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];
  List<FoodList> foodList = [];
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    categories = getCategories();
    foodList = getFoodData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("assets/images/logo.png", width: 100),
                      const SizedBox(height: 4),
                      const Text(
                        "Order your favourite food!",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/images/boy.jpg",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFececf8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: "Search food item ....",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Color(0xffef2b39),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.search, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: selectedIndex == index
                              ? const Color(0xffef2b39)
                              : const Color(0xFFececf8),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              categories[index].image!,
                              width: 30,
                              height: 30,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              categories[index].title!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: selectedIndex == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 30.0),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: foodList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.78,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Details(
                              food: foodList[index],
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  foodList[index].Image,
                                  height: 110,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  foodList[index].Title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  foodList[index].Price,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 70,
                              height: 30,
                              decoration: const BoxDecoration(
                                color: Color(0xffef2b39),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                              child: const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: foodList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.78,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Details(
                              food: foodList[index],
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  foodList[index].Image,
                                  height: 110,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  foodList[index].Title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  foodList[index].Price,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 70,
                              height: 30,
                              decoration: const BoxDecoration(
                                color: Color(0xffef2b39),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                              child: const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
