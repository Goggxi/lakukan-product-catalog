import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.grey[200],
            scrolledUnderElevation: 0,
            expandedHeight: 300,
            automaticallyImplyLeading: false,
            leading: Row(
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: Material(
                    color: Colors.white,
                    shape: const CircleBorder(),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
            flexibleSpace: Stack(
              children: [
                FlexibleSpaceBar(
                  background: PageView.builder(
                    itemBuilder: (context, index) {
                      return Image.network(
                        'https://cdn.dummyjson.com/product-images/4/thumbnail.jpg',
                        fit: BoxFit.cover,
                      );
                    },
                    itemCount: 3,
                  ),
                ),
                Positioned(
                  bottom: -1,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(
                        color: Colors.grey[200]!,
                      ),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Product Name',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Product Description',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
