import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shareed_todo/core/constants/app_decoration.dart';
import 'package:shareed_todo/core/constants/app_images.dart';
import 'package:shareed_todo/core/constants/app_style.dart';
import 'package:shareed_todo/core/constants/color_constants.dart';
import 'package:shareed_todo/core/widgets/custom_button.dart';
import 'package:shareed_todo/core/widgets/custom_image_view.dart';
import 'package:shareed_todo/core/widgets/custom_text.dart';
import 'package:shareed_todo/presentation/view_model/onboarding_provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  final List<OnboardingData> data = [
    OnboardingData(
        svgImagePath: AppImages.onboard1,
        title: "Your convenience in making a todo list",
        description:
            '''Here's a mobile platform that helps you create task or to list so that it can help you in every job easier and faster.'''),
    OnboardingData(
        svgImagePath: AppImages.onboard2,
        title: "Find the practicality in making your todo list",
        description:
            "Easy-to-understand user interface  that makes you more comfortable when you want to create a task or to do list, Todyapp can also improve productivity"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(height: 50.h),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {},
                  child: CustomText(
                    "Skip",
                    style: AppStyle.s16medium,
                  )),
            ),
            SizedBox(height: 32.h),
            Expanded(
              child: PageView.builder(
                itemCount: data.length,
                controller: _pageController,
                onPageChanged: (value) {
                  context.read<OnboardingProvider>().updateCurrentPage(value);
                },
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      CustomImageView(
                        svgPath: data[index].svgImagePath,
                        // width: 1.sw,
                      ),
                      Positioned(
                        top: 270.h,
                        child: SizedBox(
                          width: 1.sw - 48.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomText(
                                data[index].title,
                                style: AppStyle.s26medium
                                    .copyWith(color: AppColors.neutralPrimary),
                                maxLines: 5,
                              ),
                              SizedBox(height: 16.h),
                              CustomText(
                                data[index].description,
                                style: AppStyle.s14regular.copyWith(
                                    color: AppColors.neutralSecondary),
                                maxLines: 8,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 8.h,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Consumer<OnboardingProvider>(
                      builder: (context, provider, child) {
                        return Container(
                          width: index == provider.currentPage ? 29.w : 12.w,
                          margin: EdgeInsets.symmetric(horizontal: 4.5.w),
                          decoration: BoxDecoration(
                              color: index == provider.currentPage
                                  ? AppColors.brandPrimaryDefault
                                  : AppColors.brandPrimaryLine,
                              borderRadius: BorderRadius.circular(6.r)),
                        );
                      },
                    );
                  }),
            ),
            SizedBox(
              height: 50.h,
            ),
            Consumer<OnboardingProvider>(builder: (context, provider, child) {
              return CustomElevatedButton(
                text: "Continue",
                onTap: () {
                  if (_pageController.page == data.length - 1) {
                    // next page
                  } else {
                    _pageController.animateToPage(
                        _pageController.page!.toInt() + 1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  }
                },
                backgroundColor: AppColors.brandPrimaryDefault,
                borderRadius: BorderRadiusStyle.roundedBorder16,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                textStyle: AppStyle.s18medium.copyWith(color: AppColors.white),
              );
            }),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}

class OnboardingData {
  final String svgImagePath;
  final String title;
  final String description;

  OnboardingData(
      {required this.svgImagePath,
      required this.title,
      required this.description});
}
