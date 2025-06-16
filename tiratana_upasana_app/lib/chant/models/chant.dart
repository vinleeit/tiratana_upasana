final chants = [
  Chant(
    id: 0,
    contents: [
      const ChantContent(
        iso: 'chi',
        title: '例子',
        content:
            '树木。树木的魅力在于它们。它们随风摇曳，为周围区域遮荫。树叶在风中发出的声响，树枝摇曳时发出的嘎吱声，树木在诉说着我无法理解的情感。',
        isDefault: true,
      ),
      const ChantContent(
        iso: 'eng',
        title: 'Example',
        content:
            'Trees. It was something about the trees. The way they swayed with the wind in unison. The way they shaded the area around them. The sounds of their leaves in the wind and the creaks from the branches as they sway, The trees were making a statement that I just couldn\'t understand.',
      ),
    ],
  ),
];

class Chant {
  Chant({
    required this.id,
    required this.contents,
  }) : assert(contents.isNotEmpty, 'contents must not be empty');

  final int id;
  final List<ChantContent> contents;
}

class ChantContent {
  const ChantContent({
    required this.iso,
    required this.title,
    required this.content,
    this.isDefault = false,
  });

  final String iso;
  final String title;
  final String content;
  final bool isDefault;
}
