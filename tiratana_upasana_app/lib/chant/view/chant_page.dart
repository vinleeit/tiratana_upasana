import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:tiratana_upasana_app/chant/models/chant.dart';
import 'package:tiratana_upasana_app/chant/view/language_bottom_sheet.dart';
import 'package:tiratana_upasana_app/chant/view/toc_bottom_sheet.dart';
import 'package:tiratana_upasana_app/widgets/unimplemented_feature_alert_dialog.dart';

class ChantPage extends StatefulWidget {
  const ChantPage({super.key});

  @override
  State<ChantPage> createState() => _ChantPageState();
}

class _ChantPageState extends State<ChantPage> {
  int currentChantIndex = 0;

  @override
  Widget build(BuildContext context) {
    final currentChant = chants[currentChantIndex];
    final currentContent = currentChant.selectedContent;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Builder(
              builder: (context) {
                final dataStr = md.markdownToHtml(
                  '# ${currentContent.title}\n${currentContent.content}',
                );
                return SelectionArea(
                  child: Html(
                    data: dataStr,
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
              ).copyWith(
                bottom: 24,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: (currentChantIndex == 0)
                            ? null
                            : () {
                                if (currentChantIndex - 1 >= 0) {
                                  setState(() {
                                    currentChantIndex -= 1;
                                  });
                                }
                              },
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Tooltip(
                          message: 'Table of Content',
                          child: ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet<Chant>(
                                context: context,
                                showDragHandle: true,
                                builder: (context) {
                                  return TocBottomSheet(
                                    currentChant: currentChant,
                                    chants: chants.toList(),
                                  );
                                },
                              ).then(
                                (element) {
                                  if (element != null) {
                                    setState(() {
                                      currentChantIndex = chants.indexWhere(
                                        (element2) => element2.id == element.id,
                                      );
                                    });
                                  }
                                },
                              );
                            },
                            child: Text(currentContent.title),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: (currentChantIndex == chants.length - 1)
                            ? null
                            : () {
                                setState(() {
                                  if (currentChantIndex + 1 < chants.length) {
                                    setState(() {
                                      currentChantIndex += 1;
                                    });
                                  }
                                });
                              },
                        icon: const Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.transparent,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Tooltip(
                        message: 'Dark Mode',
                        child: ElevatedButton(
                          onPressed: () => showDialog<void>(
                            context: context,
                            builder: (context) =>
                                const UnimplementedFeatureAlertDialog(),
                          ),
                          style: ButtonStyle(
                            padding: WidgetStateProperty.all(
                              const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                            ),
                            shape: WidgetStateProperty.all(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(100),
                                ),
                              ),
                            ),
                            visualDensity: VisualDensity.compact,
                          ),
                          child: const Icon(Icons.dark_mode),
                        ),
                      ),
                      Expanded(
                        child: Tooltip(
                          message: 'Language',
                          child: ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet<String?>(
                                context: context,
                                showDragHandle: true,
                                builder: (context) {
                                  return LanguageBottomSheet(
                                    currentIso: currentContent.iso,
                                    isos: currentChant.contents
                                        .map((element) => element.iso)
                                        .toList()
                                      ..removeWhere(
                                        (element) =>
                                            element == currentContent.iso,
                                      ),
                                  );
                                },
                              ).then((iso) {
                                if (iso != null) {
                                  setState(() {
                                    currentChant.selectedContent =
                                        currentChant.contents.singleWhere(
                                      (element) => element.iso == iso,
                                    );
                                  });
                                }
                              });
                            },
                            style: ButtonStyle(
                              padding: WidgetStateProperty.all(
                                const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                              ),
                              shape: WidgetStateProperty.all(
                                const RoundedRectangleBorder(),
                              ),
                              visualDensity: VisualDensity.compact,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.translate),
                                const Text(': '),
                                Expanded(
                                  child: Center(
                                    child: Text(currentContent.iso),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Tooltip(
                        message: 'Settings',
                        child: ElevatedButton(
                          onPressed: () => showDialog<void>(
                            context: context,
                            builder: (context) =>
                                const UnimplementedFeatureAlertDialog(),
                          ),
                          style: ButtonStyle(
                            padding: WidgetStateProperty.all(
                              const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                            ),
                            shape: WidgetStateProperty.all(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(100),
                                ),
                              ),
                            ),
                            visualDensity: VisualDensity.compact,
                          ),
                          child: const Icon(Icons.settings),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
