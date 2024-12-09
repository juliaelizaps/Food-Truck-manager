import 'package:flutter/material.dart';
import 'package:gf/src/shared/colors/colors.dart';

class ActivityList extends StatelessWidget {
  const ActivityList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 1,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const CircleAvatar(
            backgroundColor: AppColors.initialPageBackground,
            child: Icon(Icons.event, color: Colors.white),
          ),
          title: const Text('Atividade'),
          subtitle: Text('Exemplo de atividade ${index + 1}'),
          trailing: const Icon(Icons.badge_outlined, size: 16),
        );
      },
    );
  }
}
