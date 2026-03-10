import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/marketplace_provider.dart';

class MarketplaceScreen extends ConsumerWidget {
  const MarketplaceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tradeItemsAsync = ref.watch(tradeItemsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Barter Marketplace'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Navigate to add item screen
            },
          ),
        ],
      ),
      body: tradeItemsAsync.when(
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text("No items available for trade yet."));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(12),
                          image: item.imageUrl != null
                              ? DecorationImage(
                                  image: NetworkImage(item.imageUrl!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: item.imageUrl == null
                            ? const Icon(Icons.eco, color: Colors.green)
                            : null,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.itemName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text('By ${item.authorName} • ${item.location}', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                // TODO: View Details / Request Trade
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                minimumSize: Size.zero,
                              ),
                              child: const Text('Request Trade'),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
