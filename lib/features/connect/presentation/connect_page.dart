import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:rfid_inventory_app/core/cubits/reader/reader_cubit.dart';
import 'package:rfid_inventory_app/core/presentation/utils/snackbar_util.dart';
import 'package:rfid_inventory_app/gen/assets.gen.dart';

@RoutePage()
class ConnectPage extends StatelessWidget {
  const ConnectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReaderCubit, ReaderState>(
      listener: (context, state) {
        if (state.connectionError != null && !state.handledDisconnect) {
          showErrorSnackBar(context, state.connectionError!);
        }
      },
      builder: (context, state) {
        final bloc = context.read<ReaderCubit>();
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Gap(32),
                    Text(
                      "Connect to Reader",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    const Gap(52),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Assets.images.openBox.image(),
                    ),
                    const Gap(64),
                    TextFormField(
                      initialValue: state.address,
                      decoration: InputDecoration(
                        labelText: "Address",
                        helperText: ' ',
                        errorText: state.addressError,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      keyboardType: TextInputType.url,
                      onChanged: (value) => bloc.onAddressChanged(value),
                    ),
                    const Gap(8),
                    TextFormField(
                      initialValue: state.port,
                      decoration: InputDecoration(
                        labelText: "Port",
                        helperText: ' ',
                        errorText: state.portError,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => bloc.onPortChanged(value),
                    ),
                    const Gap(16),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "Note: Ensure you're on the same network as the reader. Enter the reader's socket details. ",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          TextSpan(
                            text: "Try Demo.",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  decoration: TextDecoration.underline,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => bloc.demoConnect(),
                          ),
                        ],
                      ),
                    ),
                    const Gap(36),
                    SizedBox(
                      height: 50,
                      child: FilledButton(
                        onPressed: state.status != ReaderStatus.connecting
                            ? () => bloc.connect()
                            : null,
                        child: state.status != ReaderStatus.connecting
                            ? const Text(
                                "Connect",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              )
                            : const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator.adaptive(
                                  strokeWidth: 2,
                                ),
                              ),
                      ),
                    ),
                    const Gap(32),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
