import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entity/profile_entity.dart';

abstract class ProfileRepository {

  Future<Either<Failure, ProfileEntity>> getProfileDetails(String userId);

  /// حفظ بيانات المستخدم محلياً لضمان استمرارية عرضها
  Future<Either<Failure, Unit>> cacheProfileDetails(ProfileEntity profile);

  /// جلب بيانات المستخدم المخزنة محلياً عند فتح التطبيق
  Future<Either<Failure, ProfileEntity>> getCachedProfileDetails();
}