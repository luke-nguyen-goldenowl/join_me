import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/followed/logic/followed_state.dart';

class FollowedBloc extends Cubit<FollowedState> {
  FollowedBloc() : super(FollowedState());
}
