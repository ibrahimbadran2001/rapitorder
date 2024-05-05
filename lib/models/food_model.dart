class MealModel{
  final String name;
  final String img;
  final String price;
  MealModel({required this.name,required this.price,required this.img,});
  MealModel.fromJson({required this.name,required this.price,required this.img,});
}
List<MealModel> meals=[
  MealModel(name: 'Meal1', price: '25.00\$', img: 'assets/images/burger.png'),
  MealModel(name: 'Meal2', price: '25.00\$', img: 'assets/images/burger.png'),
  MealModel(name: 'Meal3', price: '25.00\$', img: 'assets/images/burger.png'),
  MealModel(name: 'Meal4', price: '25.00\$', img: 'assets/images/burger.png'),
  MealModel(name: 'Meal5', price: '25.00\$', img: 'assets/images/burger.png'),
  MealModel(name: 'Meal6', price: '25.00\$', img: 'assets/images/burger.png'),
  MealModel(name: 'Meal7', price: '25.00\$', img: 'assets/images/burger.png'),
  MealModel(name: 'Meal8', price: '25.00\$', img: 'assets/images/burger.png'),
  MealModel(name: 'Meal9', price: '25.00\$', img: 'assets/images/burger.png'),
  MealModel(name: 'Meal10', price: '25.00\$', img: 'assets/images/burger.png'),
];