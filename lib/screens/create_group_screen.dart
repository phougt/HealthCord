import 'dart:io';
import 'package:family_health_record/viewModels/create_group_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CreateGroupScreen extends StatelessWidget {
  const CreateGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CreateGroupViewModel>();
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
              GestureDetector(
                onTap: () {
                  viewModel.pickGroupProfile();
                },
                child: Column(
                  spacing: 8.0,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      child: viewModel.groupProfile == null
                          ? const Icon(Icons.add_a_photo, size: 40)
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.file(
                                File(viewModel.groupProfile!.path),
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                            ),
                    ),
                    Text(
                      'Tap to select group image',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    Text(viewModel.groupProfile?.name ?? 'No image selected'),
                  ],
                ),
              ),
              TextField(
                controller: viewModel.groupNameController,
                decoration: InputDecoration(
                  icon: const Icon(Icons.group_rounded),
                  border: OutlineInputBorder(),
                  labelText: 'Group Name (Required)',
                  errorText: errors['name']?[0].toString(),
                ),
              ),
              TextField(
                controller: viewModel.groupDescriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  icon: const Icon(Icons.description),
                  border: OutlineInputBorder(),
                  labelText: 'Group Description',
                  errorText: errors['description']?[0].toString(),
                ),
              ),
              FilledButton(
                onPressed: () async {
                  if (await viewModel.createGroup()) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Group created successfully!'),
                      ),
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
                  children: const [
                    Icon(Icons.add_circle_outline),
                    Text('Create Group'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
