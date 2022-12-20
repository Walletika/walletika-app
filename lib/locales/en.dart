const Map<String, String> translator = {
  // Global
  "1000@global": "Copy",
  "1001@global": "Copied",
  "1003@global": "Back",
  "1004@global": "Donate",
  "1005@global": "Search",
  "1006@global": "Cancel",
  "1007@global": "Remove",
  "1008@global": "Favorite",
  "1009@global": "Show",
  "1010@global": "Username",
  "1011@global": "Password",
  "1012@global": "Confirm Password",
  "1013@global": "Security Password",
  "1014@global": "Confirm Security Password",
  "1015@global": "Field is empty",
  "1016@global": "Password is weak",
  "1017@global": "Passwords doesn't match",
  "1018@global": "Already exists before",
  "1019@global":
      "Please restart the app and try again or contact us to help you with this issue.",
  "1020@global": "Support",
  "1021@global": "Completed Successfully",
  "1022@global": "I Understand",
  "1023@global": "Security password must be different",
  "1024@global": "Invalid URL",
  "1025@global": "Error Detected",
  "1026@global": "Confirm",
  "1027@global": "Next",
  "1028@global": "Verify",
  "1029@global": "Done",
  "1030@global": "Menu",
  "1031@global": "View on block explorer",
  "1032@global": "Access Denied",
  "1033@global": "Account login is required to access this feature.",
  "1034@global": "Confirmed Successfully",
  "1035@global": "Connected",

  // PW validator plugin
  "1000@PWValidator": "At least - character",
  "1001@PWValidator": "- Letter",
  "1002@PWValidator": "- Uppercase letter",
  "1003@PWValidator": "- Numeric character",
  "1004@PWValidator": "- Special character",

  // Home
  "1000@home": "Home",
  "1001@home": "No wallets have been added yet!",
  "1002@home": "Let's add your first wallet today, click on \"+\" button.",
  "1003@home": "Add a wallet",

  // Settings
  "1000@settings": "Settings",
  "1001@settings": "Dark mode theme",
  "1002@settings": "Primary language",
  "1003@settings": "Current blockchain network",
  "1004@settings":
      "Backup all your wallets to specific location on your system.",
  "1005@settings": "Backup",
  "1006@settings": "Import External File",
  "1007@settings": "Settings Update",

  // Networks
  "1000@network": "Blockchain Networks",
  "1001@network": "Add a network",
  "1002@network": "Hide testnet networks",
  "1003@network": "Network Remove",
  "1004@network": "Are you sure you want to remove this network?",
  "1005@network": "netwrok has been removed successfully.",
  "1006@network": "netwrok removal failed.",
  "1007@network": "This network is locked",

  // Add network
  "1000@addNetwork": "Add a Network",
  "1001@addNetwork":
      "A malicious network provider can lie about the state of the blockchain and record your network activity. Only add custom networks you trust.",
  "1002@addNetwork": "Network Name",
  "1003@addNetwork": "RPC URL",
  "1004@addNetwork": "Chain ID",
  "1005@addNetwork": "Currency Symbol",
  "1006@addNetwork": "Block Explorer URL",
  "1007@addNetwork": "Add Network",
  "1008@addNetwork": "Network has been added successfully.",
  "1009@addNetwork": "Failed, Unable to connect to this network.",

  // Add wallet
  "1000@addWallet":
      "Create a new wallet or add an existing one, your private keys and passwords are stored anywhere.",
  "1001@addWallet": "Username or email is sensitive to characters.",
  "1002@addWallet":
      "Password must contain uppercase/lowercase letters, symbols and numbers.",
  "1003@addWallet":
      "Security password is important to be able to add your wallet later.",
  "1004@addWallet": "Add Wallet",
  "1005@addWallet": "Protect Your Funds",
  "1006@addWallet":
      "You must use the same username, password and security password to add this wallet later.",
  "1007@addWallet":
      "Wallet information is immutable and cannot be recovered if you forget it.",
  "1008@addWallet": "Never share your password or private key with anyone.",
  "1009@addWallet":
      "Walletika team will never ask for your password or private key",
  "1010@addWallet":
      "Recommended to backup all your wallets to an external file.",
  "1011@addWallet": "Failed to add this wallet, Please try again.",
  "1012@addWallet": "Let's setup your OTP Key.",

  // Auth setup
  "1000@authSetup": "Download App",
  "1001@authSetup": "Verification",
  "1002@authSetup": "Scan QR Code",
  "1003@authSetup": "Download and install app",
  "1004@authSetup": "Choose the authenticator application to download.",
  "1005@authSetup": "1 - Google Authenticator",
  "1006@authSetup": "2 - Authy",
  "1007@authSetup": "Wallet Verification",
  "1008@authSetup": "Confirm your wallet to generate your OTP key.",
  "1009@authSetup": "Step 1 - Scan QR Code",
  "1010@authSetup": "Scan this QR code in your authenticator app.",
  "1011@authSetup":
      "If you are unable to scan this QR code, Please enter this key manually into the app.",
  "1012@authSetup": "Step 2 - OTP Code",
  "1013@authSetup":
      "Enter the 6 numbers that appear in your authenticator app.",
  "1014@authSetup": "Congratulations, we're done!",
  "1015@authSetup":
      "Don't worry if you lose your OTP key, you can recover it later.",

  // Login
  "1000@login": "Login",
  "1001@login": "Skip to View",
  "1002@login": "Wallet Login",
  "1003@login": "Wrong password! Please try again.",

  // Auth
  "1000@auth": "Verification Code",
  "1001@auth": "Enter a one-time passcode from your authenticator app.",
  "1002@auth": "I've lost my authentication code",
  "1003@auth": "The OTP code is wrong!",

  // Wallet
  "1000@wallet": "Total Balance",
  "1001@wallet": "Send",
  "1002@wallet": "Receive",
  "1003@wallet": "Stake",
  "1004@wallet": "Coins",
  "1005@wallet": "Transactions",
  "1006@wallet": "Account Details",
  "1007@wallet": "Add Token",
  "1008@wallet": "View at Explorer",
  "1009@wallet": "Remove Wallet",
  "1010@wallet": "Lock",
  "1011@wallet": "You have no transactions",

  // Add token
  "1000@addToken":
      "Make sure you use the correct contract address that you trust.",
  "1001@addToken": "Paste ( 0x ) Contract Address",
  "1002@addToken":
      "Token unavailable, Please make sure the address is correct.",
  "1003@addToken": "Token added successfully.",

  // Account details
  "1000@accountDetails":
      "Warning: Never disclose this key. Anyone with your private keys can steal any assets held in your account.",
  "1001@accountDetails": "Show Private Key",
  "1002@accountDetails": "Private Key",
};
