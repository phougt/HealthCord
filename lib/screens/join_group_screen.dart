import 'package:family_health_record/viewModels/join_group_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class JoinGroupScreen extends StatelessWidget {
  const JoinGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<JoinGroupViewModel>();
    final Map<String, dynamic> errors = viewModel.errors['errors'] ?? {};
    final String message = viewModel.errors['message'] ?? '';

    return Scaffold(
      appBar: AppBar(title: const Text('Join Group')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 16.0,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: viewModel.groupLinkController,
                decoration: InputDecoration(
                  icon: const Icon(Icons.group_rounded),
                  border: OutlineInputBorder(),
                  labelText: 'Group Link/Code (Required)',
                  errorText: errors['invite_link']?[0].toString(),
                ),
              ),
              Text(
                'Enter the group link or code provided by the group owner.',
                style: TextStyle(color: Colors.grey[600]),
              ),
              Text(
                'Note:\n- Ensure the link is valid.\n- The group code is consisted of 10 characters.\n- It should be a combination of lower-case letters and numbers.',
                style: TextStyle(color: Colors.grey[600]),
              ),
              FilledButton(
                onPressed: viewModel.isLoading
                    ? null
                    : () async {
                        final result = await viewModel.joinGroup();

                        if (result) {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Join group successfully!'),
                            ),
                          );

                          if (!context.mounted) return;
                          context.pop();
                          return;
                        }

                        if (message.isNotEmpty && errors.isEmpty) {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(message)));
                        }
                      },
                child: viewModel.isLoading
                    ? const CircularProgressIndicator()
                    : Row(
                        spacing: 5,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [Icon(Icons.group), Text('Join Group')],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
