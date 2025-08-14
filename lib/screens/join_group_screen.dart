import 'package:family_health_record/viewModels/join_group_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class JoinGroupScreen extends StatelessWidget {
  const JoinGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<JoinGroupViewModel>();
    final errors = viewModel.errors['errors'] ?? {};
    final message = viewModel.errors['message'] ?? '';

    return Scaffold(
      appBar: AppBar(title: const Text('Create Group')),
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
              FilledButton(
                onPressed: () async {
                  if (await viewModel.joinGroup()) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Join group successfully!')),
                    );

                    Future.delayed(const Duration(seconds: 3), () {
                      if (!context.mounted) return;
                      context.pop();
                    });
                  }
                },
                child: Row(
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
