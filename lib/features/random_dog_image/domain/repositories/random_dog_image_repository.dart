import 'package:example_clean/core/failure/failure.dart';
import 'package:example_clean/core/result/result.dart';
import 'package:example_clean/features/random_dog_image/domain/entities/dog_image.dart';

abstract class RandomDogImageRepository {
  Future<Result<DogImage, Failure>> getRandomImage();
}
