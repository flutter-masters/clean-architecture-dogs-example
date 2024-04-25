import 'package:dio/dio.dart';
import 'package:example_clean/features/random_dog_image/data/datasources/random_dog_image_remote_datasource.dart';
import 'package:example_clean/features/random_dog_image/data/models/dog_image_model.dart';

class RandomDogImageApiDataSource implements RandomDogImageRemoteDataSource {
  const RandomDogImageApiDataSource({
    required Dio dio,
  }) : _dio = dio;

  final Dio _dio;

  @override
  Future<DogImageModel> getRandomImage() async {
    try {
      final response =
          await _dio.get('https://dog.ceo/api/breeds/image/random');

      if (response.statusCode == 200) {
        return DogImageModel.fromJson(response.data);
      }

      throw Exception('Unknown Exception');
    } catch (e) {
      rethrow;
    }
  }
}
