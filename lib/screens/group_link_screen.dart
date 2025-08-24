import 'package:family_health_record/models/group_links/group_link.dart';
import 'package:family_health_record/viewModels/group_link_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class GroupLinkScreen extends StatelessWidget {
  const GroupLinkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<GroupLinkViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Group Links')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Visibility(
            visible: viewModel.hasPermission('invite-link.create'),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FilledButton(
                onPressed: !viewModel.isLoading
                    ? () async {
                        final result = await viewModel.generateNewLink();
                        viewModel.refreshGroupLinks();

                        if (result) {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("New link generated successfully"),
                            ),
                          );
                        }
                      }
                    : null,
                child: viewModel.isLoading
                    ? CircularProgressIndicator()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 6,
                        children: [
                          Icon(Icons.add_link_rounded, size: 24),
                          const Text('Generate New Link'),
                        ],
                      ),
              ),
            ),
          ),
          Flexible(
            child: RefreshIndicator(
              onRefresh: () async {
                await viewModel.refreshGroupLinks();
              },
              child: ListView.builder(
                itemCount: viewModel.groupLinks.length,
                controller: viewModel.scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final link = viewModel.groupLinks[index];
                  return ListTile(
                    leading: CircleAvatar(child: Icon(Icons.link)),
                    title: SelectableText(link.link),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.copy),
                          onPressed: () async {
                            await Clipboard.setData(
                              ClipboardData(text: link.link),
                            );
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Link copied to clipboard'),
                              ),
                            );
                          },
                        ),
                        Visibility(
                          visible: viewModel.hasPermission(
                            'invite-link.delete',
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.delete_outline_rounded,
                              size: 30,
                              color: Theme.of(context).colorScheme.error,
                            ),
                            onPressed: () async {
                              _showDeleteConfirmationDialog(
                                context,
                                viewModel,
                                link,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _showDeleteConfirmationDialog(
  BuildContext context,
  GroupLinkViewModel viewModel,
  GroupLink link,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Delete Link'),
        content: Text('Are you sure you want to delete this link?'),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final result = await viewModel.revokeLink(link.id);

              if (result) {
                if (!context.mounted) return;
                viewModel.refreshGroupLinks();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Link deleted successfully")),
                );
                context.pop();
                return;
              }

              if (!context.mounted) return;
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Failed to delete link")));
              context.pop();
            },
            child: Text(
              'Delete',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      );
    },
  );
}
