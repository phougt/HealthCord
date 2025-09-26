import 'package:family_health_record/enums/role_type.dart';
import 'package:family_health_record/models/roles/role.dart';
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
                            trailing: Visibility(
                              visible: role.type == RoleType.custom,
                              child: PopupMenuButton(
                                icon: Icon(Icons.more_vert_rounded),
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                      value: 1,
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.error,
                                        ),
                                      ),
                                      onTap: () {
                                        _showDeleteDialog(
                                          context,
                                          viewModel: viewModel,
                                          role: role,
                                        );
                                      },
                                    ),
                                  ];
                                },
                              ),
                            ),
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

  void _showDeleteDialog(
    BuildContext context, {
    required GroupRolesViewModel viewModel,
    required Role role,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Role'),
          content: Text('Are you sure you want to delete this role?'),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                final bool result = await viewModel.deleteRole(role.id);
                if (result) {
                  if (!context.mounted) return;
                  context.pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Role deleted successfully')),
                  );
                  return;
                }

                if (!context.mounted) return;
                context.pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to delete role')),
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
