import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:majootestcase/bloc/auth_bloc/auth_bloc_cubit.dart';
import 'package:majootestcase/ui/basic/app_snack_bar.dart';
import 'package:majootestcase/ui/basic/custom_button.dart';
import 'package:majootestcase/ui/basic/text_form_field.dart';
import 'package:majootestcase/models/auth/user.dart';
import 'package:majootestcase/utils/app_strings.dart';

class RegisterPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<RegisterPage> {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final _userNameController = TextController();
  final _emailController = TextController();
  final _passwordController = TextController();

  bool _isObscurePassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 1.0,
        title: Text(
          "Registrasi User",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return BlocConsumer<AuthBlocCubit, AuthBlocState>(
      listener: (ctx, state) {
        if (state is AuthBlocRegisterSuccesState) {
          AppSnackbar.show(context, type: SnackBarType.success, text: "Registrasi User Berhasil", offset: 50);
          Navigator.of(context).popUntil((route) => route.isFirst);
        }

        if (state is AuthBlocRegisterErrorState) {
          AppSnackbar.show(context, type: SnackBarType.error, text: state.error, offset: 50);
        }
      },
      builder: (ctx, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Silahkan lengkapi data berikut', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                Container(
                  margin: EdgeInsets.only(top: 8, bottom: 20),
                  child: _form(),
                ),
                Divider(color: Colors.grey),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: CustomButton(
                    height: 50,
                    text: 'REGISTER',
                    onPressed: () async {
                      if (_userNameController.value.isEmpty || _emailController.value.isEmpty || _passwordController.value.isEmpty) {
                        AppSnackbar.show(
                          context,
                          type: SnackBarType.error,
                          text: AppStrings.form_tidak_boleh_kosong,
                          offset: 50,
                          gravity: ToastGravity.TOP,
                        );
                      }

                      if (formKey.currentState?.validate() == true) {
                        ctx.read<AuthBlocCubit>().registerUser(
                              User(
                                userName: _userNameController.value,
                                email: _emailController.value,
                                password: _passwordController.value,
                              ),
                            );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _form() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _userNameController,
            hint: 'username',
            label: 'Username',
          ),
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
              icon: Icon(_isObscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined),
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
}
