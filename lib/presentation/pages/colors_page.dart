import 'package:flutter/material.dart';
import 'package:tp_e_commerce/presentation/widgets/colorsheme_widget.dart';

class ColorSchemePage extends StatelessWidget {
  const ColorSchemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ColorSchemeViewer(),
    );
  }
}
