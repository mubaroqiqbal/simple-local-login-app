import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:majootestcase/data/local/users_database.dart';
import 'package:majootestcase/models/auth/user.dart';
import 'package:majootestcase/utils/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_bloc_state.dart';

class AuthBlocCubit extends Cubit<AuthBlocState> {
  AuthBlocCubit() : super(AuthBlocInitialState());

  void fetchHistoryLogin() async {
    emit(AuthBlocInitialState());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isLoggedIn = sharedPreferences.getBool("is_logged_in") ?? false;
    if (isLoggedIn) {
      emit(AuthBlocLoggedInState());
    } else {
      emit(AuthBlocLoginState());
    }
  }

  Future<void> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("is_logged_in", false);
  }

  void loginUser(User user) async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      emit(AuthBlocLoadingState());

      final response = await UsersDatabase.instance.login(user.email);

      if (response == null) {
        emit(AuthBlocErrorState(AppStrings.login_gagal));
      } else {
        if (user.password == response.password) {
          String data = user.toJson().toString();

          await sharedPreferences.setBool("is_logged_in", true);
          await sharedPreferences.setString("user_value", data);

          emit(AuthBlocSuccesState());

          Future.delayed(Duration(seconds: 2));

          emit(AuthBlocLoggedInState());
        } else {
          emit(AuthBlocErrorState(AppStrings.password_salah));
        }
      }
    } catch (e) {
      emit(AuthBlocErrorState(e.toString().replaceAll("Exception: ", "")));
    }
  }

  void registerUser(User user) async {
    try {
      emit(AuthBlocLoadingState());

      final userData = await UsersDatabase.instance.getUser(user.email, user.userName);

      if (userData == null) {
        final response = await UsersDatabase.instance.create(user);

        if (response.id != null) {
          emit(AuthBlocRegisterSuccesState());
        } else {
          emit(AuthBlocRegisterErrorState(AppStrings.gagal_registrasi));
        }
      } else {
        emit(AuthBlocRegisterErrorState(AppStrings.username_email_sudah_digunakan));
      }
    } catch (e) {
      emit(AuthBlocErrorState(e.toString()));
    }
  }
}
