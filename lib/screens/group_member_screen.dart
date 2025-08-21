import 'package:family_health_record/managers/auth_token_manager.dart';
import 'package:family_health_record/viewModels/group_member_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupMemberScreen extends StatelessWidget {
  const GroupMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<GroupMemberViewModel>();
    final authTokenManager = context.read<AuthTokenManager>();

    if (viewModel.isLoading && viewModel.members.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: () async {
        await viewModel.refreshGroupMembers();
      },
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: viewModel.scrollController,
        itemBuilder: (context, index) {
          final member = viewModel.members[index];
          return ListTile(
            title: Row(
              spacing: 5.0,
              children: [
                SelectableText('${member.firstname} ${member.lastname}'),
                ?member.id == authTokenManager.user?.id ? Text('(You)') : null,
                Badge(label: Text(member.roles![0].name)),
              ],
            ),
            subtitle: SelectableText(member.email),
            leading: CircleAvatar(
              backgroundImage: member.profile != null
                  ? NetworkImage(member.profile!)
                  : null,
              child: Icon(Icons.person),
            ),
            trailing: PopupMenuButton(
              itemBuilder: (context) {
                return [
                  if (viewModel.hasPermission('group-user.delete') &&
                      member.id != authTokenManager.user?.id &&
                      member.roles![0].name != 'Owner')
                    PopupMenuItem(
                      value: 'remove-from-group',
                      child: Text('Remove from Group'),
                    ),
                ];
              },
              onSelected: (value) async {},
            ),
          );
        },
        itemCount: viewModel.members.length,
      ),
    );
  }
}
