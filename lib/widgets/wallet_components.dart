import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../utils/wallet_utils.dart';

class WalletSelector extends HookConsumerWidget {
  const WalletSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isConnecting = ref.watch(isConnectingProvider);

    return ElevatedButton(
      onPressed: isConnecting
          ? null
          : () async {
              try {
                ref.read(isConnectingProvider.notifier).state = true;
                await showWalletInitializationModal(context);
              } catch (e) {
                ref.read(walletErrorProvider.notifier).state = e.toString();
              } finally {
                ref.read(isConnectingProvider.notifier).state = false;
              }
            },
      child: isConnecting
          ? const CircularProgressIndicator()
          : const Text('Connect Wallet'),
    );
  }
}

class AccountAddress extends HookConsumerWidget {
  const AccountAddress({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final address = ref.watch(accountAddressProvider);

    return Text(
      'Account Address: ${address != null ? truncateMiddle(address) : 'Not Connected'}',
    );
  }
}

class DeployAccountButton extends HookConsumerWidget {
  const DeployAccountButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDeploying = ref.watch(isDeployingProvider);
    final isDeployed = ref.watch(isDeployedProvider);

    if (isDeployed) {
      return const SizedBox.shrink();
    }

    return ElevatedButton(
      onPressed: isDeploying
          ? null
          : () async {
              try {
                ref.read(isDeployingProvider.notifier).state = true;
                // TODO: Implement account deployment
              } catch (e) {
                ref.read(walletErrorProvider.notifier).state = e.toString();
              } finally {
                ref.read(isDeployingProvider.notifier).state = false;
              }
            },
      child: isDeploying
          ? const CircularProgressIndicator()
          : const Text('Deploy Account'),
    );
  }
}

class WalletBody extends HookConsumerWidget {
  const WalletBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balance = ref.watch(balanceProvider);
    final network = ref.watch(networkProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Wallet Balance: ${balance?.toStringAsFixed(4) ?? '0'} ETH'),
            const SizedBox(height: 8),
            Text('Network: ${network ?? 'Not Connected'}'),
          ],
        ),
      ),
    );
  }
}

class SendEthButton extends HookConsumerWidget {
  const SendEthButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSending = ref.watch(isSendingProvider);
    final account = ref.watch(selectedAccountProvider);

    return ElevatedButton(
      onPressed: isSending || account == null
          ? null
          : () async {
              try {
                ref.read(isSendingProvider.notifier).state = true;
                await showTransactionModal(context, account);
              } catch (e) {
                ref.read(walletErrorProvider.notifier).state = e.toString();
              } finally {
                ref.read(isSendingProvider.notifier).state = false;
              }
            },
      child: isSending
          ? const CircularProgressIndicator()
          : const Text('Send ETH'),
    );
  }
}

class WalletErrorHandler extends HookConsumerWidget {
  const WalletErrorHandler({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final error = ref.watch(walletErrorProvider);

    if (error == null) {
      return const SizedBox.shrink();
    }

    return Card(
      color: Colors.red.shade100,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(error, style: TextStyle(color: Colors.red.shade900)),
      ),
    );
  }
}

class Layout2 extends StatelessWidget {
  final List<Widget> children;

  const Layout2({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}

// Providers
final isConnectingProvider = StateProvider<bool>((ref) => false);
final isDeployingProvider = StateProvider<bool>((ref) => false);
final isSendingProvider = StateProvider<bool>((ref) => false);
final isDeployedProvider = StateProvider<bool>((ref) => false);

final accountAddressProvider = StateProvider<String?>((ref) => null);
final balanceProvider = StateProvider<double?>((ref) => null);
final networkProvider = StateProvider<String?>((ref) => null);
final walletErrorProvider = StateProvider<String?>((ref) => null);
final selectedAccountProvider = StateProvider<Account?>((ref) => null);
