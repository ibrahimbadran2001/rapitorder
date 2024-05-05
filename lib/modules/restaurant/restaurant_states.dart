abstract class RestaurantStates {}
class RestaurantInitialState extends RestaurantStates{}
class RestaurantGetFoodSuccessState extends RestaurantStates{}
class RestaurantGetFoodLoadingState extends RestaurantStates{}
class RestaurantGetFoodErrorState extends RestaurantStates{
  RestaurantGetFoodErrorState(String error);
}

class NewsGetMoveLoadingState extends RestaurantStates{}
class NewsLoadedState extends RestaurantStates{}
class NewsMovingState extends RestaurantStates{}
class ClearFavoriteFoodState extends RestaurantStates{}