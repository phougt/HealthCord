import 'package:family_health_record/managers/session_manager.dart';
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
    final authTokenManager = context.watch<SessionManager>();

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              radius: 18,
              child: authTokenManager.user?.profile != null
                  ? Image.network(
                      authTokenManager.user?.profile ?? '',
                      headers: {
                        'Content-Type': 'application/json',
                        'Authorization':
                            'Bearer ${authTokenManager.authToken?.accessToken}',
                      },
                    )
                  : const Icon(Icons.person, size: 25),
            ),
          ),
        ],
        title: Row(
          children: [
            Icon(
              Icons.note_add_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Text(
              'HealthCord',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
      body:
          viewModel.unarchivedGroups.isEmpty &&
              viewModel.archivedGroups.isEmpty &&
              !viewModel.isLoading
          ? Stack(
              children: [
                Positioned(
                  right: 0,
                  bottom: 110,
                  child: Icon(
                    Icons.arrow_downward_rounded,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    size: 80,
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/empty.png', height: 150),
                      const Text(
                        'No groups found.\nClick the "+" button to create or join a group.',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        clipBehavior: Clip.hardEdge,
                        color: Theme.of(context).colorScheme.primaryContainer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/family.png',
                                fit: BoxFit.cover,
                                scale: 2.5,
                              ),
                              Text(
                                'Welcome back, ${authTokenManager.user?.firstname ?? 'User'}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          spacing: 8,
                          children: [
                            ChoiceChip(
                              label: Text("Unarchived"),
                              selected: !viewModel.isArchived,
                              onSelected: (value) {
                                viewModel.isArchived = false;
                                viewModel.refreshGroups();
                              },
                            ),
                            ChoiceChip(
                              label: Text("Archived"),
                              selected: viewModel.isArchived,
                              onSelected: (value) {
                                viewModel.isArchived = true;
                                viewModel.refreshGroups();
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          spacing: 8,
                          children: [
                            Icon(
                              Icons.group_rounded,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            Text(
                              viewModel.isArchived ? "Archived" : "Unarchived",
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await viewModel.refreshGroups();
                      },
                      child: ListView.builder(
                        controller: viewModel.scrollController,
                        itemCount: viewModel.isArchived
                            ? viewModel.archivedGroups.length
                            : viewModel.unarchivedGroups.length,
                        itemBuilder: (context, index) {
                          final Group group;
                          if (viewModel.isArchived) {
                            group = viewModel.archivedGroups[index];
                          } else {
                            group = viewModel.unarchivedGroups[index];
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
                showDragHandle: true,
                useSafeArea: true,
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          leading: const Icon(Icons.group_add),
                          title: const Text('Create New Group'),
                          onTap: () {
                            context.pushNamed('createGroupScreen');
                          },
                        ),
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
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
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      surfaceTintColor:
          HomeViewModel.colorPool[index % HomeViewModel.colorPool.length],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: InkWell(
        onTap: () {
          context.pushNamed('groupHomeScreen', extra: {'groupId': group.id});
        },
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          leading: group.groupProfile != null && group.groupProfile!.isNotEmpty
              ? Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      group.groupProfile!,
                      headers: {
                        'Content-Type': 'application/json',
                        'Authorization':
                            'Bearer ${context.read<SessionManager>().authToken?.accessToken}',
                      },
                    ),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    child: Text(
                      group.name.length > 1
                          ? group.name[0].toUpperCase() +
                                group.name[1].toUpperCase()
                          : group.name[0].toUpperCase(),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
          title: Text(
            "${group.isArchived ? '⚠️ Archived - ' : ''}${group.name}",
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            group.description == null || group.description!.isEmpty
                ? 'No description provided'
                : group.description!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
