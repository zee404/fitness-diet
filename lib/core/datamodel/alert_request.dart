import 'package:fitness_diet/core/enums/dialogTypes.dart';

class AlertRequest {
  final String title;
  final String description;
  final String buttonTitle;
  Dialog_Types dialogType;

  AlertRequest({
    this.title,
    this.description,
    this.buttonTitle,
    this.dialogType,
  });
}
