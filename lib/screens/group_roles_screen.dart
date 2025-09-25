import 'package:family_health_record/viewModels/group_roles_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class GroupRolesScreen extends StatelessWidget {
  const GroupRolesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<GroupRolesViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Group Roles')),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: RefreshIndicator(
                onRefresh: () async {
                  await viewModel.fetchRoles();
                },
                child: CustomScrollView(
                  slivers: [
                    SliverList.builder(
                      itemCount: viewModel.roles.length,
                      itemBuilder: (context, index) {
                        final role = viewModel.roles[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            tileColor: Theme.of(
                              context,
                            ).colorScheme.surfaceContainerLowest,
                            leading: const Icon(
                              Icons.health_and_safety_rounded,
                            ),
                            title: Text(role.name),
                            subtitle: Text(
                              'Permissions granted: ${role.permissions.length}',
                            ),
                            onTap: () {
                              context.pushNamed(
                                "groupRolePermissionsScreen",
                                extra: {'group': viewModel.group, 'role': role},
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final bool? shouldRefresh = await context.pushNamed<bool>(
            'createRoleScreen',
            extra: {'group': viewModel.group},
          );

          if (shouldRefresh == true) {
            await viewModel.fetchRoles();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
