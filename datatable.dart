class CustomDataTable<T> extends StatefulWidget {
  final T fixedCornerCell;
  final List<T> fixedColCells;
  final List<T> fixedRowCells;
  final List<List<T>> rowsCells;
  final Widget Function(T data) cellBuilder;
  final double fixedColWidth;
  final double cellWidth;
  final double cellHeight;
  final double cellMargin;
  final double cellSpacing;

  CustomDataTable({
    this.fixedCornerCell,
    this.fixedColCells,
    this.fixedRowCells,
    @required this.rowsCells,
    this.cellBuilder,
    this.fixedColWidth = 60.0,
    this.cellHeight = 56.0,
    this.cellWidth = 120.0,
    this.cellMargin = 10.0,
    this.cellSpacing = 10.0,
  });

  @override
  State<StatefulWidget> createState() => CustomDataTableState();
}

class CustomDataTableState<T> extends State<CustomDataTable<T>> {
  final _columnController = ScrollController();
  final _rowController = ScrollController();
  final _subTableYController = ScrollController();
  final _subTableXController = ScrollController();

  Widget _buildChild(double width, T data) => SizedBox(
      width: width, child: widget.cellBuilder?.call(data) ?? Text('$data'));

  Widget _buildFixedCol() => widget.fixedColCells == null
      ? SizedBox.shrink()
      : Material(
          color: AppColor.primarySwatch.withOpacity(0.5),
          child: DataTable(
              horizontalMargin: widget.cellMargin,
              columnSpacing: widget.cellSpacing,
              headingRowHeight: widget.cellHeight,
              dataRowHeight: widget.cellHeight,
              columns: [
                DataColumn(
                    label: _buildChild(
                        widget.fixedColWidth, widget.fixedColCells.first))
              ],
              rows: widget.fixedColCells
                  .sublist(widget.fixedRowCells == null ? 1 : 0)
                  .map((c) => DataRow(
                      cells: [DataCell(_buildChild(widget.fixedColWidth, c))]))
                  .toList()),
        );

  Widget _buildFixedRow() => widget.fixedRowCells == null
      ? SizedBox.shrink()
      : Material(
          color: AppColor.secondColor,
          child: DataTable(
              horizontalMargin: widget.cellMargin,
              columnSpacing: widget.cellSpacing,
              headingRowHeight: widget.cellHeight,
              dataRowHeight: widget.cellHeight,
              columns: widget.fixedRowCells
                  .map((c) =>
                      DataColumn(label: _buildChild(widget.cellWidth, c)))
                  .toList(),
              rows: []),
        );

  Widget _buildSubTable() => Material(
      color: AppColor.primarySwatch.shade100,
      child: DataTable(
          horizontalMargin: widget.cellMargin,
          columnSpacing: widget.cellSpacing,
          headingRowHeight: widget.cellHeight,
          dataRowHeight: widget.cellHeight,
          columns: widget.rowsCells.first
              .map((c) => DataColumn(label: _buildChild(widget.cellWidth, c)))
              .toList(),
          rows: widget.rowsCells
              .sublist(widget.fixedRowCells == null ? 1 : 0)
              .map((row) => DataRow(
                  cells: row
                      .map((c) => DataCell(_buildChild(widget.cellWidth, c)))
                      .toList()))
              .toList()));

  Widget _buildCornerCell() =>
      widget.fixedColCells == null || widget.fixedRowCells == null
          ? SizedBox.shrink()
          : Material(
              color: AppColor.secondColor,
              child: DataTable(
                  horizontalMargin: widget.cellMargin,
                  columnSpacing: widget.cellSpacing,
                  headingRowHeight: widget.cellHeight,
                  dataRowHeight: widget.cellHeight,
                  columns: [
                    DataColumn(
                        label: _buildChild(
                            widget.fixedColWidth, widget.fixedCornerCell))
                  ],
                  rows: []),
            );

  @override
  void initState() {
    super.initState();
    _subTableXController.addListener(() {
      _rowController.jumpTo(_subTableXController.position.pixels);
    });
    _subTableYController.addListener(() {
      _columnController.jumpTo(_subTableYController.position.pixels);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
          children: <Widget>[
            SingleChildScrollView(
              controller: _columnController,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              child: _buildFixedCol(),
            ),
            Flexible(
              child: SingleChildScrollView(
                controller: _subTableXController,
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  controller: _subTableYController,
                  scrollDirection: Axis.vertical,
                  child: _buildSubTable(),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            _buildCornerCell(),
            Flexible(
              child: SingleChildScrollView(
                controller: _rowController,
                scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),
                child: _buildFixedRow(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
 final _rowsCells = [
    ["18:23", "NA", "18:23", "On", "NA", "18:23", "NA", "-", "-", "-"],
    ["18:23", "NA", "18:23", "On", "NA", "18:23", "NA", "-", "-", "-"],
    ["18:23", "NA", "18:23", "On", "NA", "18:23", "NA", "-", "-", "-"],
    ["18:23", "NA", "18:23", "On", "NA", "18:23", "NA", "-", "-", "-"],
    ["18:23", "NA", "18:23", "On", "NA", "18:23", "NA", "-", "-", "-"],
    ["18:23", "NA", "18:23", "On", "NA", "18:23", "NA", "-", "-", "-"],
    ["18:23", "NA", "18:23", "On", "NA", "18:23", "NA", "-", "-", "-"],
    ["18:23", "NA", "18:23", "On", "NA", "18:23", "NA", "-", "-", "-"],
    ["18:23", "NA", "18:23", "On", "NA", "18:23", "NA", "-", "-", "-"],
    ["18:23", "NA", "18:23", "On", "NA", "18:23", "NA", "-", "-", "-"],
    ["18:23", "NA", "18:23", "On", "NA", "18:23", "NA", "-", "-", "-"],
    ["18:23", "NA", "18:23", "On", "NA", "18:23", "NA", "-", "-", "-"],
    ["18:23", "NA", "18:23", "On", "NA", "18:23", "NA", "-", "-", "-"],
    ["18:23", "NA", "18:23", "On", "NA", "18:23", "NA", "-", "-", "-"],
    ["18:23", "NA", "18:23", "On", "NA", "18:23", "NA", "-", "-", "-"],
    ["18:23", "NA", "18:23", "On", "NA", "18:23", "NA", "-", "-", "-"],
     
  ];
  final _fixedColCells = [
    "Porridge",
    "Eggs",
    "Milk",
    "Other",
    "Main meat",
    "Vitamised",
    "Vegetables ",
    "Soup",
    "Porridge",
    "Eggs",
    "Milk",
    "Other",
    "Main meat",
    "Vitamised",
    "Vegetables ",
    "Soup",
  ];
  final _fixedRowCells = [
    "Time Cooking or Reheating started",
    "Reheated temp.(° C)",
    "Reheating completed",
    "Reheating",
    "Vitamised (° C)",
    "Time plating begins",
    "Temp @ start of plating (° C)",
    "Time at last plate",
    "Sign",
    "C/A- Register"
  ];
// CustomDataTable(
//               rowsCells: _rowsCells,
//               fixedColCells: _fixedColCells,
//               fixedRowCells: _fixedRowCells,
//               fixedCornerCell: "Product",
//               cellBuilder: (data) {
//                 return Text('$data',
//                     style: AppStyle.mediumTextStyle(color: Colors.black));
//               })
