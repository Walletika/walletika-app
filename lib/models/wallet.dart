class WalletViewModel {
  final String username;
  final String address;
  final DateTime dateCreated;
  bool isFavorite;
  bool isLogged;

  WalletViewModel({
    required this.username,
    required this.address,
    required this.dateCreated,
    required this.isFavorite,
    required this.isLogged,
  });
}
