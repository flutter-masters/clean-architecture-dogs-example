import 'package:dio/dio.dart';
import 'package:example_clean/features/random_dog_image/data/datasources/random_dog_image_api_datasource.dart';
import 'package:example_clean/features/random_dog_image/data/repositories/random_dog_image_repository_impl.dart';
import 'package:example_clean/features/random_dog_image/presentation/notifiers/random_dog_image_notifier.dart';
import 'package:flutter/material.dart';

class RandomDogImageScreen extends StatefulWidget {
  const RandomDogImageScreen({
    super.key,
  });

  @override
  State<RandomDogImageScreen> createState() => _RandomDogImageScreenState();
}

class _RandomDogImageScreenState extends State<RandomDogImageScreen> {
  final _randomDogImageNotifier = RandomDogImageNotifier(
    randomDogImageRepository: RandomDogImageRepositoryImpl(
      randomDogImageRemoteDataSource: RandomDogImageApiDataSource(
        dio: Dio(),
      ),
    ),
  );

  @override
  void initState() {
    _randomDogImageNotifier.generateRandomImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: ListenableBuilder(
          listenable: _randomDogImageNotifier,
          builder: (context, child) {
            return switch (_randomDogImageNotifier.randomDogImageState) {
              InitialState() => const SizedBox(),
              LoadingState() => const Center(
                  child: CircularProgressIndicator(),
                ),
              LoadedState(dogImage: final dogImage) => Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 400,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            dogImage.message,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _randomDogImageNotifier.generateRandomImage();
                      },
                      child: const Text('Refresh'),
                    )
                  ],
                ),
              FailureState() => const Center(
                  child: Text(
                    'Error while loading image',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                )
            };
          },
        ),
      ),
    );
  }
}
