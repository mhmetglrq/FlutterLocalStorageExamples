import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_storage/features/hive/controller/hive_controller.dart';

class HivePage extends ConsumerStatefulWidget {
  const HivePage({super.key});

  @override
  ConsumerState<HivePage> createState() => _HivePageState();
}

class _HivePageState extends ConsumerState<HivePage> {
  String value = "";
  String updateValue = "";
  String key = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Text("değer: $value"),
              TextField(
                onChanged: (value) => key = value,
                decoration: const InputDecoration(
                  labelText: 'Key',
                ),
              ),
              TextField(
                onChanged: (value) => updateValue = value,
                decoration: const InputDecoration(
                  labelText: 'Value',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      ref.read(hiveControllerProvider).add(key, updateValue);
                    },
                    child: const Text('Add'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(hiveControllerProvider).get(key).then((value) {
                        setState(() {
                          this.value = value;
                        });
                      });
                    },
                    child: const Text('Get'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(hiveControllerProvider)
                          .update('key', updateValue);
                    },
                    child: const Text('Update'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(hiveControllerProvider).delete('key');
                    },
                    child: const Text('Delete'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
