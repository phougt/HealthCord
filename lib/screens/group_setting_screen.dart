import 'dart:io';

import 'package:family_health_record/enums/role_type.dart';
import 'package:family_health_record/viewModels/group_setting_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class GroupSettingScreen extends StatelessWidget {
  const GroupSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<GroupSettingViewModel>();
    final errors = viewModel.errors['errors'] ?? {};

    return Scaffold(
      appBar: AppBar(
        title: Text('Group Setting'),
        leading: Visibility(
          visible: context.canPop(),
          child: IconButton(
            onPressed: () {
              if (viewModel.isChanged) {
                _showUnsavedChangesDialog(context);
                return;
              }
              context.pop();
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        actions: [
          Visibility(
            visible: viewModel.hasPermission('group.update'),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FilledButton(
                onPressed: !viewModel.isLoading
                    ? () async {
                        if (await viewModel.updateGroupDetails()) {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Group updated successfully!'),
                            ),
                          );

                          if (!context.mounted) return;
                          context.pop();
                        }
                      }
                    : null,
                child: Row(
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: !viewModel.isLoading
                      ? const [Icon(Icons.check), Text('Update')]
                      : const [CircularProgressIndicator()],
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            spacing: 14.0,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: viewModel.hasPermission('group.update')
                    ? () {
                        viewModel.pickGroupProfile();
                      }
                    : null,
                child: Column(
                  spacing: 8.0,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: viewModel.groupProfile == null
                          ? viewModel.group.groupProfile == null
                                ? null
                                : NetworkImage(
                                    viewModel.group.groupProfile!,
                                    headers: {
                                      'Authorization':
                                          'Bearer ${viewModel.authToken?.accessToken}',
                                      'Content-Type': 'application/json',
                                    },
                                  )
                          : FileImage(File(viewModel.groupProfile!.path)),
                      child: Visibility(
                        visible:
                            viewModel.groupProfile == null &&
                            viewModel.group.groupProfile == null,
                        child: const Icon(Icons.add_a_photo, size: 40),
                      ),
                    ),
                    Visibility(
                      visible: viewModel.hasPermission('group.update'),
                      child: Text(
                        'Tap to select group image',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
              ),
              TextField(
                readOnly: !viewModel.hasPermission('group.update'),
                controller: viewModel.groupNameController,
                decoration: InputDecoration(
                  suffixIcon: Visibility(
                    visible: viewModel.hasPermission('group.update'),
                    child: IconButton(
                      onPressed: () {
                        viewModel.undoName();
                      },
                      icon: Icon(Icons.undo_rounded),
                    ),
                  ),
                  icon: const Icon(Icons.group_rounded),
                  border: OutlineInputBorder(),
                  labelText: 'Group Name (Required)',
                  errorText: errors['name']?[0].toString(),
                ),
              ),
              TextField(
                readOnly: !viewModel.hasPermission('group.update'),
                controller: viewModel.groupDescriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  suffixIcon: Visibility(
                    visible: viewModel.hasPermission('group.update'),
                    child: IconButton(
                      onPressed: () {
                        viewModel.undoDescription();
                      },
                      icon: Icon(Icons.undo_rounded),
                    ),
                  ),
                  icon: const Icon(Icons.description),
                  border: OutlineInputBorder(),
                  labelText: 'Group Description',
                  errorText: errors['description']?[0].toString(),
                ),
              ),
              Visibility(
                visible:
                    viewModel.hasPermission('invite-link.read') ||
                    viewModel.hasPermission('invite-link.delete') ||
                    viewModel.hasPermission('invite-link.create'),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  leading: Icon(Icons.link),
                  title: Text('Group Links'),
                  tileColor: Theme.of(context).colorScheme.surfaceContainer,
                  onTap: () {
                    context.pushNamed('groupLinkScreen');
                  },
                ),
              ),
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                leading: Icon(Icons.people_alt_rounded),
                title: Text('Members'),
                tileColor: Theme.of(context).colorScheme.surfaceContainer,
                onTap: () {
                  context.pushNamed('groupMembersScreen');
                },
              ),
              Visibility(
                visible: !viewModel.hasRoleType(RoleType.owner),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error,
                  ),
                  onPressed: () async {
                    _showLeaveGroupConfirmationDialog(context, () async {
                      if (await viewModel.leaveGroup()) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Leave group successfully!'),
                          ),
                        );

                        if (!context.mounted) return;
                        context.goNamed('homeScreen');
                        return;
                      }

                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("You can not leave the group")),
                      );
                    });
                  },
                  child: Row(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.exit_to_app), Text('Leave Group')],
                  ),
                ),
              ),
              Visibility(
                visible:
                    viewModel.hasRoleType(RoleType.owner) &&
                    !viewModel.group.isArchived,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error,
                  ),
                  onPressed: () async {
                    _showArchiveGroupConfirmationDialog(context, () async {
                      if (await viewModel.archiveGroup()) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Archive group successfully!'),
                          ),
                        );

                        if (!context.mounted) return;
                        context.goNamed('homeScreen');
                        return;
                      }

                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("You can not archive the group"),
                        ),
                      );
                    });
                  },
                  child: Row(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.exit_to_app), Text('Archive Group')],
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

void _showUnsavedChangesDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Unsaved Changes'),
        content: Text('You have unsaved changes. Do you want to discard them?'),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () {
              context.pop();
              context.pop();
            },
            child: Text('Discard'),
          ),
        ],
      );
    },
  );
}

void _showLeaveGroupConfirmationDialog(BuildContext context, Function onLeave) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Leave Group'),
        content: Text('Are you sure you want to leave this group?'),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () {
              context.pop();
              onLeave();
            },
            child: Text('Leave'),
          ),
        ],
      );
    },
  );
}

void _showArchiveGroupConfirmationDialog(
  BuildContext context,
  Function onArchive,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Archive Group'),
        content: Text(
          'Are you sure you want to archive this group?\n\nYou can always unarchive it later.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () {
              context.pop();
              onArchive();
            },
            child: Text('Archive'),
          ),
        ],
      );
    },
  );
}
