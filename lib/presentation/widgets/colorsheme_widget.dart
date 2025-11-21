import 'package:flutter/material.dart';
import 'package:tp_e_commerce/presentation/widgets/drawer_widget.dart';

class ColorSchemeViewer extends StatelessWidget {
  const ColorSchemeViewer({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final entries = <String, Color>{
      "primary": scheme.primary,
      "onPrimary": scheme.onPrimary,
      "primaryContainer": scheme.primaryContainer,
      "onPrimaryContainer": scheme.onPrimaryContainer,
      "secondary": scheme.secondary,
      "onSecondary": scheme.onSecondary,
      "secondaryContainer": scheme.secondaryContainer,
      "onSecondaryContainer": scheme.onSecondaryContainer,
      "tertiary": scheme.tertiary,
      "onTertiary": scheme.onTertiary,
      "tertiaryContainer": scheme.tertiaryContainer,
      "onTertiaryContainer": scheme.onTertiaryContainer,
      "error": scheme.error,
      "onError": scheme.onError,
      "errorContainer": scheme.errorContainer,
      "onErrorContainer": scheme.onErrorContainer,
      "surface": scheme.surface,
      "onSurface": scheme.onSurface,
      "onSurfaceVariant": scheme.onSurfaceVariant,
      "outline": scheme.outline,
      "outlineVariant": scheme.outlineVariant,
      "shadow": scheme.shadow,
      "scrim": scheme.scrim,
      "inverseSurface": scheme.inverseSurface,
      "onInverseSurface": scheme.onInverseSurface,
      "inversePrimary": scheme.inversePrimary,
      "surfaceTint": scheme.surfaceTint,
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text("Theme ColorScheme"),
        backgroundColor: Theme.of(context).colorScheme.outlineVariant,
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: entries.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 8,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final key = entries.keys.elementAt(index);
            final value = entries[key]!;

            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: value,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black12),
              ),
              child: Text(
                key,
                style: TextStyle(
                  color: _bestTextColor(value),
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Color _bestTextColor(Color color) {
    return color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}
