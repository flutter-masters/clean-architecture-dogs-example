import 'package:example_clean/features/random_dog_image/domain/entities/dog_image.dart';

class DogImageModel extends DogImage {
  const DogImageModel({
    required super.message,
    required super.status,
  });

  factory DogImageModel.fromJson(Map<String, dynamic> json) => DogImageModel(
        message: json['message'],
        status: json['status'],
      );
}
