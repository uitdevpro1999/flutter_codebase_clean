import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'profile_cubit.freezed.dart';
part 'profile_state.dart';

@Injectable()
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState());
}
