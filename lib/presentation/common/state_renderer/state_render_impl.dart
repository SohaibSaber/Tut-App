import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/data/mapper/mapper.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app/presentation/resources/strings_manager.dart';

// abstract class FlowState {
//   StateRendererType getStateRendererType();
//
//   String getMessage();
// }
//
// // loading state popUp or fullscreen
// class LoadingState extends FlowState {
//   StateRendererType stateRendererType;
//   String message;
//
//   LoadingState({required this.stateRendererType, String? message})
//       : message = message ?? AppStrings.loading;
//
//   @override
//   String getMessage() => message;
//
//   @override
//   StateRendererType getStateRendererType() => stateRendererType;
// }
//
// // error state popUp or fullscreen
// class ErrorState extends FlowState {
//   StateRendererType stateRendererType;
//   String message;
//
//   ErrorState(this.stateRendererType, this.message);
//
//   @override
//   String getMessage() => message;
//
//   @override
//   StateRendererType getStateRendererType() => stateRendererType;
// }
//
// // content state popUp or fullscreen
//
// class ContentState extends FlowState {
//   ContentState();
//
//   @override
//   String getMessage() => EMPTY;
//
//   @override
//   StateRendererType getStateRendererType() =>
//       StateRendererType.contentScreenState;
// }
// // empty state popUp or fullscreen
//
// class EmptyState extends FlowState {
//   String message;
//
//   EmptyState(this.message);
//
//   @override
//   String getMessage() => message;
//
//   @override
//   StateRendererType getStateRendererType() =>
//       StateRendererType.emptyScreenState;
// }
//
// extension FlowStateExtension on FlowState {
//   Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
//       Function retryActionFunction) {
//     switch (this.runtimeType) {
//       case LoadingState:
//         {
//           if (getStateRendererType() == StateRendererType.popUpLoadingState) {
//             showPopUP(context, getStateRendererType(), getMessage());
//             return contentScreenWidget;
//           } else {
//             return StateRenderer(
//                 stateRendererType: getStateRendererType(),
//                 message: getMessage(),
//                 retryActionFunction: retryActionFunction);
//           }
//         }
//       case ErrorState:
//         {
//           dismissDialog(context);
//           if (getStateRendererType() == StateRendererType.popUpErrorState) {
//             showPopUP(context, getStateRendererType(), getMessage());
//             return contentScreenWidget;
//           } else {
//             return StateRenderer(
//                 stateRendererType: getStateRendererType(),
//                 message: getMessage(),
//                 retryActionFunction: retryActionFunction);
//           }
//         }
//       case ContentState:
//         {
//           dismissDialog(context);
//           return contentScreenWidget;
//         }
//       case EmptyState:
//         {
//           return StateRenderer(
//               stateRendererType: getStateRendererType(),
//               message: getMessage(),
//               retryActionFunction: retryActionFunction);
//         }
//       default:
//         {
//           return contentScreenWidget;
//         }
//     }
//   }
//
//   dismissDialog(BuildContext context){
//     if (_isThereCurrentDialogShowing(context)){
//       Navigator.of(context,rootNavigator: true).pop(true);
//     }
//   }
//
//   _isThereCurrentDialogShowing(BuildContext context) =>
//       ModalRoute.of(context)?.isCurrent != true;
//
//
//   showPopUP(BuildContext context, StateRendererType stateRendererType,
//       String message) {
//     WidgetsBinding.instance?.addPostFrameCallback((_) => showDialog(
//         context: context,
//         builder: (BuildContext context) => StateRenderer(
//               stateRendererType: stateRendererType,
//               message: message,
//               retryActionFunction: () {},
//             )));
//   }
// }
abstract class FlowState {
  StateRendererType getStateRendererType();

  String getMessage();
}

// Loading State (POPUP, FULL SCREEN)

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  LoadingState({required this.stateRendererType, String? message})
      : message = message ?? AppStrings.loading;

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// error state (POPUP, FULL LOADING)
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// CONTENT STATE

class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => EMPTY;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.contentScreenState;
}

// EMPTY STATE

class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.emptyScreenState;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (this.runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.popUpLoadingState) {
            // showing popup dialog
            showPopUp(context, getStateRendererType(), getMessage());
            // return the content ui of the screen
            return contentScreenWidget;
          } else // StateRendererType.FULL_SCREEN_LOADING_STATE
              {
            return StateRenderer(
                stateRendererType: getStateRendererType(),
                message: getMessage(),
                retryActionFunction: retryActionFunction);
          }
        }
      case ErrorState:
        {
          dismissDialog(context);
          if (getStateRendererType() == StateRendererType.popUpErrorState) {
            // showing popup dialog
            showPopUp(context, getStateRendererType(), getMessage());
            // return the content ui of the screen
            return contentScreenWidget;
          } else // StateRendererType.FULL_SCREEN_ERROR_STATE
              {
            return StateRenderer(
                stateRendererType: getStateRendererType(),
                message: getMessage(),
                retryActionFunction: retryActionFunction);
          }
        }
      case ContentState:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
      case EmptyState:
        {
          return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction);
        }
      default:
        {
          return contentScreenWidget;
        }
    }
  }

  dismissDialog(BuildContext context) {
    if (_isThereCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  showPopUp(BuildContext context, StateRendererType stateRendererType,
      String message) {
    WidgetsBinding.instance?.addPostFrameCallback((_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
          stateRendererType: stateRendererType,
          message: message,
          retryActionFunction: () {},
        )));
  }
}