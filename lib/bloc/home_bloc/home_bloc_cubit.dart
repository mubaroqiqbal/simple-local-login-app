import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:majootestcase/models/home/data.dart';
import 'package:majootestcase/models/home/movie_response.dart';
import 'package:majootestcase/data/remote/api_service.dart';
import 'package:majootestcase/data/remote/dio_config_service.dart' as dioConfig;
import 'package:majootestcase/utils/app_strings.dart';
import 'package:majootestcase/utils/error_helper.dart';

part 'home_bloc_state.dart';

class HomeBlocCubit extends Cubit<HomeBlocState> {
  HomeBlocCubit() : super(HomeBlocInitialState());

  void fetchingData(String query) async {
    try {
      emit(HomeBlocLoadingState());

      ApiServices apiServices = ApiServices(await dioConfig.dio());

      MovieResponse? movieResponse = await apiServices.getMovieList(query);

      if (movieResponse == null || movieResponse.data.length <= 0) {
        emit(HomeBlocEmptyState());
      } else {
        emit(HomeBlocLoadedState(movieResponse.data));
      }
    } catch (e) {
      print(e.toString());
      if (e.toString().contains("SocketException")) //print("no internet");
        emit(HomeBlocNoInternetState(AppStrings.connection_error));
      else
        emit(HomeBlocErrorState(ErrorHelper.getErrorMessage(e)));
    }
  }
}
