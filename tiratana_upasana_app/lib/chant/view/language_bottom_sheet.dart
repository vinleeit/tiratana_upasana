import 'package:flutter/material.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({
    required this.currentIso,
    required this.isos,
    super.key,
  });

  final String currentIso;
  final List<String> isos;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Current language:',
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              currentIso,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          const Icon(
                            Icons.check_rounded,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  children: [
                    for (final iso in isos)
                      ListTile(
                        title: Text(iso),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60),
                          side: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context, iso);
                        },
                        dense: true,
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
