part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FillProfile extends ProfileEvent {
  const FillProfile({required this.profile});

  final ProfileModel profile;

  @override
  List<Object> get props => [profile];
}