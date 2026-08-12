import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/features/profile/presentation/bloc/profile_event.dart';
import 'package:shopping_app/features/profile/presentation/bloc/profile_state.dart';

import '../../../../core/error/failures.dart';
import '../../domain/usecases/user/get_cached_profile_details_usecase.dart';
import '../../domain/usecases/user/get_profile_details_usecase.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileDetailsUseCase getProfileDetailsUseCase;
  final GetCachedProfileDetailsUseCase getCachedProfileDetailsUseCase;

  ProfileBloc({
    required this.getProfileDetailsUseCase,
    required this.getCachedProfileDetailsUseCase,
  }) : super(ProfileInitial()) {
    on<GetProfileDetailsEvent>(_onGetProfileDetails);
    on<GetCachedProfileEvent>(_onGetCachedProfile);
  }

  Future<void> _onGetProfileDetails(
      GetProfileDetailsEvent event,
      Emitter<ProfileState> emit,
      ) async {
    emit(ProfileLoading());

    final result = await getProfileDetailsUseCase(event.userId);

    result.fold(
          (failure) => emit(ProfileError(message: _mapFailureToMessage(failure))),
          (profile) => emit(ProfileLoaded(profile: profile)),
    );
  }

  Future<void> _onGetCachedProfile(
      GetCachedProfileEvent event,
      Emitter<ProfileState> emit,
      ) async {
    emit(ProfileLoading());

    final result = await getCachedProfileDetailsUseCase();

    result.fold(
          (failure) => emit(ProfileError(message: _mapFailureToMessage(failure))),
          (profile) => emit(ProfileLoaded(profile: profile)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return (failure as ServerFailure).message;
      case CacheFailure _:
        return (failure as CacheFailure).message;
      default:
        return 'unexpected_error';
    }
  }
}