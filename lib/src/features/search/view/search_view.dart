import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/search/logic/search_bloc.dart';
import 'package:myapp/src/features/search/logic/search_state.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/widgets/appbar/app_bar_custom.dart';
import 'package:myapp/widgets/forms/input.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => SearchBloc(),
        child: BlocBuilder<SearchBloc, SearchState>(
          buildWhen: (previous, current) {
            return previous.searchValue != current.searchValue;
          },
          builder: (context, state) {
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBarCustom(
                  title: XInput(
                    value: state.searchValue,
                    onChanged: (value) {
                      context.read<SearchBloc>().setSearchValue(value);
                    },
                    decoration: const InputDecoration(
                      hintText: "Search event or people",
                      // prefixIcon: Icon(Icons.search),
                      // prefixIconColor: AppColors.grey,
                      border: InputBorder.none,
                    ),
                  ),
                  bottom: const TabBar(
                    labelStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelColor: AppColors.grey,
                    tabs: [
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
                    Icon(Icons.search),
                    Icon(Icons.add),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
