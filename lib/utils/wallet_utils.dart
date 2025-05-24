import 'package:flutter/material.dart';
import 'package:secure_store/secure_store.dart';
import 'package:local_auth/local_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../widgets/wallet_components.dart';
import 'package:wallet_kit/wallet_kit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Account {
  final String address;
  final double balance;
  final String network;

  Account({
    required this.address,
    required this.balance,
    required this.network,
  });
}

String truncateMiddle(String address, {int truncateLength = 20}) {
  if (address.length <= truncateLength) return address;
  final start = address.substring(0, 6);
  final end = address.substring(address.length - 4);
  return '$start...$end';
}

Future<SecureStore> _getSecureStore(
    Future<String> Function() getPassword) async {
  try {
    final localAuth = LocalAuthentication();
    final canCheckBiometrics = (await localAuth.canCheckBiometrics) == true;
    final isDeviceSupported = (await localAuth.isDeviceSupported) == true;
    final availableBiometrics = await localAuth.getAvailableBiometrics();

    // Only use biometrics if:
    // 1. Device supports biometrics
    // 2. Biometrics are available
    // 3. User has enrolled biometrics
    final hasBiometrics = isDeviceSupported &&
        canCheckBiometrics &&
        availableBiometrics.isNotEmpty;
    if (hasBiometrics) {
      return BiometricsStore();
    } else {
      debugPrint('Biometrics not available. Using password store instead.');
      return PasswordStore(getPassword: getPassword);
    }
  } catch (e) {
    // If any error occurs during biometric check, fall back to password
    debugPrint('Error checking biometrics: $e');
    // Return a PasswordStore with a dummy password getter (returns empty string)
    return PasswordStore(getPassword: () async => '');
  }
}

Future<void> showWalletInitializationModal(BuildContext context) async {
  try {
    final store = PasswordStore(getPassword: () async => '');
    await store.storeSecret(
      key: 'wallet_private_key',
      secret: walletPrivateKey,
    );
    await store.storeSecret(
      key: 'wallet_account_address',
      secret: walletAccountAddress,
    );
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Wallet connected!')),
      );
    }
  } catch (e) {
    debugPrint('Wallet initialization error: $e');
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error initializing wallet: ${e.toString()}')),
      );
    }
  }
}

Future<void> showTransactionModal(BuildContext context, Account account) async {
  // TODO: Implement transaction modal
}

Future<String?> showPasscodeInput(BuildContext context) async {
  final controller = TextEditingController();
  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Enter Password'),
      content: TextField(
        controller: controller,
        obscureText: true,
        decoration: const InputDecoration(
          hintText: 'Enter your password',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(controller.text),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

const String walletPrivateKey =
    '0x00000000000000000000000000000000bfd724c814521aac64d8aa6a0f021a73';
const String walletAccountAddress =
    '0x014571fff782f1f02dfe350e4f066aa26c090cb08577d780e073529b9b60f9a8';

Future<double> getStarknetBalance(String address) async {
  try {
    final response = await http.post(
      Uri.parse('https://starknet-goerli.infura.io/v3/YOUR-PROJECT-ID'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'jsonrpc': '2.0',
        'method': 'starknet_getBalance',
        'params': [address],
        'id': 1,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['result'] != null) {
        // Convert from wei to ETH
        return double.parse(data['result']) / 1e18;
      }
    }
    return 0.0;
  } catch (e) {
    debugPrint('Error fetching balance: $e');
    return 0.0;
  }
}

Future<void> connectWallet(BuildContext context) async {
  try {
    final store = PasswordStore(getPassword: () async => '');
    await store.storeSecret(
      key: 'wallet_private_key',
      secret: walletPrivateKey,
    );
    await store.storeSecret(
      key: 'wallet_account_address',
      secret: walletAccountAddress,
    );

    // Update the providers
    if (context.mounted) {
      final ref = ProviderScope.containerOf(context);
      ref.read(accountAddressProvider.notifier).state = walletAccountAddress;

      // Fetch actual balance from Starknet
      try {
        final balance = await getStarknetBalance(walletAccountAddress);
        ref.read(balanceProvider.notifier).state = balance;
      } catch (e) {
        debugPrint('Error fetching balance: $e');
        ref.read(balanceProvider.notifier).state = 0.0;
      }

      ref.read(networkProvider.notifier).state = 'Starknet';

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Wallet connected!')),
      );
    }
  } catch (e) {
    debugPrint('Wallet connection error: $e');
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error connecting wallet: ${e.toString()}')),
      );
    }
  }
}
