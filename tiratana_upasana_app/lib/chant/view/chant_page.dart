import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:markdown/markdown.dart';

class ChantPage extends StatelessWidget {
  const ChantPage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = markdownToHtml(
        '# Example\n***Lorem ipsum dolor sit amet***, consectetur adipiscing elit. Nunc justo risus, rutrum eu euismod sed, viverra vel arcu. Nam blandit auctor viverra. Curabitur nec rhoncus ipsum, vel feugiat sapien. Phasellus diam turpis, porta efficitur lectus tincidunt, fringilla auctor ex. Fusce eu orci rutrum, elementum eros in, pulvinar dui. Morbi fringilla non mi in dignissim. Nam rhoncus felis ut iaculis cursus. Duis accumsan metus mi, bibendum ultrices nisl auctor id. Integer aliquet massa a aliquet auctor. Phasellus ultricies lectus sit amet felis sollicitudin dignissim. Nullam porta varius tortor sed pretium. Duis et finibus lectus, ac volutpat ante. Integer varius lobortis urna, nec convallis nulla semper maximus. \n- List 1\n\t- List 1.1\n- List 2');
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: SelectionArea(
          child: Html(
            data: data,
          ),
        ),
      ),
    );
  }
}
