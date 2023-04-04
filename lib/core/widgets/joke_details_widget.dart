import 'package:flutter/material.dart';
import 'package:joke_me/core/entities/joke_entity.dart';
import 'package:joke_me/features/favorite_jokes/presentation/widgets/favorite_icon_widget.dart';

class JokeDetailsWidget extends StatelessWidget {
  const JokeDetailsWidget({
    super.key,
    required this.joke,
    this.onFavoriteToggle,
  });

  final JokeEntity joke;
  final void Function()? onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Scaffold(
          backgroundColor: Colors.black.withOpacity(0.5),
          body: GestureDetector(
            onTap: () {},
            child: Center(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 450,
                  minWidth: 200,
                ),
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 3,
                            horizontal: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade800,
                          ),
                          child: Text(
                            joke.type.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        FavoriteIconWidget(
                          joke,
                          onToggle: onFavoriteToggle,
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(
                            Icons.cancel_outlined,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      joke.setup,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      joke.punchline,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
