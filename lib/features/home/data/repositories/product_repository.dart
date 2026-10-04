import 'package:souqna/features/home/data/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductRepository {
  final _client = Supabase.instance.client;
  Future<List<ProductModel>> getProducts() async {
    final response = await _client
        .from('products')
        .select()
        .order('status', ascending: true);
    return response.map((json) => ProductModel.fromJson(json)).toList();
  }
}
