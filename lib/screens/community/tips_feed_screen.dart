import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/community_provider.dart';
import 'package:intl/intl.dart';

class TipsFeedScreen extends ConsumerWidget {
  const TipsFeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsync = ref.watch(communityPostsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Tips'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Navigate to create post screen
            },
          ),
        ],
      ),
      body: postsAsync.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const Center(child: Text("No tips yet. Share the first one!"));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: post.authorPhotoUrl != null ? NetworkImage(post.authorPhotoUrl!) : null,
                        child: post.authorPhotoUrl == null ? const Icon(Icons.person) : null,
                      ),
                      title: Text(post.authorName, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(DateFormat.yMMMd().format(post.timestamp)),
                    ),
                    if (post.imageUrl != null)
                      Image.network(post.imageUrl!, height: 200, fit: BoxFit.cover),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(post.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(post.description),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.favorite_border),
                            onPressed: () {
                              // TODO: Like logic
                            },
                          ),
                          Text('${post.likes.length} likes'),
                        ],
                      ),
                    )
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
           // TODO: Implement Create Post
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
