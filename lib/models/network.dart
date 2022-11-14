class NetworkItemModel {
  final String icon;
  final String rpc;
  final String symbol;
  final String name;
  final String explorer;
  final int chainID;
  final bool isLocked;

  NetworkItemModel({
    required this.icon,
    required this.rpc,
    required this.symbol,
    required this.name,
    required this.explorer,
    required this.chainID,
    required this.isLocked,
  });
}
