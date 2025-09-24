import 'package:family_health_record/viewModels/create_role_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CreateRoleScreen extends StatelessWidget {
  const CreateRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CreateRoleViewModel>();
    final Map<String, dynamic> errors = viewModel.errors['errors'] ?? {};
    final String message = viewModel.errors['message'] ?? '';

    return Scaffold(
      appBar: AppBar(title: Text("Create Role")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 16.0,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: viewModel.nameController,
                decoration: InputDecoration(
                  icon: const Icon(Icons.person_4),
                  border: OutlineInputBorder(),
                  labelText: 'Role Name (Required)',
                  errorText: errors['name']?[0].toString(),
                ),
              ),
              FilledButton(
                onPressed: !viewModel.isLoading
                    ? () async {
                        final result = await viewModel.createRole();

                        if (result) {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Create role successfully!'),
                            ),
                          );

                          if (!context.mounted) return;
                          context.pop();
                        }

                        if (message.isNotEmpty && errors.isEmpty) {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to create role $message'),
                            ),
                          );
                        }
                      }
                    : null,
                child: Row(
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: !viewModel.isLoading
                      ? const [Icon(Icons.add), Text('Create Role')]
                      : const [CircularProgressIndicator()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
