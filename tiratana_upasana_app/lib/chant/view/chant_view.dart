import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:tiratana_upasana_app/chant/bloc/chant_bloc.dart';
import 'package:tiratana_upasana_app/chant/models/chant.dart';
import 'package:tiratana_upasana_app/chant/view/language_bottom_sheet.dart';
import 'package:tiratana_upasana_app/chant/view/toc_bottom_sheet.dart';
import 'package:tiratana_upasana_app/widgets/unimplemented_feature_alert_dialog.dart';

class ChantView extends StatelessWidget {
  const ChantView({super.key});

  @override
  Widget build(BuildContext context) {
    void showLoadJson(BuildContext context) {
      FilePicker.platform.pickFiles(
        allowedExtensions: ['json'],
        type: FileType.custom,
      ).then(
        (value) {
          if (value == null || value.paths.isEmpty || !context.mounted) return;
          context.read<ChantBloc>().add(
                LoadChantFromJsonFile(
                  filePath: value.paths.first!,
                ),
              );
        },
      );
    }

    void showTOC(
      BuildContext context,
      Chant currentChant,
      List<Chant> chants,
    ) {
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
        (chant) {
          if (chant == null || !context.mounted) return;
          context.read<ChantBloc>().add(
                ChangeChant(
                  index: chants.indexWhere(
                    (element2) => element2.id == chant.id,
                  ),
                ),
              );
        },
      );
    }

    void showLanguageOption(
      Chant currentChant,
      ChantContent currentContent,
    ) {
      showModalBottomSheet<String?>(
        context: context,
        showDragHandle: true,
        builder: (context) {
          return LanguageBottomSheet(
            currentIso: currentContent.iso,
            isos: currentChant.contents.map((element) => element.iso).toList()
              ..removeWhere(
                (element) => element == currentContent.iso,
              ),
          );
        },
      ).then((iso) {
        if (iso == null || !context.mounted) return;
        context.read<ChantBloc>().add(ChangeChantContent(iso: iso));
      });
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          BlocBuilder<ChantBloc, ChantState>(
            builder: (context, state) {
              final currentChant = state.currentChant;
              if (currentChant == null) {
                return const Center(
                  child: Text('No data'),
                );
              }

              final currentContent = currentChant.selectedContent;
              final title = (currentContent.title.isEmpty)
                  ? currentChant.defaultContent.title
                  : currentContent.title;
              final content = currentContent.content;
              final dataStr = md.markdownToHtml(
                '## $title\n$content',
              );
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: SelectionArea(
                  child: Html(
                    data: dataStr,
                  ),
                ),
              );
            },
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
                  BlocBuilder<ChantBloc, ChantState>(
                    builder: (context, state) {
                      final currentChant = state.currentChant;
                      final currentContent = currentChant?.selectedContent;
                      return Row(
                        children: [
                          IconButton(
                            onPressed: (state.currentChantIndex == 0)
                                ? null
                                : () => context.read<ChantBloc>().add(
                                      ChangeChant(
                                        index: state.currentChantIndex - 1,
                                      ),
                                    ),
                            icon: const Icon(Icons.arrow_back_ios_new_rounded),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Tooltip(
                              message: 'Table of Content',
                              child: ElevatedButton(
                                onPressed: (currentChant == null)
                                    ? null
                                    : () => showTOC(
                                          context,
                                          currentChant,
                                          state.chants,
                                        ),
                                child: Text(
                                  (currentContent == null)
                                      ? ''
                                      : (currentContent.title.isEmpty)
                                          ? currentChant!.defaultContent.title
                                          : currentContent.title,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: (state.currentChantIndex ==
                                    state.chants.length - 1)
                                ? null
                                : () => context.read<ChantBloc>().add(
                                      ChangeChant(
                                        index: state.currentChantIndex + 1,
                                      ),
                                    ),
                            icon: const Icon(Icons.arrow_forward_ios_rounded),
                          ),
                        ],
                      );
                    },
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
                        message: 'Import',
                        child: ElevatedButton(
                          onPressed: () => showLoadJson(context),
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
                          child: const Icon(Icons.file_upload_outlined),
                        ),
                      ),
                      Expanded(
                        child: Tooltip(
                          message: 'Language',
                          child: BlocBuilder<ChantBloc, ChantState>(
                            builder: (context, state) {
                              final currentChant = state.currentChant;
                              final currentContent =
                                  currentChant?.selectedContent;
                              return ElevatedButton(
                                onPressed: (currentChant == null ||
                                        currentContent == null)
                                    ? null
                                    : () => showLanguageOption(
                                          currentChant,
                                          currentContent,
                                        ),
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
                                        child: Text(
                                          currentContent == null
                                              ? ''
                                              : currentContent.iso,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
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
