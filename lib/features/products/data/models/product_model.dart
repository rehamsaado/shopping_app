import 'package:shopping_app/features/products/data/models/rating_model.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.description,
    required super.category,
    required super.image,
    required super.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json[ApiConstants.keyId] as int? ?? 0,
      title: json[ApiConstants.keyTitle] as String? ?? '',
      price: (json[ApiConstants.keyPrice] as num?)?.toDouble() ?? 0.0,
      description: json[ApiConstants.keyDescription] as String? ?? '',
      category: json[ApiConstants.keyCategory] as String? ?? '',
      image: json[ApiConstants.keyImage] as String? ?? '',
      rating: RatingModel.fromJson(
        json[ApiConstants.keyRating] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiConstants.keyId: id,
      ApiConstants.keyTitle: title,
      ApiConstants.keyPrice: price,
      ApiConstants.keyDescription: description,
      ApiConstants.keyCategory: category,
      ApiConstants.keyImage: image,
      ApiConstants.keyRating: (rating as RatingModel).toJson(),
    };
  }
}
