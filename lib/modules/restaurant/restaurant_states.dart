import '../../models/restaurant_detail_model.dart';

abstract class RestaurantStates {}
class RestaurantInitialState extends RestaurantStates{}
class RestaurantGetFoodSuccessState extends RestaurantStates{}
class RestaurantGetFoodLoadingState extends RestaurantStates{}
class RestaurantGetFoodErrorState extends RestaurantStates{
  RestaurantGetFoodErrorState(String error);
}
class GetRestaurantsDetailSuccessState extends RestaurantStates {
  final RestaurantItemDetailModel restaurantItemDetailModel;
  GetRestaurantsDetailSuccessState(this.restaurantItemDetailModel);
}
class GetRestaurantsDetailLoadingState extends RestaurantStates {}
class GetRestaurantsDetailErrorState extends RestaurantStates {
  GetRestaurantsDetailErrorState(String error);
}
class GetRestaurantsFoodSuccessState extends RestaurantStates {}
class GetRestaurantsFoodLoadingState extends RestaurantStates {}
class GetRestaurantsFoodErrorState extends RestaurantStates {
  GetRestaurantsFoodErrorState(String error);
}
class NewsGetMoveLoadingState extends RestaurantStates{}
class NewsLoadedState extends RestaurantStates{}
class NewsMovingState extends RestaurantStates{}
class ClearFavoriteFoodState extends RestaurantStates{}