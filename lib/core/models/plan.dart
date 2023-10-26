class Plan {
  String planID;
  String custId; //foreign key
  String custGender;
  double custHeight;
  double custWeight;
  double custGoalWeight;

  double custReqKcal;
  double custEatenKcal;
  double custburntKcal;

  double custReqProtein;
  double custEatenProtein;
  double custburntProtein;

  double custReqFats;
  double custEatenFats;
  double custBurntFats;

  double custReqCarbs;
  double custEatenCarbs;
  double custBurntCarbs;

  Map<String, dynamic> custExercise;
  Map<String, dynamic> custMeals;

  List diseases;

  Plan({
    this.planID,
    this.custId,
    this.custGender,
    this.custHeight,
    this.custWeight,
    this.custGoalWeight,
    this.custReqKcal,
    this.custEatenKcal,
    this.custburntKcal,
    this.custReqProtein,
    this.custEatenProtein,
    this.custburntProtein,
    this.custReqFats,
    this.custEatenFats,
    this.custBurntFats,
    this.custReqCarbs,
    this.custEatenCarbs,
    this.custBurntCarbs,
    this.custExercise,
    this.custMeals,
    this.diseases,
  });
}
