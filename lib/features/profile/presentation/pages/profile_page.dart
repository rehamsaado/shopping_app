import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/localization/app_strings.dart';
import '../../../../core/di/injection_container.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../widgets/profile_content_widget.dart';
import '../widgets/profile_error_view.dart';

class ProfileScreen extends StatelessWidget {
  final String userId;

  const ProfileScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('profile_title')),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) =>
            sl<ProfileBloc>()..add(GetProfileDetailsEvent(userId: userId)),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (state is ProfileLoaded) {
              return ProfileContentWidget(profile: state.profile);
            } else if (state is ProfileError) {
              return ProfileErrorView(
                message: state.message,
                onRetry: () {
                  context.read<ProfileBloc>().add(
                    GetProfileDetailsEvent(userId: userId),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}




