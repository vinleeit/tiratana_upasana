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

  static Chant fromJson(Map<String, dynamic> value) {
    return Chant(
      id: int.parse(value['id'].toString()),
      contents: (value['contents'] as List)
          .map((e) => ChantContent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
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

  static ChantContent fromJson(Map<String, dynamic> value) {
    return ChantContent(
      iso: value['iso'].toString(),
      title: value['title'].toString(),
      content: value['content'].toString(),
      isDefault: bool.parse(value['isDefault'].toString()),
    );
  }
}
