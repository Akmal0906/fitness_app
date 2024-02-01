import 'package:fitness_app/presentation/view/sign_up_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/user_model.dart';
import '../../domain/textfield_model.dart';
import '../../utils/all_colors.dart';
import '../../utils/constants.dart';
import '../blocs/register_bloc.dart';
import 'map_screen.dart';
import 'my_textfield.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController userNameController;
  final TextEditingController password1Controller = TextEditingController();

  List list = [];

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
    list = [
      TextFieldModel(
          controller: userNameController,
          isNeed: false,
          hintText: AllText.username,
          obscureText: false),
      TextFieldModel(
          controller: password1Controller,
          isNeed: true,
          hintText: AllText.password,
          obscureText: true),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var _pageSize = MediaQuery.of(context).size.height;
    var _notifySize = MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<RegisterBloc, RegisterState>(
          builder: (BuildContext context, state) {
            if (state is RegisterInitial) {
              return SingleChildScrollView(
                child: SizedBox(
                  height: _pageSize - (_notifySize),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 54, right: 54, top: 4),
                        child: Image.asset(
                          'assets/images/signup.png',
                          height: 150,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: 2,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return MyTextFieldWidget(
                            model: list[index],
                            text: textList[index],
                          );
                        },
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.read<RegisterBloc>().add(LoginEvent(
                                    firstname: userNameController.text.trim(),
                                    password: password1Controller.text.trim()));
                              },
                              child: Container(
                                height: 37,
                                width: size.width,
                                margin:
                                    const EdgeInsets.only(left: 24, right: 24),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    gradient: const LinearGradient(colors: [
                                      AllColors.linearColor1,
                                      AllColors.linearColor2
                                    ])),
                                child: Text(
                                  AllText.signIn,
                                  style:
                                      customStyle.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 32.0),
                              child: Row(
                                children: [
                                  Text(
                                    'do you have an account ?',
                                    style: customStyle.copyWith(
                                        color: Colors.grey.shade400,
                                        letterSpacing: 1),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SignUpScreen()));
                                      },
                                      child: Text(
                                        'Sign Up',
                                        style: customStyle.copyWith(
                                            color: Colors.blueAccent.shade400,
                                            letterSpacing: 0.5,
                                            fontSize: 16),
                                      )),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (state is LoadingState) {
              return const Center(
                child: CupertinoActivityIndicator(
                  radius: 18,
                  color: Colors.black54,
                  animating: true,
                ),
              );
            } else if (state is ErrorState) {
              return Center(
                child: Text(
                  state.error,
                  style: customStyle,
                ),
              );
            } else if (state is RegisterSuccessState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const MapScreen()),
                    (route) => false);
              });
            }
            return const SizedBox.shrink();
          },
          listener: (BuildContext context, Object? state) {},
        ),
      ),
    );
  }
}
