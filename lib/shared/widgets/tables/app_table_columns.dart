class AppTableColumn {
  final String title;
  final double? width;
  final bool sortable;

  const AppTableColumn({
    required this.title,
    this.width,
    this.sortable = false,
  });
}
