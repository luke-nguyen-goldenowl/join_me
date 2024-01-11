import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/features/search/logic/person_bloc.dart';
import 'package:myapp/src/features/search/logic/person_state.dart';
import 'package:myapp/src/network/model/user/user.dart';
import 'package:myapp/src/router/coordinator.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/widgets/image/image_network.dart';

class PersonSearchWidget extends StatelessWidget {
  const PersonSearchWidget({super.key, required this.person});
  final MUser person;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PersonBloc(person: person),
      child: BlocBuilder<PersonBloc, PersonState>(
        buildWhen: (previous, current) => previous.person != current.person,
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              AppCoordinator.showProfileOtherUser(id: state.person.id);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: XImageNetwork(
                            person.avatar,
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            person.name ?? "",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<PersonBloc>().onPressedFollowHost();
                      },
                      child: Text(GetIt.I<AccountBloc>()
                                  .state
                                  .user
                                  .followed
                                  ?.contains(state.person.id) ??
                              false
                          ? "Following"
                          : "Follow"),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
