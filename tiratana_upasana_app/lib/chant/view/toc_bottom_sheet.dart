import 'package:flutter/material.dart';
import 'package:tiratana_upasana_app/chant/models/chant.dart';

class TocBottomSheet extends StatefulWidget {
  const TocBottomSheet({
    required this.currentChant,
    required this.chants,
    super.key,
  });

  final Chant currentChant;
  final List<Chant> chants;

  @override
  State<TocBottomSheet> createState() => _TocBottomSheetState();
}

class _TocBottomSheetState extends State<TocBottomSheet>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      animationController: BottomSheet.createAnimationController(this),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Table of Content',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  children: [
                    for (final chant in widget.chants)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          title: Text(chant.defaultContent.title),
                          selected: chant == widget.currentChant,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60),
                            side: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(
                              context,
                              (chant.id == widget.currentChant.id)
                                  ? null
                                  : chant,
                            );
                          },
                          trailing: (chant == widget.currentChant)
                              ? const Icon(Icons.check_rounded)
                              : null,
                          dense: true,
                        ),
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
