// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:melijo/models/profile_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileLoading()) {
    on<FillProfile>((event, emit) => _onFillProfile(event, emit));
  }

  void _onFillProfile(FillProfile event, Emitter<ProfileState> emit) {
    final ProfileState state = ProfileInit(profile: event.profile);

    if (state is ProfileInit) {
      emit(
        ProfileInit(profile: state.profile),
      );
    }
  }
}
