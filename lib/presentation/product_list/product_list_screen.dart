import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lakukan_product_catalog/di/di.dart';
import 'package:lakukan_product_catalog/presentation/product_list/product_list_bloc.dart';

import '../../domain/entites/product_entity.dart';
import '../product_add/product_add_screen.dart';
import '../product_detail/product_detail_screen.dart';
import '../product_search/product_search_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late final ProductListBloc _productListBloc;
  late final ProductListBloc _categoryListBloc;
  late final ScrollController _scrollController;
  late List<ProductEntity> _productList;
  late int _skip;
  late bool _hasMoreData;
  late bool _fristLoad;

  void _reset() {
    setState(() {
      _productList = [];
      _skip = 0;
      _hasMoreData = true;
      _fristLoad = true;
    });
  }

  void _onscroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (_hasMoreData) {
        _productListBloc.add(GetProductListEvent(limit: 10, skip: _skip));
      }
    }
  }

  String _formatString(String input) {
    if (input.isEmpty) {
      return input;
    }

    List<String> parts = input.split('-');
    if (parts.isEmpty) {
      return input;
    }

    // Capitalize each part
    parts = parts.map((part) {
      if (part.isNotEmpty) {
        return part[0].toUpperCase() + part.substring(1).toLowerCase();
      } else {
        return part;
      }
    }).toList();

    // Join the parts with a space
    return parts.join(' ');
  }

  @override
  void initState() {
    _productListBloc = getIt<ProductListBloc>();
    _categoryListBloc = getIt<ProductListBloc>();
    _scrollController = ScrollController();
    _reset();
    _productListBloc.add(GetProductListEvent(limit: 10, skip: _skip));
    _categoryListBloc.add(GetCategoryListEvent());
    _scrollController.addListener(() => _onscroll());
    super.initState();
  }

  @override
  void dispose() {
    _productListBloc.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        scrolledUnderElevation: 0,
        toolbarHeight: 80,
        title: Row(
          children: [
            Image.asset(
              'assets/images/lg.png',
              width: 45,
              height: 45,
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lakukan',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'App for searching product',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _reset();
          _productListBloc.add(GetProductListEvent(limit: 10, skip: _skip));
          _categoryListBloc.add(GetCategoryListEvent());
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Explore',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.yellow[700],
                        ),
                      ),
                      const TextSpan(
                        text: ' the best product \nthat suits your needs',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: TextField(
                  readOnly: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const ProductSearchScreen();
                        },
                      ),
                    );
                  },
                  decoration: InputDecoration(
                    hintText: 'Search product',
                    prefixIcon: const Icon(Icons.search_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
            ),
            const SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            BlocBuilder<ProductListBloc, ProductListState>(
              bloc: _categoryListBloc,
              builder: (context, state) {
                if (state is CategoryListLoading) {
                  return const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 50,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                }

                if (state is CategoryListSuccess) {
                  return SliverToBoxAdapter(
                    child: SizedBox(
                      height: 50,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        scrollDirection: Axis.horizontal,
                        itemCount: state.categories.length,
                        itemBuilder: (context, index) {
                          final category = _formatString(
                            state.categories[index],
                          );
                          return Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text(category)],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
                return const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 50,
                    child: Center(
                      child: Text("something went wrong"),
                    ),
                  ),
                );
              },
            ),
            BlocConsumer<ProductListBloc, ProductListState>(
              bloc: _productListBloc,
              listener: (context, state) {
                if (state is ProductListError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );

                  if (_fristLoad) {
                    setState(() => _fristLoad = false);
                  }

                  if (_hasMoreData) {
                    setState(() => _hasMoreData = false);
                  }
                  return;
                }

                if (state is ProductListSuccess) {
                  final result = state.result;
                  final data = result.data;

                  if (data.list.isNotEmpty) {
                    setState(() {
                      _productList.addAll(data.list);
                      _skip += 10;
                    });
                  }

                  if (data.list.length < 10) {
                    setState(() => _hasMoreData = false);
                  }

                  if (_fristLoad) {
                    setState(() => _fristLoad = false);
                  }
                  return;
                }

                if (state is ProductListError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );

                  if (_fristLoad) {
                    setState(() => _fristLoad = false);
                  }

                  if (_hasMoreData) {
                    setState(() => _hasMoreData = false);
                  }
                  return;
                }
              },
              builder: (context, state) {
                if (state is ProductListLoading && _fristLoad) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 16.0,
                    bottom: 100.0,
                  ),
                  sliver: SliverGrid.builder(
                    itemCount: _productList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      final product = _productList[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const ProductDetailScreen();
                              },
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(product.thumbnail),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                product.brand,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                product.price.toString(),
                                style: TextStyle(
                                  color: Colors.yellow[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const ProductAddScreen();
              },
            ),
          );
        },
        child: const Icon(Icons.add_rounded),
      ),
      bottomNavigationBar: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(10),
        child: const Text(
          '@copyrigth 2024 by Moh Rifkan',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
