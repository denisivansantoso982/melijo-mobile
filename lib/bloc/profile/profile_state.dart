part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {}

class ProfileInit extends ProfileState {
  const ProfileInit({required this.profile});

  final ProfileModel profile;

  @override
  List<Object> get props => [];
}
