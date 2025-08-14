import 'package:family_health_record/managers/auth_token_manager.dart';
import 'package:family_health_record/models/groups/group.dart';
import 'package:family_health_record/viewModels/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(radius: 15, child: Icon(Icons.person)),
          ),
        ],
        title: Row(
          children: [
            Icon(Icons.note_add_rounded),
            const SizedBox(width: 8),
            const Text(
              'HEALTHCORD',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Flexible(
              child: RefreshIndicator(
                onRefresh: () async {
                  await viewModel.refreshGroups();
                },
                child: ListView.builder(
                  controller: viewModel.scrollController,
                  itemCount: viewModel.groups.length,
                  itemBuilder: (context, index) {
                    final group = viewModel.groups[index];

                    if (index == 0) {
                      return Column(
                        children: [
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.waving_hand_rounded,
                                        size: 100,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Welcome back, Mint',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineLarge,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'How are you doing today?',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          groupCard(context, group, index),
                        ],
                      );
                    }

                    if (index == viewModel.groups.length - 1 &&
                        viewModel.isLoading) {
                      return Column(
                        children: [
                          groupCard(context, group, index),
                          const Center(child: CircularProgressIndicator()),
                        ],
                      );
                    }

                    return groupCard(context, group, index);
                  },
                  physics: const AlwaysScrollableScrollPhysics(),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                useSafeArea: true,
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.group_add),
                          title: const Text('Create New Group'),
                          onTap: () {
                            context.pushNamed('createGroupScreen');
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.group_rounded),
                          title: const Text('Join Existing Group'),
                          onTap: () {
                            context.pushNamed('joinGroupScreen');
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }

  Widget groupCard(BuildContext context, Group group, int index) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      surfaceTintColor:
          HomeViewModel.colorPool[index % HomeViewModel.colorPool.length],
      child: InkWell(
        onTap: () {},
        splashColor: Colors.white30,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Positioned(
              bottom: -35,
              right: -20,
              child: Opacity(
                opacity: 0.4,
                child: Icon(
                  HomeViewModel.iconPool[index % HomeViewModel.iconPool.length],
                  color: Colors.white,
                  size: 100,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (group.groupProfile != null)
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            group.groupProfile!,
                            headers: {
                              'Content-Type': 'application/json',
                              'Authorization':
                                  'Bearer ${context.read<AuthTokenManager>().authToken?.accessToken}',
                            },
                          ),
                        )
                      else
                        const CircleAvatar(child: Icon(Icons.group)),
                      IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Text(
                    group.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    group.description ?? 'No description',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
