import 'package:flutter/material.dart';

class DynamicAlert {
  final String id;
  final String? title;
  final String message;
  final DateTime createdAt;
  final bool isRead;
  final List<Widget>? hidenActions;

  DynamicAlert({
    required this.id,
    required this.message,
    required this.createdAt,
    required this.isRead,
    this.title,
    this.hidenActions,
  });
}

class DynamicListViewAlerts extends StatefulWidget {
  final List<DynamicAlert> alerts;

  const DynamicListViewAlerts({super.key, required this.alerts});

  @override
  State<DynamicListViewAlerts> createState() => _DynamicListViewAlertsState();
}

class _DynamicListViewAlertsState extends State<DynamicListViewAlerts> {
  late int lastDay;

  @override
  void initState() {
    super.initState();
    if (widget.alerts.isEmpty) {
      lastDay = DateTime.now().day;
    } else {
      widget.alerts.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      lastDay = widget.alerts.first.createdAt.day;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.alerts.isEmpty) {
      return const Center(child: Text('No hay alertas'));
    }

    widget.alerts.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final groupedAlerts = <String, List<DynamicAlert>>{};
    for (var alert in widget.alerts) {
      final formattedDate = "${alert.createdAt.day}/${alert.createdAt.month}/${alert.createdAt.year}";
      groupedAlerts.putIfAbsent(formattedDate, () => []).add(alert);
    }

    return ListView(
      children:
          groupedAlerts.entries.map((entry) {
            final date = entry.key;
            final alerts = entry.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, top: 16),
                  child: Text(
                    date,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  height: 52,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Theme.of(context).colorScheme.secondary, width: 1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ...alerts.map((alert) {
                        return Column(
                          children: [
                            _Row(
                              alert: DynamicAlert(
                                id: alert.id,
                                title: alert.title,
                                message: alert.message,
                                createdAt: alert.createdAt,
                                isRead: alert.isRead,
                                hidenActions: alert.hidenActions,
                              ),
                            ),
                            if (alerts.last.id != alert.id) ...[
                              const SizedBox(height: 12),
                              Divider(),
                              const SizedBox(height: 12),
                            ],
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
    );
  }
}

class _Row extends StatefulWidget {
  final DynamicAlert alert;

  const _Row({super.key, required this.alert});

  @override
  State<_Row> createState() => _RowState();
}

class _RowState extends State<_Row> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (widget.alert.title != '') ...[
            Text(widget.alert.title!, style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(width: 8),
          ],
          Text(widget.alert.message, style: Theme.of(context).textTheme.bodyLarge!),
          Spacer(),
          Visibility(
            visible: !isHovered,
            replacement: Row(
              children: [
                if (!widget.alert.isRead)
                  widget.alert.hidenActions != null ? Row(children: widget.alert.hidenActions!) : const SizedBox(),
              ],
            ),
            child: Text(
              '${widget.alert.createdAt.hour.toString().padRight(2, '0')}:${widget.alert.createdAt.minute.toString().padRight(2, '0')}',
              style: Theme.of(context).textTheme.bodyLarge!,
            ),
          ),
        ],
      ),
    );
  }
}
