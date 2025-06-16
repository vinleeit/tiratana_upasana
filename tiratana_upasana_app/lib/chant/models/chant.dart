final chants = [
  Chant(
    id: 0,
    contents: [
      ChantContent(
        iso: 'chi',
        isDefault: true,
        title: '树木',
        content:
            '树木。树木的魅力在于它们。它们随风摇曳，为周围区域遮荫。树叶在风中发出的声响，树枝摇曳时发出的嘎吱声，树木在诉说着我无法理解的情感。',
      ),
      ChantContent(
        iso: 'eng',
        title: 'Tree',
        content:
            'Trees. It was something about the trees. The way they swayed with the wind in unison. The way they shaded the area around them. The sounds of their leaves in the wind and the creaks from the branches as they sway, The trees were making a statement that I just couldn\'t understand.',
      ),
      ChantContent(
        iso: 'ind',
        title: 'Pohon',
        content:
            'Pohon. Pesona pohon terletak pada pohon. Pohon bergoyang tertiup angin dan memberikan keteduhan bagi daerah sekitarnya. Suara dedaunan yang tertiup angin, derit ranting saat bergoyang, pohon berbicara tentang emosi yang tidak dapat saya pahami.',
      ),
    ],
  ),
  Chant(
    id: 1,
    contents: [
      ChantContent(
        iso: 'eng',
        isDefault: true,
        title: 'Green River',
        content:
            'They had always called it the green river. It made sense. The river was green. The river likely had a different official name, but to everyone in town, it was and had always been the green river. So it was with great surprise that on this day the green river was a fluorescent pink.',
      ),
      ChantContent(
        iso: 'chi',
        title: '绿河',
        content:
            '他们一直叫它绿河。这很有道理。这条河本来就是绿色的。它可能有不同的官方名称，但对这座城市的每个人来说，它一直都是那条绿河。所以那天，这条绿河泛着亮粉色，这让人很惊讶。',
      ),
    ],
  ),
];

class Chant {
  Chant({
    required this.id,
    required this.contents,
  }) : assert(contents.isNotEmpty, 'contents must not be empty') {
    selectedContent = contents.singleWhere((element) => element.isDefault);
  }

  final int id;
  final List<ChantContent> contents;
  late ChantContent selectedContent;

  ChantContent get defaultContent {
    return contents.singleWhere((element) => element.isDefault);
  }
}

class ChantContent {
  ChantContent({
    required this.iso,
    required this.title,
    required this.content,
    this.isDefault = false,
  });

  final String iso;
  final String title;
  final String content;
  bool isDefault;
}
