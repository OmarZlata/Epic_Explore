import 'package:dio/dio.dart';
import 'package:epic_expolre/cache/cache_helper.dart';
import 'package:epic_expolre/core/api/api_consumer.dart';
import 'package:epic_expolre/core/api/const_end_ponits.dart';
import 'package:epic_expolre/core/errors/exceptions.dart';
import 'package:epic_expolre/core/models/guider_models/guider_data.dart';
import 'package:epic_expolre/core/models/guider_models/guider_signIn_model.dart';
import 'package:epic_expolre/core/models/guider_models/guider_signUp_data.dart';
import 'package:epic_expolre/core/models/guider_models/guider_signUp_data.dart';
import 'package:epic_expolre/core/models/guider_models/guider_signUp_data.dart';

import 'package:epic_expolre/core/models/user_models/sign_in_model.dart';
import 'package:epic_expolre/core/models/user_models/sign_up_model.dart';
import 'package:epic_expolre/core/models/user_models/verification_model.dart';

import 'package:epic_expolre/cubit/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';

import '../core/models/guider_models/guider_signUp_data.dart';
import '../core/models/guider_models/guider_signUp_data.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.api) : super(UserInitial());
  final ApiConsumer api;
  GlobalKey<FormState> resstPasswordFormKey = GlobalKey();
  GlobalKey<FormState> GuiderSignInFormKey = GlobalKey();
  TextEditingController OtpPhoneController = TextEditingController();

  GlobalKey<FormState> GuiderSignUpFormKey = GlobalKey();
  GlobalKey<FormState> GuiderSignUpFormKeyNew = GlobalKey();
  GlobalKey<FormState> paymentFormKey = GlobalKey();
  GlobalKey<FormState> ForgetPasswordFormKey = GlobalKey();
  GlobalKey<FormState> VerificationFormkey = GlobalKey();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();
  TextEditingController StateGuiderDescriptionController =
      TextEditingController();

  //Sign in email
  TextEditingController signInEmail = TextEditingController();

  TextEditingController GuiderSignInEmail = TextEditingController();
  final DescriptionController = TextEditingController();

  TextEditingController GuiderSignInPassword = TextEditingController();

  TextEditingController GuiderSignUpName = TextEditingController();
  TextEditingController GuiderSignUpEmail = TextEditingController();
  TextEditingController GuiderSignUpPassword = TextEditingController();
  TextEditingController GuiderConfirmPassword = TextEditingController();
  TextEditingController GuiderPhoneNumber = TextEditingController();
  TextEditingController GuiderNationalId = TextEditingController();
  TextEditingController otp = TextEditingController();
  TextEditingController resetPasswordEmail = TextEditingController();

  //Sign in password
  TextEditingController signInPassword = TextEditingController();

  //Sign up name
  TextEditingController signUpName = TextEditingController();
  TextEditingController signUpEmail = TextEditingController();

  //Sign up password
  TextEditingController signUpPassword = TextEditingController();

  //Sign up confirm password
  TextEditingController confirmPassword = TextEditingController();
  SignInModel? user;
  GuiderSignInModel? GuiderSignIn;
  TourGuiderSignUpModel? GuiderSignUpModel;
  VerificationModel? verificationModel;
  GuiderAllData? GuiderData;


  signUp() async {
    emit(SignUpLoading());
    try {

      final response = await api.post(
        EndPoint.register,
        isFromData: true,
        data: {
          ApiKey.name: signUpName.text,
          ApiKey.email: signUpEmail.text,
          ApiKey.password: signUpPassword.text,
          ApiKey.confirmPassword: confirmPassword.text,
        },
      );
      final signUPModel = SignUpModel.fromJson(response);
      // // CacheHelper().saveData(key: ApiKey.token, value: user!.token);
      // CacheHelper().saveData(key: ApiKey.id, value: user!.id);
      // print("SignUp Done And ID is :${user!.id}");
      emit(SignUpSuccess(message: signUPModel.message));
    } on ServerException catch (e) {
      emit(SignUpFailure(errMessage: e.errModel.errorMessage));
    }
  }

  signIn() async {
    emit(SignInLoading());
    try {
      final response = await api.post(
        EndPoint.signIn,
        data: {
          ApiKey.email: signInEmail.text,
          ApiKey.password: signInPassword.text,
        },
      );
      user = SignInModel.fromJson(response);
      CacheHelper().saveData(key: ApiKey.token, value: user!.token);
      CacheHelper().saveData(key: ApiKey.id, value: user!.id);
      print("LogIn Done And ID is :  ${user!.id}");
      emit(SignInSuccess());
    } on ServerException catch (e) {
      emit(SignInFailure(errMessage: e.errModel.errorMessage));
    }
  }

  logout() async {
    emit(LogoutLoading());
    try {
      final response = await api.post(
        EndPoint.logout,
        option: Options(headers: {
          'Authorization': 'Bearer ${user!.token}',
        }),
      );
      CacheHelper().removeData(key: ApiKey.token);
      emit(LogoutSuccess());
    } on ServerException catch (e) {
      emit(LogoutFailure(errMessage: e.errModel.errorMessage));
    }
  }

  forgotPassword() async {
    emit(ForgetPasswordLoading());
    try {
      final response = await api.post(
        EndPoint.forgot_password,
        data: {
          ApiKey.email: resetPasswordEmail.text,
        },
      );
      verificationModel = VerificationModel.fromJson(response);
      CacheHelper()
          .saveData(key: ApiKey.otp, value: verificationModel!.token[0].otp);
      emit(ForgetPasswordSuccess());
    } on ServerException catch (e) {
      emit(ForgetPasswordFailure(errMessage: e.errModel.errorMessage));
    }
  }

  resetPassword() async {
    emit(ResetPasswordLoading());
    try {
      final response = await api.put(
        EndPoint.reset_password,
        data: {
          ApiKey.email: resetPasswordEmail.text,
          'otp': CacheHelper().getData(key: ApiKey.token),
          ApiKey.newPassword: newPassword.text,
          ApiKey.confirmNewPassword: confirmNewPassword.text
        },
      );
      emit(ResetPasswordSuccess());
    } on ServerException catch (e) {
      emit(ResetPasswordFailure(errMessage: e.errModel.errorMessage));
    }
  }

  Future<void> GuiderLogin() async {
    emit(GuiderSignInLoading());
    try {
      final response = await api.post(
        EndPoint.GuiderSignIn,
        data: {
          ApiKey.email: GuiderSignInEmail.text,
          ApiKey.password: GuiderSignInPassword.text,
        },
      );
      GuiderSignIn = GuiderSignInModel.fromJson(response);
      CacheHelper()
          .saveData(key: ApiKey.Guidertoken, value: GuiderSignIn!.token);
      CacheHelper().saveData(key: ApiKey.GuiderId, value: GuiderSignIn!.id);
      log("${GuiderSignIn!.token}");
      log("${GuiderSignIn!.id}");
      log("===============Done===============");
      emit(GuiderSignInSuccess());
    } on ServerException catch (e) {
      emit(GuiderSignInFailure(errMessage: e.errModel.errorMessage));
    }
  }

  Future<void> GuiderLogOut() async {
    emit(GuiderLogOutLoading());
    try {
      final response = await api.post(
        EndPoint.GuiderLogOut,
        option: Options(headers: {
          'Authorization': 'Bearer ${GuiderSignIn!.token}',
        }),
      );
      GuiderSignIn = GuiderSignInModel.fromJson(response.data);
      CacheHelper().saveData(key: ApiKey.Guidertoken, value: GuiderSignIn!.token);
      log(response.toString());
      log("===========================Done Logout===========================");
      emit(GuiderLogOutSuccess());
    } on ServerException catch (e) {
      emit(GuiderLogOutFailure(errMessage: e.errModel.errorMessage));
    } catch (e) {
      emit(GuiderLogOutFailure(errMessage: 'Unexpected error occurred'));
      print('Unexpected error: $e');
    }
  }

  GuiderSignUp() async {
    emit(GuiderSignUpLoading());
    try {
      final response = await api.post(
        EndPoint.GuiderSignUp,
        isFromData: true,
        data: {
          ApiKey.name: GuiderSignUpName.text,
          ApiKey.email: GuiderSignUpEmail.text,
          ApiKey.password: GuiderSignUpPassword.text,
          ApiKey.phoneNnumber: GuiderPhoneNumber.text,
          ApiKey.nationalId: GuiderNationalId.text,
          ApiKey.description: StateGuiderDescriptionController.text,
        },
      );
      emit(GuiderSignUpSuccess());
    } on ServerException catch (e) {
      emit(GuiderSignUpFailure(errMessage: e.errModel.errorMessage));
    }
  }

  SendGuiderReq() async {
    emit(SendGuiderReqLoading());
    try {
      CacheHelper().getData(key: ApiKey.GuiderId);
      print(CacheHelper().getData(key: ApiKey.GuiderId));
      final response = await api.post(EndPoint.SendGuiderReq(CacheHelper().getData(key: ApiKey.GuiderId)),
          isFromData: true,
          data: {
            ApiKey.UserMessage: DescriptionController.text,
          },
          option: Options(headers: {
            'Authorization': 'Bearer ${CacheHelper().getData(key: ApiKey.token)}',
          }));
      emit(SendGuiderReqSuccess());
    } on ServerException catch (e) {
      emit(SendGuiderReqFailure(errMessage: e.errModel.errorMessage));
    }
  }
  VerifyAcc() async {
    emit(VerifyAccLoading());
    try {
      CacheHelper().getData(key: ApiKey.GuiderId);
      print(CacheHelper().getData(key: ApiKey.GuiderId));
      final response = await api.post(EndPoint.SendGuiderReq(CacheHelper().getData(key: ApiKey.GuiderId)),
          isFromData: true,
          data: {
            ApiKey.phoneNnumber: GuiderPhoneNumber.text,
            ApiKey.OtpPhone:OtpPhoneController.text
          },
      );
      emit(VerifyAccSuccess());
    } on ServerException catch (e) {
      emit(VerifyAccFailure(errMessage: e.errModel.errorMessage));
    }
  }
}
