import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';

class FoodMenueViewModel extends BaseViewModel {
  String extractedChefName(List<ChefData> _allChefsData, String chefID) {
    String _chefName;
    for (int i = 0; i < _allChefsData.length; i++) {
      if (_allChefsData[i].chefID == chefID) {
        _chefName = _allChefsData[i].chefName;
      }
    }
    return _chefName;
  }
}
