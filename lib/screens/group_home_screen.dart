import 'package:family_health_record/viewModels/group_home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class GroupHomeScreen extends StatelessWidget {
  const GroupHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<GroupHomeViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(
                'groupSettingScreen',
                extra: {'group': viewModel.group},
              );
            },
            icon: Icon(Icons.settings),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            context.goNamed('homeScreen');
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: MaterialBanner(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            Icon(Icons.warning_rounded),
            Text("This group is archived. It is now in read-only mode."),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.errorContainer,
        actions: [SizedBox.shrink()],
      ),
    );
  }
}
