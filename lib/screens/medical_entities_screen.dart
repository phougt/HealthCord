import 'package:family_health_record/viewModels/medical_entities_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicalEntitiesScreen extends StatelessWidget {
  const MedicalEntitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MedicalEntitiesViewModel>();

    if (viewModel.isLoading &&
        viewModel.doctors.isEmpty &&
        viewModel.hospitals.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          viewModel.refreshEntities();
        },
        child: ListView.builder(
          itemCount: viewModel.doctors.length + viewModel.hospitals.length,
          itemBuilder: (context, index) {
            if (index < viewModel.doctors.length) {
              final doctor = viewModel.doctors[index];
              return ListTile(
                title: Row(
                  spacing: 8,
                  children: [
                    Text(doctor.name, overflow: TextOverflow.ellipsis),
                    Badge(
                      label: Text('Doctor'),
                      backgroundColor: Theme.of(context).colorScheme.tertiary,
                    ),
                  ],
                ),
                leading: CircleAvatar(child: Icon(Icons.person_4_rounded)),
              );
            } else {
              final hospital =
                  viewModel.hospitals[index - viewModel.doctors.length];
              return ListTile(
                title: Row(
                  spacing: 8,
                  children: [
                    Text(hospital.name, overflow: TextOverflow.ellipsis),
                    Badge(label: Text('Hospital')),
                  ],
                ),
                leading: CircleAvatar(child: Icon(Icons.maps_home_work)),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            showDragHandle: true,
            useSafeArea: true,
            context: context,
            builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.person_4_rounded),
                    title: const Text('Add Doctor'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.home_work_rounded),
                    title: const Text('Add Hospital'),
                    onTap: () {},
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
