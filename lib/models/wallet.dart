class WalletItemModel {
  final String username;
  final String address;
  final bool isFavorite;
  final bool isLogged;

  WalletItemModel({
    required this.username,
    required this.address,
    required this.isFavorite,
    required this.isLogged,
  });
}
