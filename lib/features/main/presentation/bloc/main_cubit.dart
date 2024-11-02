import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
part 'main_cubit.freezed.dart';

part 'main_state.dart';

@LazySingleton()
class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainState());
}
