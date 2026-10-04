import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:souqna/features/home/data/models/product_model.dart';
import 'package:souqna/features/home/data/repositories/product_repository.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductRepository _productRepository;
  ProductsCubit(this._productRepository) : super(ProductsInitial());
  Future<void> fetchProducts() async {
    emit(ProductsLoading());
    try {
      final products = await _productRepository.getProducts();

      emit(ProductsLoaded(products: products));
    } catch (e) {
      emit(ProductsError(message: e.toString()));
    }
  }
}
// class ProductsCubit extends Cubit<ProductsState> {
//   final ProductRepository _productRepository;

//   ProductsCubit(this._productRepository) : super(ProductsInitial()) {
//     print('🔥 ProductsCubit CREATED');
//   }

//   Future<void> fetchProducts() async {
//     print('🌐 fetchProducts CALLED');

//     emit(ProductsLoading());

//     try {
//       final products = await _productRepository.getProducts();

//       print('✅ Products loaded: ${products.length}');

//       emit(ProductsLoaded(products: products));
//     } catch (e) {
//       print('❌ Products error: $e');

//       emit(ProductsError(message: e.toString()));
//     }
//   }

//   @override
//   Future<void> close() {
//     print('🗑️ ProductsCubit CLOSED');
//     return super.close();
//   }
// }
