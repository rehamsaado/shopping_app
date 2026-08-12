import 'package:equatable/equatable.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class GetProductsEvent extends ProductsEvent {}

class GetProductDetailsEvent extends ProductsEvent {
  final int id;

  const GetProductDetailsEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class GetProductsByCategoryEvent extends ProductsEvent {
  final String category;

  const GetProductsByCategoryEvent(this.category);

  @override
  List<Object?> get props => [category];
}

class GetCategoriesEvent extends ProductsEvent {}

class AddProductEvent extends ProductsEvent {
  final Map<String, dynamic> productData;

  const AddProductEvent(this.productData);

  @override
  List<Object?> get props => [productData];
}

class UpdateProductEvent extends ProductsEvent {
  final int id;
  final Map<String, dynamic> productData;

  const UpdateProductEvent({required this.id, required this.productData});

  @override
  List<Object?> get props => [id, productData];
}

class DeleteProductEvent extends ProductsEvent {
  final int id;

  const DeleteProductEvent(this.id);

  @override
  List<Object?> get props => [id];
}