import 'package:fooddeliveryapp/model/category_model.dart';

List<CategoryModel> getCategories() {
List<CategoryModel> categories = [];

  // Pizza
  CategoryModel categoryModel = CategoryModel(
    image: "assets/images/pizza.png",
    title: "Pizza",
  );
  categories.add(categoryModel);

  // Burger
  categoryModel = CategoryModel(
    image: "assets/images/burger.png",
    title: "Burger",
  );
  categories.add(categoryModel);

  // Chinese
  categoryModel = CategoryModel(
    image: "assets/images/chinese.png",
    title: "Chinese",
  );
  categories.add(categoryModel);

  // Tacos
  categoryModel = CategoryModel(
    image: "assets/images/tacos.png",
    title: "Tacos",
  );
  categories.add(categoryModel);

  return categories;
}
