import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../widgets/wallet_components.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: const Layout2(
        children: [
          SizedBox(height: 32),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              WalletSelector(),
              AccountAddress(),
              DeployAccountButton(),
            ],
          ),
          SizedBox(height: 32),
          WalletBody(),
          SendEthButton(),
          WalletErrorHandler(),
        ],
      ),
    );
  }
}
