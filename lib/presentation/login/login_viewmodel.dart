import 'dart:async';
import 'package:tut_app/domain/usecase/login_usecase.dart';
import 'package:tut_app/presentation/base/baseviewmodel.dart';
import 'package:tut_app/presentation/common/freezed_data.dart';
import 'package:tut_app/presentation/common/state_renderer/state_render_impl.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';

// class LoginViewModel extends BaseViewModel
//     with LoginViewModelInputs, LoginViewModelOutputs {
//   final StreamController _userNameStreamController =
//       StreamController<String>.broadcast();
//   final StreamController _passwordStreamController =
//       StreamController<String>.broadcast();
//
//   final StreamController _isAllInputsValidStreamController =
//       StreamController<void>.broadcast();
//
//   StreamController isUserLoggedInSuccessfullyStreamController = StreamController<
//       bool>();
//
//   var loginObject = LoginObject("", "");
//
//   LoginUseCase _loginUseCase;
//
//   LoginViewModel(this._loginUseCase);
//
//   @override
//   void dispose() {
//     _userNameStreamController.close();
//     _passwordStreamController.close();
//     _isAllInputsValidStreamController.close();
//     isUserLoggedInSuccessfullyStreamController.close();
//   }
//
//   @override
//   void start() {
//     inputState.add(ContentState());
//   }
//
//   @override
//   Sink get inputPassword => _passwordStreamController.sink;
//
//   @override
//   Sink get inputUserName => _userNameStreamController.sink;
//
//   @override
//   // TODO: implement inputIsAllInputsValid
//   Sink get inputIsAllInputsValid => _isAllInputsValidStreamController.sink;
//
//   @override
//   login() async {
//     inputState.add(
//         LoadingState(stateRendererType: StateRendererType.popUpLoadingState));
//     (await _loginUseCase.execute(
//             LoginUseCaseInput(loginObject.userName, loginObject.password)))
//         .fold((failure) => {
//           inputState.add(ErrorState(StateRendererType.popUpErrorState, failure.message))
//     },
//             (data){
//
//           inputState.add(ContentState());
//
//           // navigate to main screen after the login
//           isUserLoggedInSuccessfullyStreamController.add(true);
//
//         });
//   }
//
//   @override
//   setPassword(String password) {
//     inputPassword.add(password);
//     loginObject = loginObject.copyWith(password: password);
//     _validate();
//   }
//
//   @override
//   setUserName(String userName) {
//     inputUserName.add(userName);
//     loginObject = loginObject.copyWith(userName: userName);
//     _validate();
//   }
//
//   @override
//   // TODO: implement outputsPasswordValid
//   Stream<bool> get outputsPasswordValid => _passwordStreamController.stream
//       .map((password) => _isPasswordValid(password));
//
//   @override
//   // TODO: implement outputsUserNameValid
//   Stream<bool> get outputsUserNameValid => _userNameStreamController.stream
//       .map((userName) => _isUserNameValid(userName));
//
//   @override
//   // TODO: implement outputsIsAllInputsValid
//   Stream<bool> get outputsIsAllInputsValid =>
//       _isAllInputsValidStreamController.stream.map((_) => _isAllInputsValid());
//
//   _validate() {
//     inputIsAllInputsValid.add(null);
//   }
//
//   bool _isPasswordValid(String password) {
//     return password.isNotEmpty;
//   }
//
//   bool _isUserNameValid(String userName) {
//     return userName.isNotEmpty;
//   }
//
//   bool _isAllInputsValid() {
//     return _isPasswordValid(loginObject.password) &&
//         _isUserNameValid(loginObject.userName);
//   }
// }
//
// abstract class LoginViewModelInputs {
//   setUserName(String userName);
//
//   setPassword(String password);
//
//   login();
//
//   Sink get inputUserName;
//
//   Sink get inputPassword;
//
//   Sink get inputIsAllInputsValid;
// }
//
// abstract class LoginViewModelOutputs {
//   Stream<bool> get outputsUserNameValid;
//
//   Stream<bool> get outputsPasswordValid;
//
//   Stream<bool> get outputsIsAllInputsValid;
// }
class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();

  var loginObject = LoginObject("", "");

  LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  // inputs
  @override
  void dispose() {
    _userNameStreamController.close();
    _isAllInputsValidStreamController.close();
    _passwordStreamController.close();
  }

  @override
  void start() {
    // view tells state renderer, please show the content of the screen
    inputState.add(ContentState());
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputIsAllInputValid => _isAllInputsValidStreamController.sink;

  @override
  login() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState));
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.userName, loginObject.password)))
        .fold(
            (failure) => {
          // left -> failure
          inputState.add(ErrorState(
              StateRendererType.popUpErrorState, failure.message))
        },
            (data) => {
          // right -> success (data)
          inputState.add(ContentState())

          // navigate to main screen after the login
        });
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(
        password: password); // data class operation same as kotlin
    _validate();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(
        userName: userName); // data class operation same as kotlin
    _validate();
  }

  // outputs
  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _isAllInputsValid());

  // private functions

  _validate() {
    inputIsAllInputValid.add(null);
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  bool _isAllInputsValid() {
    return _isPasswordValid(loginObject.password) &&
        _isUserNameValid(loginObject.userName);
  }
}

abstract class LoginViewModelInputs {
  // three functions for actions
  setUserName(String userName);

  setPassword(String password);

  login();

// two sinks for streams
  Sink get inputUserName;

  Sink get inputPassword;

  Sink get inputIsAllInputValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;

  Stream<bool> get outputIsPasswordValid;

  Stream<bool> get outputIsAllInputsValid;
}
