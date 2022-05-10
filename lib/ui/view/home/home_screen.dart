import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/bloc/auth_bloc/auth_bloc_cubit.dart';
import 'package:majootestcase/bloc/home_bloc/home_bloc_cubit.dart';
import 'package:majootestcase/ui/basic/empty_screen.dart';
import 'package:majootestcase/ui/basic/error_screen.dart';
import 'package:majootestcase/ui/basic/loading_indicator.dart';
import 'package:majootestcase/utils/app_colors.dart';
import 'widget/home_loaded_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  TextEditingController _filter = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return SafeArea(
      child: BlocBuilder<HomeBlocCubit, HomeBlocState>(builder: (ctx, state) {
        return NestedScrollView(
          headerSliverBuilder: (BuildContext ctxt, bool innerBoxScrolled) {
            return <Widget>[
              createSilverAppBar((val) => ctx.read<HomeBlocCubit>().fetchingData(val)),
            ];
          },
          body: Stack(
            children: [
              if (state is HomeBlocLoadedState)
                HomeLoadedScreen(data: state.data)
              else if (state is HomeBlocLoadingState)
                LoadingIndicator()
              else if (state is HomeBlocEmptyState)
                EmptyScreen(message: "Daftar film tidak ditemukan")
              else if (state is HomeBlocInitialState)
                Container()
              else if (state is HomeBlocErrorState)
                ErrorScreen(message: state.error)
              else if (state is HomeBlocNoInternetState)
                ErrorScreen(
                  message: state.error,
                  icon: Icon(CupertinoIcons.wifi_slash, size: 80),
                  retry: () => ctx.read<HomeBlocCubit>().fetchingData(_filter.text),
                )
            ],
          ),
        );
      }),
    );
  }

  SliverAppBar createSilverAppBar(ValueChanged<String> onSubmitted) {
    return SliverAppBar(
      leading: Container(),
      expandedHeight: 80,
      pinned: true,
      backgroundColor: AppColors.primary,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(bottom: 10),
        centerTitle: true,
        title: Container(
          padding: EdgeInsets.only(bottom: 2),
          constraints: BoxConstraints(minHeight: 35, maxHeight: 35),
          width: 220,
          child: CupertinoTextField(
            controller: _filter,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            placeholder: "Search..",
            placeholderStyle: TextStyle(color: Color(0xffC4C6CC), fontSize: 14.0, fontFamily: 'Brutal'),
            prefix: Padding(
              padding: const EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
              child: Icon(
                Icons.search,
              ),
            ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.white),
            onSubmitted: onSubmitted,
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    showDialog(
      context: context,
      builder: (context) => BlocBuilder<AuthBlocCubit, AuthBlocState>(builder: (ctx, state) {
        return new AlertDialog(
          title: new Text('Keluar'),
          content: new Text('Apakah Anda yakin ingin keluar?'),
          actions: <Widget>[
            new TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: new Text('Tidak'),
            ),
            new TextButton(
              onPressed: () async {
                await ctx.read<AuthBlocCubit>().logout();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: new Text('Ya'),
            ),
          ],
        );
      }),
    );
    return false;
  }
}
