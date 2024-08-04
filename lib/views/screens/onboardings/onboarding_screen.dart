import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:test_p/views/utils/app_extensions/app_extensions.dart';


import '../../../controllers/services/app_storage_services/videos/app_storage_service.dart';
import '../../utils/app_colors/app_colors.dart';
import '../../utils/app_constants/image_constants.dart';
import '../../utils/app_styles/app_styles.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    AppStorageService.getVideosPath();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingSlider(
        headerBackgroundColor: AppColor.black,
        finishButtonText: 'Register',
        pageBackgroundColor: AppColor.black,
        finishButtonStyle: FinishButtonStyle(
          backgroundColor: AppColor.blueAccent,
        ),

        trailing: const Text('Login',style: defaultTextStyle,),

        background: [
         assetImage(path: introImage),
         assetImage(path: introImage),
         assetImage(path: introImage),
        ],
        totalPage: 3,
        speed: 1.8,
        pageBodies: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text('Description Text 1'),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text('Description Text 2'),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text('Description Text 3'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
