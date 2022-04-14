import 'package:bloctemplate/src/widgets/column_builder.dart';
import 'package:flutter/material.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    Key? key,
    required this.sectionTitle,
    required this.widgets,
  }) : super(key: key);

  final String sectionTitle;
  final List<Widget> widgets;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            sectionTitle,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ColumnBuilder(
          seperated: true,
          itemCount: widgets.length,

          itemBuilder: (context, idx) {
            return widgets[idx];
          },
          // children: [
          //   Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child:
          //   ),
          //   ...widgets,
          // ],
        ),
      ],
    );
  }
}

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemsBuilder<T> extends StatelessWidget {
  const ListItemsBuilder({
    Key? key,
    required this.data,
    this.scrollable = true,
    required this.itemBuilder,
    this.seperated = true,
  }) : super(key: key);
  final List<T> data;
  final ItemWidgetBuilder<T> itemBuilder;
  final bool scrollable;
  final bool seperated;

  @override
  Widget build(BuildContext context) {
    return scrollable ? _buildList(data) : _buildList2(data);
  }

  Widget _buildList(List<T> items) {
    return seperated
        ? ListView.separated(
            physics: scrollable
                ? const AlwaysScrollableScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            itemCount: items.length + 1,
            separatorBuilder: (context, index) => const Divider(height: 0.5),
            itemBuilder: (context, index) {
              if (index == 0 || index == items.length + 1) {
                return Container(); // zero height: not visible
              }
              return itemBuilder(context, items[index - 1]);
            },
          )
        : ListView.builder(
            itemCount: items.length + 1,
            itemBuilder: (context, index) {
              if (index == 0 || index == items.length + 1) {
                return Container(); // zero height: not visible
              }
              return itemBuilder(context, items[index - 1]);
            },
          );
  }

  Widget _buildList2(List<T> items) {
    return ColumnBuilder(
      itemCount: items.length + 1,
      itemBuilder: (context, index) {
        if (index == 0 || index == items.length + 1) {
          return Container(); // zero height: not visible
        }
        return itemBuilder(context, items[index - 1]);
      },
    );
  }
}
