import 'package:example_clean/core/result/result.dart';
import 'package:example_clean/features/random_dog_image/domain/entities/dog_image.dart';
import 'package:example_clean/features/random_dog_image/domain/repositories/random_dog_image_repository.dart';
import 'package:flutter/material.dart';

sealed class RandomDogImageState {}

class InitialState extends RandomDogImageState {}

class LoadingState extends RandomDogImageState {}

class LoadedState extends RandomDogImageState {
  LoadedState({
    required this.dogImage,
  });
  final DogImage dogImage;
}

class FailureState extends RandomDogImageState {}

class RandomDogImageNotifier extends ChangeNotifier {
  RandomDogImageNotifier({
    required RandomDogImageRepository randomDogImageRepository,
  })  : randomDogImageState = InitialState(),
        _repository = randomDogImageRepository;

  final RandomDogImageRepository _repository;

  RandomDogImageState randomDogImageState;

  void generateRandomImage() async {
    randomDogImageState = LoadingState();
    notifyListeners();

    final result = await _repository.getRandomImage();

    if (result is Success) {
      randomDogImageState = LoadedState(
        dogImage: (result as Success).value,
      );

      notifyListeners();
      return;
    }

    randomDogImageState = FailureState();
    notifyListeners();
  }
}
