import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfileDetailsEvent extends ProfileEvent {
  final String userId;

  const GetProfileDetailsEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class GetCachedProfileEvent extends ProfileEvent {
  const GetCachedProfileEvent();
}