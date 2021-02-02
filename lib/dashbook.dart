import 'package:flutter/material.dart';

import 'package:dashbook/dashbook.dart';
import 'package:remessa_app/helpers/environment_model.dart';
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
import 'package:remessa_app/v2/modules/transaction/widgets/checkout_tax_details/checkout_tax_details_widget.dart';

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

  runApp(dashbook);
}
