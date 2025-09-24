import 'package:family_health_record/enums/role_type.dart';
import 'package:family_health_record/viewModels/group_role_permissions_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupRolePermissionsScreen extends StatelessWidget {
  const GroupRolePermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<GroupRolePermissionsViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Role Permissions'), actions: []),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsetsGeometry.all(16),
              itemCount: viewModel.permissions.length,
              itemBuilder: (context, index) {
                final kind = viewModel.permissions.keys.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: ExpansionTile(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerLowest,
                    collapsedBackgroundColor: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerLowest,
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    childrenPadding: EdgeInsets.symmetric(vertical: 8),
                    maintainState: true,
                    title: Text(kind),
                    initiallyExpanded: viewModel.permissions[kind]!.isNotEmpty,
                    children: [
                      for (final permission in viewModel.permissions[kind]!)
                        SwitchListTile(
                          title: Text(
                            permission.name,
                            style: TextStyle(overflow: TextOverflow.ellipsis),
                          ),
                          subtitle: Text(
                            permission.description,
                            style: TextStyle(overflow: TextOverflow.ellipsis),
                          ),
                          value: viewModel.selectedPermissions.contains(
                            permission.id,
                          ),
                          onChanged: viewModel.role.type == RoleType.custom
                              ? (value) {
                                  viewModel.togglePermission(permission);
                                }
                              : null,
                        ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: Visibility(
        visible: viewModel.role.type == RoleType.custom,
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: false,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.undo_rounded),
                ),
              ),
              Visibility(
                visible: viewModel.role.type == RoleType.custom,
                child: FilledButton(
                  onPressed: () async {
                    if (await viewModel.saveChanges()) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Changes saved successfully'),
                        ),
                      );
                      return;
                    }

                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Failed to save changes')),
                    );
                  },
                  child: Row(
                    spacing: 6,
                    children: [
                      const Icon(Icons.save),
                      const Text('Save Changes'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
