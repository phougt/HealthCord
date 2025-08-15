import 'package:family_health_record/viewModels/group_home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupHomeScreen extends StatelessWidget {
  const GroupHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<GroupHomeViewModel>();

    return Center(
      child: Text(
        'Group Home Screen',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
