import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/products_repository.dart';
import 'products_event.dart';
import 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepository productsRepository;

  ProductsBloc({required this.productsRepository}) : super(ProductsInitial()) {
    on<GetProductsEvent>(_onGetProducts);
    on<GetProductDetailsEvent>(_onGetProductDetails);
    on<GetProductsByCategoryEvent>(_onGetProductsByCategory);
    on<GetCategoriesEvent>(_onGetCategories);
    on<AddProductEvent>(_onAddProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
  }

  Future<void> _onGetProducts(
    GetProductsEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());

    final result = await productsRepository.getProducts();

    result.fold(
      (failure) => emit(ProductsError(_mapFailureToMessage(failure))),
      (products) => emit(ProductsLoaded(products)),
    );
  }

  Future<void> _onGetProductDetails(
    GetProductDetailsEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductDetailsLoading());

    final result = await productsRepository.getProductDetails(event.id);

    result.fold(
      (failure) => emit(ProductsError(_mapFailureToMessage(failure))),
      (product) => emit(ProductDetailsLoaded(product)),
    );
  }

  Future<void> _onGetProductsByCategory(
    GetProductsByCategoryEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());

    final result = await productsRepository.getProductsByCategory(
      event.category,
    );

    result.fold(
      (failure) => emit(ProductsError(_mapFailureToMessage(failure))),
      (products) => emit(ProductsLoaded(products)),
    );
  }

  Future<void> _onGetCategories(
    GetCategoriesEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(CategoriesLoading());

    final result = await productsRepository.getCategories();

    result.fold(
      (failure) => emit(ProductsError(_mapFailureToMessage(failure))),
      (categories) => emit(CategoriesLoaded(categories)),
    );
  }

  Future<void> _onAddProduct(
    AddProductEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductActionLoading());

    final result = await productsRepository.addProduct(event.productData);

    result.fold(
      (failure) => emit(ProductsError(_mapFailureToMessage(failure))),
      (product) => emit(ProductActionSuccess(product)),
    );
  }

  Future<void> _onUpdateProduct(
    UpdateProductEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductActionLoading());

    final result = await productsRepository.updateProduct(
      event.id,
      event.productData,
    );

    result.fold(
      (failure) => emit(ProductsError(_mapFailureToMessage(failure))),
      (product) => emit(ProductActionSuccess(product)),
    );
  }

  Future<void> _onDeleteProduct(
    DeleteProductEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductActionLoading());

    final result = await productsRepository.deleteProduct(event.id);

    result.fold(
      (failure) => emit(ProductsError(_mapFailureToMessage(failure))),
      (_) => emit(const ProductDeletedSuccess()),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is NetworkFailure) {
      return failure.message;
    }
    if (failure is ServerFailure) {
      return failure.message;
    }
    if (failure is CacheFailure) {
      return failure.message;
    }
    return failure.message.isNotEmpty ? failure.message : 'error_server';
  }
}
