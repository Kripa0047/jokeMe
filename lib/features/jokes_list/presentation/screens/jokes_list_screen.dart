import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joke_me/core/components/header.dart';
import 'package:joke_me/core/http/client.dart';
import 'package:joke_me/features/jokes_list/data/data_source/remote/jokes_data_source.dart';
import 'package:joke_me/features/jokes_list/data/repositories/jokes_repository_impl.dart';
import 'package:joke_me/core/entities/joke_entity.dart';
import 'package:joke_me/features/jokes_list/domain/usecases/ger_random_ten__jokes_usecase.dart';
import 'package:joke_me/features/jokes_list/presentation/bloc/get_ten_random_jokes/get_ten_random_jokes_bloc.dart';
import 'package:joke_me/features/jokes_list/presentation/components/joke_teaser_tile.dart';
import 'package:joke_me/features/jokes_list/presentation/widgets/joke_details_widget.dart';
import 'package:joke_me/injector.dart';

class JokesListScreen extends StatelessWidget {
  const JokesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const MyHeader(text: "JokeMe"),
            BlocProvider<GetTenRandomJokesBloc>(
              create: (context) => GetTenRandomJokesBloc(
                GetRandomTenJokesUsecase(
                  JokesRepositoryImpl(
                    JokesDataSourceImpl(
                      sl<HTTP>(),
                    ),
                  ),
                ),
              )..add(GetJokesEvent()),
              child: const JokesListView(),
            ),
          ],
        ),
      ),
    );
  }
}

class JokesListView extends StatelessWidget {
  const JokesListView({super.key});

  void _showOverLayWidget(JokeEntity joke, BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return JokeDetailsWidget(
          joke: joke,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<GetTenRandomJokesBloc, GetTenRandomJokesState>(
        builder: (context, state) {
          if (state is GetTenRandomJokesLoadedState) {
            return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<GetTenRandomJokesBloc>(context).add(
                  GetJokesEvent(),
                );
              },
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 5),
                itemCount: state.jokes.length,
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 5,
                  ),
                  child: JokeTeaserTile(
                    setupLine: state.jokes[i].setup,
                    type: state.jokes[i].type,
                    onTap: () {
                      _showOverLayWidget(
                        state.jokes[i],
                        context,
                      );
                    },
                  ),
                ),
              ),
            );
          } else if (state is GetTenRandomJokesFailedState) {
            return const Center(
              child: Text(
                "OPPs..",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
