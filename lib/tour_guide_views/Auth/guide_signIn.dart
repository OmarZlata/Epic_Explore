import 'package:epic_expolre/Views/Maps/google_map/view.dart';
import 'package:epic_expolre/Views/Maps/splash/onboarding_3.dart';
import 'package:epic_expolre/Views/auth/SignUp.dart';
import 'package:epic_expolre/Widgets/app_AppBar.dart';
import 'package:epic_expolre/Widgets/app_button.dart';
import 'package:epic_expolre/Widgets/app_text.dart';
import 'package:epic_expolre/Widgets/app_text_field.dart';
import 'package:epic_expolre/Widgets/guide_Nav_Bar.dart';
import 'package:epic_expolre/core/app_colors/app_colors.dart';
import 'package:epic_expolre/cubit/user_cubit.dart';
import 'package:epic_expolre/cubit/user_state.dart';
import 'package:epic_expolre/tour_guide_views/Auth/guide_signUp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuiderSignIn extends StatefulWidget {
  const GuiderSignIn({Key? key}) : super(key: key);

  @override
  State<GuiderSignIn> createState() => _GuiderSignInState();
}

class _GuiderSignInState extends State<GuiderSignIn> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is GuiderSignInSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: AppColors.violet,
                elevation: 1,
                content: Center(
                  child: Text(
                    "Success",
                    style: TextStyle(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            );
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => GuideNavBar(),
            ));
          } else if (state is GuiderSignInFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                elevation: 1,
                backgroundColor: AppColors.violet,
                padding: EdgeInsets.all(8),
                content: Center(
                  child: Text(
                    "E-mail or Password are not correct",
                    style: TextStyle(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppAppBar(
              iconThemeColor: AppColors.violet,
              title: "Sign In",
              centerTitle: true,
              leading: IconButton(
                icon: Icon(CupertinoIcons.back),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GoogleMapSplashView(),
                    ),
                  );
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50),
                    Center(
                      child: Image.asset('assets/images/Welcome2.png'),
                    ),
                    Form(
                      key: context.read<UserCubit>().GuiderSignInFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AppText(
                            title: "Email",
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(height: 10),
                          AppTextField(
                            hint: "Email",
                            radius: 8,
                            icon: Icons.email_outlined,
                            hintFontSize: 12,
                            obscureText: false,
                            maxLines: 1,
                            controller: context.read<UserCubit>().GuiderSignInEmail,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email can't be empty";
                              }
                              final emailRegex = RegExp(
                                  r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                              if (!emailRegex.hasMatch(value)) {
                                return "Invalid email address";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 23),
                          const AppText(
                            title: "Password",
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(height: 10),
                          AppTextField(
                            hint: "Password",
                            radius: 8,
                            icon: Icons.lock_outline,
                            hintFontSize: 12,
                            suffixicon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscurePassword = !obscurePassword;
                                });
                              },
                              icon: Icon(
                                obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: obscurePassword
                                    ? AppColors.grey
                                    : AppColors.blue,
                              ),
                            ),
                            obscureText: obscurePassword,
                            maxLines: 1,
                            controller: context.read<UserCubit>().GuiderSignInPassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 8) {
                                return 'Password must be at least 8 characters long';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    if (state is GuiderSignInLoading)
                      Center(
                        child: CircularProgressIndicator(
                          color: AppColors.violet,
                        ),
                      )
                    else
                      AppButton(
                        width: double.infinity,
                        color: AppColors.violet,
                        font_color: AppColors.white,
                        title: "Sign In",
                        onTap: () {
                          if (context.read<UserCubit>().GuiderSignInFormKey.currentState!.validate()) {
                            context.read<UserCubit>().GuiderLogin();
                          }
                        },
                      ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          title: "Don’t have an Account?  ",
                          color: AppColors.grey,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => GuideSignUp(),
                            ));
                          },
                          child: AppText(
                            title: " SignUp",
                            color: AppColors.violet,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
