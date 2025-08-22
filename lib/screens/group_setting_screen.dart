import 'package:family_health_record/managers/auth_token_manager.dart';
import 'package:family_health_record/viewModels/group_setting_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class GroupSettingScreen extends StatelessWidget {
  const GroupSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<GroupSettingViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text('Group Setting')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
            ],
          ),
        ),
      ),
    );
  }
}
