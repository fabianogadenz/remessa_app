import 'package:flutter/material.dart';

import 'package:dashbook/dashbook.dart';
import 'package:remessa_app/helpers/environment_model.dart';
import 'package:remessa_app/helpers/modal_helper.dart';
import 'package:remessa_app/models/actions/action_model.dart';
import 'package:remessa_app/models/actions/content_action_model.dart';
import 'package:remessa_app/models/actions/link_action_model.dart';
import 'package:remessa_app/models/config_model.dart';
import 'package:remessa_app/models/view_generators/info_model.dart';
import 'package:remessa_app/models/view_generators/info_stepper_model.dart';
import 'package:remessa_app/screens/info/info_screen.dart';
import 'package:remessa_app/screens/info_stepper/info_stepper_screen.dart';
import 'package:remessa_app/setup.dart';
import 'package:remessa_app/theme.dart';
import 'package:remessa_app/v2/modules/transaction/widgets/checkout_confirmation/checkout_confirmation_widget.dart';
import 'package:remessa_app/v2/modules/transaction/widgets/checkout_tax_details/checkout_tax_details_widget.dart';

import 'package:remessa_app/v2/core/actions/action.dart' as ac;

void main() async {
  final remoteConfigs = ConfigModel(environment: Environment.DEV);

  await SetUp(remoteConfigs).init();

  final dashbook = Dashbook();

  dashbook
      .storiesOf('InfoStepperScreen')
      .decorator(CenterDecorator())
      .add('default', (_) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme(),
      home: InfoStepperScreen(
        model: InfoStepperModel(
          steppers: [
            InfoStepper(
              header: InfoStepperHeader(
                title: 'Novos Termos de Uso',
              ),
              title:
                  'Mudanças importantes na sua conta e novos dados bancários',
              content:
                  'Os novos dados bancários para pagar a TED serão exclusivos para você. Confira ao criar uma nova remessa.',
            ),
            InfoStepper(
              header: InfoStepperHeader(
                title: 'Novos Termos de Uso',
                link: InfoStepperHeaderLink(
                  prefix: 'Acesse o',
                  linkAction: LinkActionModel(
                    label: 'documento completo',
                    url: 'google.com',
                    trackEvent: 'kdskds',
                  ).toAction(),
                ),
              ),
              title:
                  'Mudanças importantes na sua conta e novos dados bancários',
              content:
                  'Os novos dados bancários para pagar a TED serão exclusivos para você. Confira ao criar uma nova remessa.',
              imageURL:
                  'https://cdn.icon-icons.com/icons2/1744/PNG/512/3643769-building-home-house-main-menu-start_113416.png',
            ),
            InfoStepper(
              header: InfoStepperHeader(
                title: 'Novos Termos de Uso',
                link: InfoStepperHeaderLink(
                  prefix: 'Acesse o',
                  linkAction: LinkActionModel(
                    label: 'documento completo',
                    url: 'google.com',
                    trackEvent: 'kdskds',
                  ).toAction(),
                ),
              ),
              title:
                  'Mudanças importantes na sua conta e novos dados bancários',
              content:
                  'Os novos dados bancários para pagar a TED serão exclusivos para você. Confira ao criar uma nova remessa.',
              imageURL:
                  'https://cdn.icon-icons.com/icons2/1744/PNG/512/3643769-building-home-house-main-menu-start_113416.png',
              action: ActionModel(
                label: 'Li e aceito os novos termos',
                action: 'accept_new_terms',
              ).toAction(),
              linkAction: ContentActionModel(
                label: 'Não aceito os novos termos',
                content: {},
              ).toAction(),
            ),
          ],
        ),
      ),
    );
  });

  dashbook.storiesOf('InfoScreen').decorator(CenterDecorator()).add('default',
      (_) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme(),
      home: InfoScreen(
        model: InfoModel(
          imageURL:
              'https://cdn.icon-icons.com/icons2/1744/PNG/512/3643769-building-home-house-main-menu-start_113416.png',
          title: 'Sua conta de depósito de câmbio foi criada',
          content: 'Confira seus novos dados bancários para receber.',
          action: ActionModel(
            label: 'Ir para o meu Dashboard',
            action: 'go_to_dashboard',
          ).toAction(),
        ),
      ),
    );
  });

  dashbook
      .storiesOf('CheckoutTaxDetailsWidget')
      .decorator(CenterDecorator())
      .add(
        'default',
        (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme(),
          home: Scaffold(
            body: Container(
              margin: const EdgeInsets.all(20),
              child: CheckoutTaxDetailsWidget(),
            ),
          ),
        ),
      );

  dashbook
      .storiesOf('CheckoutConfirmationWidget')
      .decorator(CenterDecorator())
      .add(
        'default',
        (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme(),
          home: Scaffold(
            body: Container(
              margin: const EdgeInsets.all(20),
              child: CheckoutConfirmationWidget(),
            ),
          ),
        ),
      );

  dashbook.storiesOf('WarningModalWidget').decorator(CenterDecorator()).add(
    'default',
    (context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme(),
        home: Scaffold(
          body: Builder(builder: (bContext) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ModalHelper.showWarningBottomSheet(
                bContext,
                title: context.textProperty(
                  'title',
                  'O valor ultrapassa o limite de transferência de peso argentino',
                ),
                content: context.textProperty(
                  'content',
                  'Só é possível enviar em ARS valores equivalentes a até USD 1.500,00 por transação. Na cotação atual, você pode enviar até ARS 10.459,78. Se desejar transferir valores maiores, crie um novo envio em dólar.',
                ),
                imageURL: context.textProperty(
                  'imageURL',
                  'https://cdn.zeplin.io/5e43195007ed419040a52c48/assets/4e31f39b-566d-4c49-8b4c-51b0889f3a46.png',
                ),
                isDismissible: context.boolProperty('closeButton', true),
                primaryAction: ac.Action(name: 'Inserir um valor menor'),
                secondaryAction: ac.Action(name: 'Inserir um valor menor'),
              );
            });

            return Container();
          }),
        ),
      );
    },
  ).add(
    'primary action only',
    (context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme(),
        home: Scaffold(
          body: Builder(builder: (bContext) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ModalHelper.showWarningBottomSheet(
                bContext,
                title: context.textProperty(
                  'title',
                  'O valor ultrapassa o limite de transferência de peso argentino',
                ),
                content: context.textProperty(
                  'content',
                  'Só é possível enviar em ARS valores equivalentes a até USD 1.500,00 por transação. Na cotação atual, você pode enviar até ARS 10.459,78. Se desejar transferir valores maiores, crie um novo envio em dólar.',
                ),
                imageURL: context.textProperty(
                  'imageURL',
                  'https://cdn.zeplin.io/5e43195007ed419040a52c48/assets/4e31f39b-566d-4c49-8b4c-51b0889f3a46.png',
                ),
                isDismissible: context.boolProperty('closeButton', true),
                primaryAction: ac.Action(name: 'Inserir um valor menor'),
              );
            });

            return Container();
          }),
        ),
      );
    },
  ).add(
    'secondary action only',
    (context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme(),
        home: Scaffold(
          body: Builder(builder: (bContext) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ModalHelper.showWarningBottomSheet(
                bContext,
                title: context.textProperty(
                  'title',
                  'O valor ultrapassa o limite de transferência de peso argentino',
                ),
                content: context.textProperty(
                  'content',
                  'Só é possível enviar em ARS valores equivalentes a até USD 1.500,00 por transação. Na cotação atual, você pode enviar até ARS 10.459,78. Se desejar transferir valores maiores, crie um novo envio em dólar.',
                ),
                imageURL: context.textProperty(
                  'imageURL',
                  'https://cdn.zeplin.io/5e43195007ed419040a52c48/assets/4e31f39b-566d-4c49-8b4c-51b0889f3a46.png',
                ),
                isDismissible: context.boolProperty('closeButton', true),
                secondaryAction: ac.Action(name: 'Inserir um valor menor'),
              );
            });

            return Container();
          }),
        ),
      );
    },
  ).add(
    'without action',
    (context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme(),
        home: Scaffold(
          body: Builder(builder: (bContext) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ModalHelper.showWarningBottomSheet(
                bContext,
                title: context.textProperty(
                  'title',
                  'O valor ultrapassa o limite de transferência de peso argentino',
                ),
                content: context.textProperty(
                  'content',
                  'Só é possível enviar em ARS valores equivalentes a até USD 1.500,00 por transação. Na cotação atual, você pode enviar até ARS 10.459,78. Se desejar transferir valores maiores, crie um novo envio em dólar.',
                ),
                imageURL: context.textProperty(
                  'imageURL',
                  'https://cdn.zeplin.io/5e43195007ed419040a52c48/assets/4e31f39b-566d-4c49-8b4c-51b0889f3a46.png',
                ),
                isDismissible: context.boolProperty('closeButton', true),
              );
            });

            return Container();
          }),
        ),
      );
    },
  );

  runApp(dashbook);
}
