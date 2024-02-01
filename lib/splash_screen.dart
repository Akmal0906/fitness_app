import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/presentation/view/sign_up_screen.dart';
import 'package:fitness_app/utils/all_colors.dart';
import 'package:fitness_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final language = ['Uzbek', 'Russian', 'English'];
  String? valueChoose;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SvgPicture.asset(
                'assets/icons/logo.svg',
                width: 72,
                height: 72,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                width: 18,
              ),
              Text(
                AllText.splash,
                style: customStyle.copyWith(
                    fontSize: 36, fontWeight: FontWeight.w600),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 64, left: 65, right: 65),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, left: 12, right: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border:
                          Border.all(width: 1, color: AllColors.borderColor)),
                  child: DropdownButton(
                    isExpanded: true,
                    hint: Text(
                      'Hello bro'.tr(),
                      style: customStyle,
                    ),
                    value: valueChoose,
                    onChanged: (newValue) {
                      setState(() {
                        valueChoose = newValue;
                        final List itemList=['uz','ru','en'];
                        context.setLocale(Locale(itemList[language.indexOf(newValue!)]));


                      });
                    },
                    items: language.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(
                          e,
                          style: customStyle,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                SizedBox(
                  height: 58,
                  width: 52,
                  child: ElevatedButton(
                    onPressed: () {

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()),
                          (route) => false);
                    },
                      style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(12),
                      backgroundColor: AllColors.buttonColor,
                    ),
                     child: const Icon(
                      Icons.arrow_forward_sharp,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
