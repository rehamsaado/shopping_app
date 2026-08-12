import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/rating_entity.dart';

class RatingModel extends RatingEntity {
  const RatingModel({
    required super.rate,
    required super.count,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      rate: (json[ApiConstants.keyRate] as num?)?.toDouble() ?? 0.0,
      count: json[ApiConstants.keyCount] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiConstants.keyRate: rate,
      ApiConstants.keyCount: count,
    };
  }
}