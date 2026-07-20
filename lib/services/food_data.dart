import 'package:fooddeliveryapp/model/food_list.dart';

List<FoodList> getFoodData() {
  List<FoodList> foodData = [];

  foodData.add(
    FoodList(
      Image: "assets/images/pizza1.png",
      Title: "Cheese Pizza",
      Price: "\$50",
      Description:
      "A delicious cheese pizza topped with rich mozzarella, fresh herbs, and a crispy golden crust.",
    ),
  );

  foodData.add(
    FoodList(
      Image: "assets/images/pizza2.png",
      Title: "Margherita Pizza",
      Price: "\$40",
      Description:
      "Classic Margherita pizza made with fresh tomatoes, mozzarella cheese, basil leaves, and tomato sauce.",
    ),
  );

  return foodData;
}