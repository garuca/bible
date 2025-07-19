
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:bible/core/domain/entities/book.dart';
import 'package:bible/core/domain/entities/version.dart';
import 'package:bible/features/bible_reading/presentation/bible_reading_provider.dart';

class BibleReadingScreen extends StatelessWidget {
  final Book book;
  final int chapter;

  const BibleReadingScreen({
    Key? key,
    required this.book,
    required this.chapter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BibleReadingProvider>();
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text('${book.name} $chapter'),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.ellipsis_circle),
              onPressed: () => _showOptions(context),
            ),
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  if (provider.isComparing) {
                    final left = provider.versesLeft[i];
                    final right = provider.versesRight[i];
                    return Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                          child: Text(
                              '${left.verse}. ${left.text}',
                              style: TextStyle(
                                fontSize: provider.fontSize,
                                color: CupertinoDynamicColor.resolve(
                                    CupertinoColors.label, context),
                              ),
                            ),
                          ),
                          Container(width: 1, color: CupertinoColors.separator),
                          Expanded(
                          child: Text(
                              '${right.verse}. ${right.text}',
                              style: TextStyle(
                                fontSize: provider.fontSize,
                                color: CupertinoDynamicColor.resolve(
                                    CupertinoColors.label, context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  final v = provider.verses[i];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Text(
                      '${v.verse}. ${v.text}',
                      style: TextStyle(
                        fontSize: provider.fontSize,
                        color: CupertinoDynamicColor.resolve(
                            CupertinoColors.label, context),
                      ),
                    ),
                  );
                },
                childCount: provider.isComparing
                    ? provider.versesLeft.length
                    : provider.verses.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showOptions(BuildContext context) {
    final provider = context.read<BibleReadingProvider>();
    showCupertinoModalPopup<void>(
      context: context,
      builder: (_) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              provider.increaseFont();
              Navigator.of(context).pop();
            },
            child: const Text('Aumentar fonte'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
              _showComparePopup(context);
            },
            child: const Text('Comparar texto'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
      ),
    );
  }

  void _showComparePopup(BuildContext context) {
    final provider = context.read<BibleReadingProvider>();
    Version left = provider.version;
    Version right = provider.compareVersion;
    showCupertinoModalPopup<void>(
      context: context,
      builder: (_) => SizedBox(
        height: 260,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoPicker(
                      itemExtent: 32,
                      onSelectedItemChanged: (i) => left = Version.values[i],
                      children: Version.values
                          .map((v) => Text(v.name))
                          .toList(),
                    ),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      itemExtent: 32,
                      onSelectedItemChanged: (i) => right = Version.values[i],
                      children: Version.values
                          .map((v) => Text(v.name))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            CupertinoButton.filled(
              child: const Text('Comparar'),
              onPressed: () {
                provider.compareVerses(left, right, book.id, chapter);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}