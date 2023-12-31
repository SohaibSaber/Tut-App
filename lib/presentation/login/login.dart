import 'package:flutter/material.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/presentation/common/state_renderer/state_render_impl.dart';
import 'package:tut_app/presentation/login/login_viewmodel.dart';
import 'package:tut_app/presentation/resources/assets_manager.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/routes_manager.dart';
import 'package:tut_app/presentation/resources/strings_manager.dart';
import 'package:tut_app/presentation/resources/values_manager.dart';


// class LoginView extends StatefulWidget {
//   const LoginView({Key? key}) : super(key: key);
//
//   @override
//   State<LoginView> createState() => _LoginViewState();
// }
//
// class _LoginViewState extends State<LoginView> {
//   LoginViewModel _viewModel = instance<LoginViewModel>();
//
//   TextEditingController _userNameController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//
//   _bind() {
//     _viewModel.start();
//     _userNameController
//         .addListener(() => _viewModel.setUserName(_userNameController.text));
//     _passwordController
//         .addListener(() => _viewModel.setPassword(_passwordController.text));
//
//     _viewModel.isUserLoggedInSuccessfullyStreamController.stream
//         .listen((isSuccessLoggedIn) {
//       // navigate to main screen
//       SchedulerBinding.instance?.addPostFrameCallback((_) {
//         Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
//       });
//     });
//   }
//
//   @override
//   void initState() {
//     _bind();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorManager.white,
//       body: StreamBuilder<FlowState>(
//         stream: _viewModel.outputState,
//         builder: (context, snapshot) {
//           return snapshot.data?.getScreenWidget(context, _getContentWidget(),
//                   () {
//                 _viewModel.login();
//               }) ??
//               _getContentWidget();
//         },
//       ),
//     );
//   }
//
//   Widget _getContentWidget() {
//     return  Container(
//         padding: const EdgeInsets.only(top: AppPadding.p100),
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 const Image(image: AssetImage(ImageAssets.splashLogo)),
//                 const SizedBox(
//                   height: AppSize.s28,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                       left: AppPadding.p28, right: AppPadding.p28),
//                   child: StreamBuilder<bool>(
//                     stream: _viewModel.outputsUserNameValid,
//                     builder: (context, snapshot) {
//                       return TextFormField(
//                         controller: _userNameController,
//                         keyboardType: TextInputType.emailAddress,
//                         decoration: InputDecoration(
//                           hintText: AppStrings.userName,
//                           labelText: AppStrings.userName,
//                           errorText: (snapshot.data ?? true)
//                               ? null
//                               : AppStrings.userNameError,
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 const SizedBox(
//                   height: AppSize.s28,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                       left: AppPadding.p28, right: AppPadding.p28),
//                   child: StreamBuilder<bool>(
//                     stream: _viewModel.outputsPasswordValid,
//                     builder: (context, snapshot) {
//                       return TextFormField(
//                         controller: _passwordController,
//                         keyboardType: TextInputType.visiblePassword,
//                         decoration: InputDecoration(
//                           hintText: AppStrings.password,
//                           labelText: AppStrings.password,
//                           errorText: (snapshot.data ?? true)
//                               ? null
//                               : AppStrings.passwordError,
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 const SizedBox(
//                   height: AppSize.s28,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                       left: AppPadding.p28, right: AppPadding.p28),
//                   child: StreamBuilder<bool>(
//                     stream: _viewModel.outputsIsAllInputsValid,
//                     builder: (context, snapshot) {
//                       return SizedBox(
//                         width: double.infinity,
//                         height: AppSize.s40,
//                         child: ElevatedButton(
//                           onPressed: (snapshot.data ?? false)
//                               ? () {
//                                   _viewModel.login();
//                                 }
//                               : null,
//                           child: const Text(
//                             AppStrings.login,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                     top: AppPadding.p8,
//                     left: AppPadding.p20,
//                     right: AppPadding.p20,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pushReplacementNamed(
//                               context, Routes.forgotPasswordRoute);
//                         },
//                         child: Text(AppStrings.forgetPassword,
//                             style: Theme.of(context).textTheme.titleSmall),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pushReplacementNamed(
//                               context, Routes.registerRoute);
//                         },
//                         child: Text(AppStrings.registerText,
//                             style: Theme.of(context).textTheme.titleSmall),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       );
//   }
//
//   @override
//   void dispose() {
//     _viewModel.dispose();
//     super.dispose();
//   }
// }
class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginViewModel _viewModel = instance<LoginViewModel>();

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _userNameController
        .addListener(() => _viewModel.setUserName(_userNameController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () {
                _viewModel.login();
              }) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Container(
        padding: EdgeInsets.only(top: AppPadding.p100),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image(image: AssetImage(ImageAssets.splashLogo)),
                SizedBox(height: AppSize.s28),
                Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsUserNameValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _userNameController,
                        decoration: InputDecoration(
                            hintText: AppStrings.userName,
                            labelText: AppStrings.userName,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.userNameError),
                      );
                    },
                  ),
                ),
                SizedBox(height: AppSize.s28),
                Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsPasswordValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        decoration: InputDecoration(
                            hintText: AppStrings.password,
                            labelText: AppStrings.password,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.passwordError),
                      );
                    },
                  ),
                ),
                SizedBox(height: AppSize.s28),
                Padding(
                    padding: EdgeInsets.only(
                        left: AppPadding.p28, right: AppPadding.p28),
                    child: StreamBuilder<bool>(
                      stream: _viewModel.outputIsAllInputsValid,
                      builder: (context, snapshot) {
                        return SizedBox(
                          width: double.infinity,
                          height: AppSize.s40,
                          child: ElevatedButton(
                              onPressed: (snapshot.data ?? false)
                                  ? () {
                                _viewModel.login();
                              }
                                  : null,
                              child: Text(AppStrings.login)),
                        );
                      },
                    )),
                Padding(
                  padding: EdgeInsets.only(
                    top: AppPadding.p8,
                    left: AppPadding.p28,
                    right: AppPadding.p28,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, Routes.forgotPasswordRoute);
                        },
                        child: Text(AppStrings.forgetPassword,
                            style: Theme.of(context).textTheme.titleSmall),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, Routes.registerRoute);
                        },
                        child: Text(AppStrings.registerText,
                            style: Theme.of(context).textTheme.titleSmall),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}