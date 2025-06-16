import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:tiratana_upasana_app/chant/models/chant.dart';
import 'package:tiratana_upasana_app/chant/view/language_bottom_sheet.dart';

class ChantPage extends StatefulWidget {
  const ChantPage({super.key});

  @override
  State<ChantPage> createState() => _ChantPageState();
}

class _ChantPageState extends State<ChantPage> {
  final currentChantIndex = 0;
  var currentIsoIndex = 0;

  @override
  void initState() {
    currentIsoIndex = chants[currentChantIndex].contents.indexWhere(
          (element) => element.isDefault,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentChant = chants[currentChantIndex];
    final content = currentChant.contents[currentIsoIndex];

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Builder(
              builder: (context) {
                final dataStr = md.markdownToHtml(
                  '# ${content.title}\n${content.content}',
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
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(content.title),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () {},
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
                      ElevatedButton(
                        onPressed: () {},
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
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              showDragHandle: true,
                              builder: (context) {
                                return LanguageBottomSheet(
                                  currentIso: content.iso,
                                  isos: currentChant.contents
                                      .map((element) => element.iso)
                                      .toList()
                                    ..removeAt(currentIsoIndex),
                                );
                              },
                            ).then((iso) {
                              if (iso != null) {
                                setState(() {
                                  currentIsoIndex = currentChant.contents
                                      .indexWhere(
                                          (element) => element.iso == iso);
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
                                  child: Text(content.iso),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
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
