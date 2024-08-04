import 'package:flutter/material.dart';
import 'package:shoping/features/setting/presentation/views/widget/payment_body.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const PaymentBody(),
    );
  }
}
