class WalletItemModel {
  final String username;
  final String address;
  final DateTime dateCreated;
  bool isFavorite;
  bool isLogged;

  WalletItemModel({
    required this.username,
    required this.address,
    required this.dateCreated,
    required this.isFavorite,
    required this.isLogged,
  });
}
