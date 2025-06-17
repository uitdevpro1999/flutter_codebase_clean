import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_codebase_clean/features/auth/presentation/login/bloc/login_cubit.dart';
import 'package:flutter_codebase_clean/features/profile/presentation/login/bloc/profile_cubit.dart';
import 'package:flutter_codebase_clean/injection_container.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  late ProfileCubit _profileCubit;

  @override
  void initState() {
    _profileCubit = getIt<ProfileCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (_) => _profileCubit,
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return Container();
          },
        ),
      ),
    );
  }
}
