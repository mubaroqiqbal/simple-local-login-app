import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:majootestcase/bloc/auth_bloc/auth_bloc_cubit.dart';
import 'package:majootestcase/bloc/home_bloc/home_bloc_cubit.dart';
import 'package:majootestcase/ui/basic/app_snack_bar.dart';
import 'package:majootestcase/ui/basic/custom_button.dart';
import 'package:majootestcase/ui/basic/loading_indicator.dart';
import 'package:majootestcase/ui/basic/text_form_field.dart';
import 'package:majootestcase/data/local/users_database.dart';
import 'package:majootestcase/models/auth/user.dart';
import 'package:majootestcase/ui/view/home/home_screen.dart';
import 'package:majootestcase/ui/view/auth/register_page.dart';
import 'package:majootestcase/utils/app_strings.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final _emailController = TextController();
  final _passwordController = TextController();

  bool _isObscurePassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    UsersDatabase.instance.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBlocCubit, AuthBlocState>(
        listener: (context, state) {
          if (state is AuthBlocSuccesState) {
            AppSnackbar.show(context, type: SnackBarType.success, text: "Login Berhasil", offset: 50, gravity: ToastGravity.TOP);
          }
          if (state is AuthBlocLoggedInState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (context) => HomeBlocCubit()..fetchingData(""),
                  child: HomeScreen(),
                ),
              ),
            );
          }

          if (state is AuthBlocErrorState) {
            AppSnackbar.show(context, type: SnackBarType.error, text: state.error, offset: 50, gravity: ToastGravity.TOP);
          }
        },
        builder: (context, state) {
          if (state is AuthBlocLoadingState) {
            return LoadingIndicator();
          }

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 75, left: 25, bottom: 25, right: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Selamat Datang',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Silahkan home terlebih dahulu',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8, bottom: 20),
                    child: _form(),
                  ),
                  Divider(color: Colors.grey),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: CustomButton(
                      height: 50,
                      text: 'LOGIN',
                      onPressed: () async {
                        if (_emailController.value.isEmpty || _passwordController.value.isEmpty) {
                          AppSnackbar.show(
                            context,
                            type: SnackBarType.error,
                            text: AppStrings.form_tidak_boleh_kosong,
                            offset: 50,
                            gravity: ToastGravity.TOP,
                          );
                        }

                        if (formKey.currentState?.validate() == true) {
                          User user = User(email: _emailController.value, password: _passwordController.value);

                          context.read<AuthBlocCubit>().loginUser(user);
                        }
                      },
                    ),
                  ),
                  _register()
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _form() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _emailController,
            isEmail: true,
            hint: 'Example@123.com',
            label: 'Email',
            validator: (val) {
              final pattern = new RegExp(r'([\d\w]{1,}@[\w\d]{1,}\.[\w]{1,})');
              if (val != null) return pattern.hasMatch(val) ? null : 'Masukkan email yang valid';
            },
          ),
          CustomTextFormField(
            label: 'Password',
            hint: 'password',
            controller: _passwordController,
            isObscureText: _isObscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _isObscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              ),
              onPressed: () {
                setState(() {
                  _isObscurePassword = !_isObscurePassword;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _register() {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (context) => AuthBlocCubit()..fetchHistoryLogin(),
                child: RegisterPage(),
              ),
            ),
          );
        },
        child: RichText(
          text: TextSpan(text: 'Belum punya akun? ', style: TextStyle(color: Colors.black45), children: [
            TextSpan(
              text: 'Daftar',
            ),
          ]),
        ),
      ),
    );
  }
}
