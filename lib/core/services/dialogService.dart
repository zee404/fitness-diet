import 'dart:async';

import 'package:fitness_diet/core/datamodel/alert_request.dart';
import 'package:fitness_diet/core/datamodel/alert_response.dart';
import 'package:fitness_diet/core/enums/dialogTypes.dart';

class DialogService {
  Function(AlertRequest) _showDialogListener;
  Completer<AlertResponse> _dialogCompleter;

  void registerDialogListener(Function(AlertRequest) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  Future<AlertResponse> showDialog({
    String title,
    String description,
    String buttonTitle,
    Dialog_Types dialogType,
  }) {
    _dialogCompleter = Completer<AlertResponse>();

    _showDialogListener(AlertRequest(
      title: title,
      description: description,
      buttonTitle: buttonTitle,
      dialogType: dialogType,
    ));
    return _dialogCompleter.future;
  }

  void dialogComplete(AlertResponse response) {
    _dialogCompleter.complete(response);
    _dialogCompleter = null;
  }
}
