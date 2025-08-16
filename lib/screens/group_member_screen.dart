import 'package:family_health_record/viewModels/group_member_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupMemberScreen extends StatelessWidget {
  const GroupMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<GroupMemberViewModel>();

    if (viewModel.isLoading && viewModel.members.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: () async {
        await viewModel.refreshGroupMembers();
      },
      child: ListView.builder(
        itemBuilder: (context, index) {
          final member = viewModel.members[index];
          return ListTile(
            title: SelectableText('${member.firstname} ${member.lastname}'),
            subtitle: SelectableText(member.email),
            leading: CircleAvatar(
              backgroundImage: member.profile != null
                  ? NetworkImage(member.profile!)
                  : null,
              child: Icon(Icons.person),
            ),
            trailing: member.roles?.length == 1
                ? Badge(label: Text(member.roles![0].name))
                : null,
          );
        },
        itemCount: viewModel.members.length,
      ),
    );
  }
}
