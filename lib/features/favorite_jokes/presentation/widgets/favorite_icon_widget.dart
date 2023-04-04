import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joke_me/core/entities/joke_entity.dart';
import 'package:joke_me/features/favorite_jokes/data/data_source/local/local_data_source.dart';
import 'package:joke_me/features/favorite_jokes/data/repositories/favorites_repository_impl.dart';
import 'package:joke_me/features/favorite_jokes/domain/usecase/add_favorite_usecase.dart';
import 'package:joke_me/features/favorite_jokes/domain/usecase/check_favorite_usecase.dart';
import 'package:joke_me/features/favorite_jokes/domain/usecase/delete_favorite_usecase.dart';
import 'package:joke_me/features/favorite_jokes/presentation/bloc/add_favorite/add_favorite_bloc.dart';
import 'package:joke_me/features/favorite_jokes/presentation/bloc/check_favorite/check_favorite_bloc.dart';
import 'package:joke_me/features/favorite_jokes/presentation/bloc/delete_favorite/delete_favorite_bloc.dart';
import 'package:joke_me/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteIconWidget extends StatelessWidget {
  const FavoriteIconWidget(
    this.joke, {
    super.key,
    this.onToggle,
  });

  final JokeEntity joke;
  final void Function()? onToggle;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CheckFavoriteBloc>(
          create: (context) => CheckFavoriteBloc(
            CheckFavoriteUsecase(
              FavoriteRepositoryImpl(
                LocalDataSourceImpl(
                  sl<SharedPreferences>(),
                ),
              ),
            ),
          )..add(CheckEvent(joke.id)),
        ),
        BlocProvider<AddFavoriteBloc>(
          create: (context) => AddFavoriteBloc(
            AddFavoriteUsecase(
              FavoriteRepositoryImpl(
                LocalDataSourceImpl(
                  sl<SharedPreferences>(),
                ),
              ),
            ),
          ),
        ),
        BlocProvider<DeleteFavoriteBloc>(
          create: (context) => DeleteFavoriteBloc(
            DeleteFavoriteUsecase(
              FavoriteRepositoryImpl(
                LocalDataSourceImpl(
                  sl<SharedPreferences>(),
                ),
              ),
            ),
          ),
        ),
      ],
      child: IconWidget(
        joke,
        onToggle: onToggle,
      ),
    );
  }
}

class IconWidget extends StatelessWidget {
  const IconWidget(
    this.joke, {
    super.key,
    required this.onToggle,
  });

  final JokeEntity joke;
  final void Function()? onToggle;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AddFavoriteBloc, AddFavoriteState>(
          listener: (context, state) {
            if (state is AddFavoriteLoadedState) {
              BlocProvider.of<CheckFavoriteBloc>(context).add(
                CheckEvent(joke.id),
              );
              onToggle?.call();
            }
          },
          listenWhen: (previous, current) => current is AddFavoriteLoadedState,
        ),
        BlocListener<DeleteFavoriteBloc, DeleteFavoriteState>(
          listener: (context, state) {
            if (state is DeleteFavoriteLoadedState) {
              BlocProvider.of<CheckFavoriteBloc>(context).add(
                CheckEvent(joke.id),
              );
              onToggle?.call();
            }
          },
          listenWhen: (previous, current) =>
              current is DeleteFavoriteLoadedState,
        ),
      ],
      child: BlocBuilder<CheckFavoriteBloc, CheckFavoriteState>(
        builder: (context, state) {
          if (state is CheckFavoriteLoadedState) {
            if (state.isFavorite) {
              return GestureDetector(
                onTap: () {
                  BlocProvider.of<DeleteFavoriteBloc>(context).add(
                    DeleteEvent(joke),
                  );
                },
                child: const Icon(Icons.favorite_rounded),
              );
            } else {
              return GestureDetector(
                onTap: () {
                  BlocProvider.of<AddFavoriteBloc>(context).add(
                    AddFavoriteJokeEvent(joke),
                  );
                },
                child: const Icon(Icons.favorite_border_rounded),
              );
            }
          }
          return const Icon(Icons.favorite_border_rounded);
        },
      ),
    );
  }
}
