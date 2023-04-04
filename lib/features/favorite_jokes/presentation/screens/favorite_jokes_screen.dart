import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joke_me/core/components/header.dart';
import 'package:joke_me/core/components/joke_teaser_tile.dart';
import 'package:joke_me/core/entities/joke_entity.dart';
import 'package:joke_me/core/widgets/joke_details_widget.dart';
import 'package:joke_me/features/favorite_jokes/data/data_source/local/local_data_source.dart';
import 'package:joke_me/features/favorite_jokes/data/repositories/favorites_repository_impl.dart';
import 'package:joke_me/features/favorite_jokes/domain/usecase/get_favorites_usecase.dart';
import 'package:joke_me/features/favorite_jokes/presentation/bloc/get_favorites/get_favorites_bloc.dart';
import 'package:joke_me/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteJokesScreen extends StatelessWidget {
  const FavoriteJokesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            MyHeader(
              text: "Favorites",
              icon: Icons.arrow_back_ios_new_rounded,
              onIconTap: () {
                Navigator.of(context).pop();
              },
            ),
            BlocProvider<GetFavoritesBloc>(
              create: (context) => GetFavoritesBloc(
                GetFavoritesUsecase(
                  FavoriteRepositoryImpl(
                    LocalDataSourceImpl(
                      sl<SharedPreferences>(),
                    ),
                  ),
                ),
              )..add(GetFavoriteJokesEvent()),
              child: const ListWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class ListWidget extends StatelessWidget {
  const ListWidget({super.key});

  void _showOverLayWidget(JokeEntity joke, BuildContext context) async {
    await showGeneralDialog(
      context: context,
      pageBuilder: (_, animation, secondaryAnimation) {
        return JokeDetailsWidget(
          joke: joke,
          onFavoriteToggle: () {
            BlocProvider.of<GetFavoritesBloc>(context).add(
              GetFavoriteJokesEvent(),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<GetFavoritesBloc, GetFavoritesState>(
        builder: (context, state) {
          if (state is GetFavoritesLoadedState) {
            if (state.jokes.isEmpty) {
              return const Center(
                child: Text(
                  "Jokes on you ッ",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              );
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<GetFavoritesBloc>(context).add(
                    GetFavoriteJokesEvent(),
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
            }
          } else if (state is GetFavoritesFailureState) {
            return const Center(
              child: Text("Jokes on you ッ"),
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
