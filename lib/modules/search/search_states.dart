abstract class SearchStates {}
class GetSearchInitialState extends SearchStates{}
class GetSearchSuccessState extends SearchStates{}
class GetSearchLoadingState extends SearchStates{}
class GetSearchErrorState extends SearchStates{
  GetSearchErrorState(String error);
}