import 'package:family_health_record/providers/auth_providers.dart';
import 'package:family_health_record/providers/group_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(
                'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%2Fid%2FOIP.DfuDfy1kQU-7G1afBzRZ7QHaHa%3Fpid%3DApi&f=1&ipt=9a5bb35e3eabeb94be970965604ce7250fa506b7d37b3a90231de53c6df35a1e', // Replace with actual profile image URL
              ),
            ),
          ),
        ],
        title: Row(
          children: [
            Icon(Icons.book),
            const SizedBox(width: 8),
            const Text(
              'HealthCord',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        forceMaterialTransparency: true,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(groupViewModelProvider);
          final groupViewModel = ref.read(groupViewModelProvider.notifier);

          return state.when(
            data: (void data) {
              if (ref.read(groupViewModelProvider.notifier).groups.isEmpty) {
                return const Center(child: Text('No groups found'));
              }

              return RefreshIndicator(
                child: ListView.builder(
                  controller: groupViewModel.scrollController,
                  itemCount: groupViewModel.groups.length,
                  itemBuilder: (context, index) {
                    final group = groupViewModel.groups[index];
                    return Card(
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        titleTextStyle: Theme.of(context)
                            .listTileTheme
                            .titleTextStyle
                            ?.copyWith(fontWeight: FontWeight.bold),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        title: Text(group.name, maxLines: 1),
                        subtitle: Text(
                          group.description ?? 'No description',
                          maxLines: 2,
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            group.groupProfile ??
                                'https://via.placeholder.com/150',
                            headers: {
                              'Content-Type': 'application/json',
                              'Authorization':
                                  'Bearer ${ref.read(authTokenProvider).value?.accessToken}',
                            },
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {},
                        ),
                        onTap: () {},
                      ),
                    );
                  },
                ),
                onRefresh: () async {
                  await ref
                      .read(groupViewModelProvider.notifier)
                      .refreshGroups();
                },
              );
            },
            error: (error, stackTrace) {
              return Center(child: Text('Error: $error'));
            },
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
