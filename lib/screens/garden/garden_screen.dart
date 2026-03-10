import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/plant_provider.dart';

class GardenScreen extends ConsumerWidget {
  const GardenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plantsAsync = ref.watch(userPlantsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Garden'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Navigate to add plant screen
            },
          ),
        ],
      ),
      body: plantsAsync.when(
        data: (plants) {
          if (plants.isEmpty) {
            return const Center(child: Text("Your garden is empty. Add a plant!"));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemCount: plants.length,
            itemBuilder: (context, index) {
              final plant = plants[index];
              return Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: plant.photoUrl != null
                          ? Image.network(plant.photoUrl!, fit: BoxFit.cover)
                          : Container(color: Colors.grey[200], child: const Icon(Icons.yard, size: 50, color: Colors.grey)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(plant.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Text(plant.growthStage, style: TextStyle(color: Colors.green[700], fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Add Plant
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
