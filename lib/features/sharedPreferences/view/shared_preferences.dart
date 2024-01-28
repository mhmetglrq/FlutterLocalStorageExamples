import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_storage/features/sharedPreferences/repository/shared_preferences_repository.dart';

import '../controller/shared_preferences_controller.dart';

class SharedPreferencesPage extends ConsumerStatefulWidget {
  const SharedPreferencesPage({super.key});

  @override
  ConsumerState<SharedPreferencesPage> createState() =>
      _SharedPreferencesPageState();
}

class _SharedPreferencesPageState extends ConsumerState<SharedPreferencesPage> {
  final Map<String, dynamic> _data = {};
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    var futureProviderValue = ref.watch(getStringProvider('key'));
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('SharedPreferences'),
                futureProviderValue.when(
                  data: (data) => Text(data!),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, stackTrace) => Text(error.toString()),
                ),
                FutureBuilder<String?>(
                    future: ref
                        .read(sharedPreferencesControllerProvider)
                        .getString(_data['key'] ?? ""),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data!);
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else {
                        return Text(snapshot.error.toString());
                      }
                    }),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _data['key'] = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Key',
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _data['value'] = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Value',
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      debugPrint(_data['key']);
                      debugPrint(_data['value']);

                      ref
                          .read(sharedPreferencesControllerProvider)
                          .saveString(
                            _data['key'],
                            _data['value'],
                          )
                          .then(
                              (value) => ref.refresh(getStringProvider("key")));
                    },
                    child: const Text('Save'),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      ref
                          .read(sharedPreferencesControllerProvider)
                          .remove(
                            "key",
                          )
                          .whenComplete(
                            () => ref
                                .refresh(sharedPreferencesControllerProvider)
                                .getString(_data['key']),
                          );
                    },
                    child: const Text('Remove'),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      ref.read(sharedPreferencesControllerProvider).clear();
                      await ref
                          .refresh(sharedPreferencesControllerProvider)
                          .getString(_data['key']);
                    },
                    child: const Text('Clear'),
                  ),
                ),
                CheckboxListTile(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                  title: const Text('Checkbox'),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      ref
                          .read(sharedPreferencesControllerProvider)
                          .saveBool(
                            'checkbox',
                            isChecked,
                          )
                          .whenComplete(
                            () => ref
                                .refresh(sharedPreferencesControllerProvider)
                                .getBool('checkbox'),
                          );
                    },
                    child: const Text('Save Checkbox'),
                  ),
                ),
                StreamBuilder<bool?>(
                  stream: ref
                      .read(sharedPreferencesControllerProvider)
                      .getBool('checkbox')
                      .asStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data.toString());
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else {
                      return Text(snapshot.error.toString());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
