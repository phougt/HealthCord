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
              context.pushNamed('groupSettingScreen', extra: viewModel.groupId);
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
      body: Center(
        child: Text(
          'Group Home Screen',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
