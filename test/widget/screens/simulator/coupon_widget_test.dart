import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:remessa_app/models/responses/error_response_model.dart';
import 'package:remessa_app/screens/simulator/widgets/coupon_widget.dart';
import 'package:remessa_app/widgets/gradient_button_widget.dart';

import '../../../test.dart';

void main() async {
  await Test.init();

  group('CouponWidget', () {
    final mockSimulatorStore = MockSimulatorStore();

    final errorMessage = 'Invalid coupon';

    when(mockSimulatorStore.applyVoucher(any)).thenAnswer(
      (invocation) {
        final voucherCode = invocation.positionalArguments[0];

        if (voucherCode == 'invalid')
          return Future.value(ErrorResponseModel(message: errorMessage));

        return null;
      },
    );

    testWidgets('Has a empty input', (WidgetTester tester) async {
      await Test.widget(
        tester,
        CouponWidget(
          simulatorStore: mockSimulatorStore,
        ),
      );

      final btnFinder = find.byType(TextFormField);

      expect(btnFinder, findsOneWidget);
      expect(tester.widget<TextFormField>(btnFinder).initialValue, '');
    });

    testWidgets(
        'Has a populated input when there are a [simulatorStore.voucherCode]',
        (WidgetTester tester) async {
      final voucherCode = 'populated';

      when(mockSimulatorStore.voucherCode).thenReturn(voucherCode);

      await Test.widget(
        tester,
        CouponWidget(
          simulatorStore: mockSimulatorStore,
        ),
      );

      final btnFinder = find.byType(TextFormField);

      expect(btnFinder, findsOneWidget);
      expect(tester.widget<TextFormField>(btnFinder).initialValue, voucherCode);
    });

    testWidgets('Has a gradientButton disabled', (WidgetTester tester) async {
      await Test.widget(
        tester,
        CouponWidget(
          simulatorStore: mockSimulatorStore,
        ),
      );

      final btnFinder = find.byType(GradientButtonWidget);

      expect(btnFinder, findsOneWidget);
      expect(tester.widget<GradientButtonWidget>(btnFinder).isDisabled, true);
    });

    testWidgets('Should enable the button when type something in the input',
        (WidgetTester tester) async {
      await Test.widget(
        tester,
        CouponWidget(
          simulatorStore: mockSimulatorStore,
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'something');
      await tester.pump();

      expect(
          tester
              .widget<GradientButtonWidget>(find.byType(GradientButtonWidget))
              .isDisabled,
          false);
    });

    testWidgets('Should disable button when erase the input text',
        (WidgetTester tester) async {
      await Test.widget(
        tester,
        CouponWidget(
          simulatorStore: mockSimulatorStore,
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'something');
      await tester.pump();

      await tester.enterText(find.byType(TextFormField), '');
      await tester.pump();

      expect(
          tester
              .widget<GradientButtonWidget>(find.byType(GradientButtonWidget))
              .isDisabled,
          true);
    });

    testWidgets('Should show error when apply an invalid voucher',
        (WidgetTester tester) async {
      await Test.widget(
        tester,
        CouponWidget(
          simulatorStore: mockSimulatorStore,
        ),
      );

      final errorText = find.text(errorMessage);

      expect(errorText, findsNothing);

      await tester.enterText(find.byType(TextFormField), 'invalid');
      await tester.pump();

      await tester.tap(find.byType(GradientButtonWidget));
      await tester.pump();

      expect(errorText, findsOneWidget);
    });

    testWidgets(
        'Should show success state and close when apply a valid voucher',
        (WidgetTester tester) async {
      await Test.widget(
        tester,
        CouponWidget(
          simulatorStore: mockSimulatorStore,
        ),
      );

      final btnFinder = find.byType(GradientButtonWidget);

      await tester.enterText(find.byType(TextFormField), 'valid');
      await tester.pump();

      await tester.tap(btnFinder);
      await tester.pump();

      expect(tester.widget<GradientButtonWidget>(btnFinder).isSuccess, true);

      await tester.pump(const Duration(seconds: 1));

      verify(Test.mockObserver.didPop(any, any));
    });

    testWidgets(
        'Should show success state and do not close if user type before 1 second',
        (WidgetTester tester) async {
      await Test.widget(
        tester,
        CouponWidget(
          simulatorStore: mockSimulatorStore,
        ),
      );

      final btnFinder = find.byType(GradientButtonWidget);

      await tester.enterText(find.byType(TextFormField), 'valid');
      await tester.pump();

      await tester.tap(btnFinder);
      await tester.pump();

      expect(tester.widget<GradientButtonWidget>(btnFinder).isSuccess, true);

      await tester.pump(const Duration(milliseconds: 500));

      await tester.enterText(find.byType(TextFormField), 'more text');
      await tester.pump(const Duration(milliseconds: 500));

      verifyNever(Test.mockObserver.didPop(any, any));
    });
  });
}
