import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/search/logic/search_bloc.dart';
import 'package:myapp/src/features/search/logic/search_state.dart';
import 'package:myapp/src/features/search/widget/event_tab_search.dart';
import 'package:myapp/src/features/search/widget/people_tab_search.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/widgets/appbar/app_bar_custom.dart';
import 'package:myapp/widgets/forms/input.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchBloc(),
      child: Builder(builder: (context) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBarCustom(
              title: BlocBuilder<SearchBloc, SearchState>(
                  buildWhen: (previous, current) =>
                      previous.searchValue != current.searchValue,
                  builder: (context, state) {
                    return XInput(
                      value: state.searchValue,
                      onChanged: (value) {
                        context.read<SearchBloc>().setSearchValue(value);
                      },
                      decoration: const InputDecoration(
                        hintText: "Search event or people",
                        border: InputBorder.none,
                      ),
                    );
                  }),
              bottom: TabBar(
                labelStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                onTap: (value) {
                  context.read<SearchBloc>().setType(value);
                },
                unselectedLabelColor: AppColors.grey,
                tabs: const [
                  Tab(
                    text: "Event",
                  ),
                  Tab(
                    text: "People",
                  ),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                EventTabSearch(),
                PeopleTabSearch(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
