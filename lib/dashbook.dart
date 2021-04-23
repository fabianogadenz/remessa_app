import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dashbook/dashbook.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/environment_model.dart';
import 'package:remessa_app/models/actions/action_model.dart';
import 'package:remessa_app/models/actions/content_action_model.dart';
import 'package:remessa_app/models/actions/link_action_model.dart';
import 'package:remessa_app/models/config_model.dart';
import 'package:remessa_app/models/track_event_model.dart';
import 'package:remessa_app/models/view_generators/info_model.dart';
import 'package:remessa_app/models/view_generators/info_stepper_model.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/screens/info/info_screen.dart';
import 'package:remessa_app/screens/info_stepper/info_stepper_screen.dart';
import 'package:remessa_app/setup.dart';
import 'package:remessa_app/theme.dart';
import 'package:remessa_app/v2/core/handlers/show_warning_modal_handler.dart';
import 'package:remessa_app/v2/modules/transaction/application/viewmodels/account_info_viewmodel.dart';
import 'package:remessa_app/v2/modules/transaction/application/viewmodels/beneficiary_viewmodel.dart';
import 'package:remessa_app/v2/modules/transaction/application/viewmodels/intermediary_bank_info_viewmodel.dart';
import 'package:remessa_app/v2/modules/transaction/application/viewmodels/payment_rules_viewmodel.dart';

import 'package:remessa_app/v2/core/actions/action.dart' as ac;
import 'package:remessa_app/v2/modules/transaction/view/screens/checkout_beneficiary_data/checkout_beneficiary_data_screen.dart';
import 'package:remessa_app/v2/modules/transaction/view/screens/checkout_payment_data/checkout_payment_data_screen.dart';
import 'package:remessa_app/v2/modules/transaction/view/screens/checkout_success/checkout_success_screen.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/checkout_confirmation/checkout_confirmation_widget.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/checkout_tax_details/checkout_tax_details_widget.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/payment_rules/payment_rules_widget.dart';
import 'package:remessa_app/v2/core/widgets/accent_app_bar_widget.dart';

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
                    trackEvent: TrackEvent(name: 'kdskds'),
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
                    trackEvent: TrackEvent(name: 'kdskds'),
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
              final show = ShowWarningModalHandler(
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

              show(bContext);
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
              final show = ShowWarningModalHandler(
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

              show(bContext);
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
              final show = ShowWarningModalHandler(
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

              show(bContext);
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
              final show = ShowWarningModalHandler(
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

              show(bContext);
            });

            return Container();
          }),
        ),
      );
    },
  );

  dashbook
      .storiesOf('PaymentRulesWidget')
      .decorator(CenterDecorator())
      .add(
        'simple',
        (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme(),
          home: Scaffold(
            body: Container(
              color: Colors.white,
              child: PaymentRulesWidget(
                paymentRules: [
                  PaymentRulesViewModel(
                    icon: RemessaIcons.deadline,
                    value:
                        'Você tem até as 16h30 do dia 13/06 para realizar o pagamento via TED.',
                    hasDivider: true,
                  ),
                  PaymentRulesViewModel(
                    icon: RemessaIcons.owner,
                    value:
                        'A TED deve ser enviada de uma conta bancária de pessoa física em que você é o titular. Se for uma conta conjunta, <a href="https://google.com">comprove sua titularidade no site.</a>',
                    hasDivider: true,
                  ),
                  PaymentRulesViewModel(
                    icon: RemessaIcons.attention_oval_outline,
                    value:
                        'Caso o pagamento não seja identificado dentro do prazo ou seja feito por outro meio que não seja TED, sua remessa será cancelada.',
                    hasDivider: false,
                    isWarning: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      )
      .add(
        'complete',
        (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme(),
          home: Scaffold(
            body: Container(
              color: Colors.white,
              child: PaymentRulesWidget(
                title: 'Antes de fazer o pagamento, confira as regras',
                action: ac.Action(
                  name: 'Aceito as regras de pagamento',
                ),
                paymentRules: [
                  PaymentRulesViewModel(
                    icon: RemessaIcons.deadline,
                    value:
                        'Você tem até as 16h30 do dia 13/06 para realizar o pagamento via TED.',
                    hasDivider: true,
                  ),
                  PaymentRulesViewModel(
                    icon: RemessaIcons.owner,
                    value:
                        'A TED deve ser enviada de uma conta bancária de pessoa física em que você é o titular. Se for uma conta conjunta, <a>comprove sua titularidade no site.</a>',
                    hasDivider: true,
                  ),
                  PaymentRulesViewModel(
                    icon: RemessaIcons.attention_oval_outline,
                    value:
                        'Caso o pagamento não seja identificado dentro do prazo ou seja feito por outro meio que não seja TED, sua remessa será cancelada.',
                    hasDivider: false,
                    isWarning: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      )
      .add(
        'dark',
        (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme(),
          home: Scaffold(
            body: PaymentRulesWidget(
              isDarkMode: true,
              paymentRules: [
                PaymentRulesViewModel(
                  icon: RemessaIcons.deadline,
                  value:
                      'Você tem até as 16h30 do dia 13/06 para realizar o pagamento via TED.',
                  hasDivider: true,
                ),
                PaymentRulesViewModel(
                  icon: RemessaIcons.owner,
                  value:
                      'A TED deve ser enviada de uma conta bancária de pessoa física em que você é o titular. Se for uma conta conjunta, <a>comprove sua titularidade no site.</a>',
                  hasDivider: true,
                ),
                PaymentRulesViewModel(
                  icon: RemessaIcons.attention_oval_outline,
                  value:
                      'Caso o pagamento não seja identificado dentro do prazo ou seja feito por outro meio que não seja TED, sua remessa será cancelada.',
                  hasDivider: false,
                  isWarning: true,
                ),
              ],
            ),
          ),
        ),
      );

  dashbook.storiesOf('BeneficiaryDataScreen').decorator(CenterDecorator()).add(
        'default',
        (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme(),
          home: CheckoutBeneficiaryDataScreen(
            beneficiary: BeneficiaryViewModel(
              name: 'Reinaldo Antunes',
              bankName: 'Bank of New York',
              country: 'Estados Unidos',
              accountInfo: [
                AccountInfoViewModel(
                  label: 'Campo dinâmico Account Info',
                  value: '1',
                ),
              ],
              intermediaryBankInfo: [
                IntermediaryBankInfoViewModel(
                  label: 'Campo dinâmico Intermediary Bank Info',
                  value: '2',
                ),
              ],
            ),
          ),
        ),
      );

  dashbook
      .storiesOf('ProgressAppBarWidget')
      .decorator(CenterDecorator())
      .add('default', (_) {
    final screen = Scaffold(
      appBar: AccentAppBarWidget(
        title: 'lalala',
        steps: 3,
        currentStep: 1,
      ),
      body: Container(
        color: Colors.red,
        width: double.infinity,
        height: 900,
      ),
    );

    final screen2 = Scaffold(
      appBar: AccentAppBarWidget(
        title: 'dsads',
        steps: 3,
        currentStep: 2,
      ),
      body: Builder(builder: (context) {
        // progressAppBarStore.load();
        return Container(
          color: Colors.green,
          width: double.infinity,
          height: 900,
          child: Center(
            child: Column(
              children: [
                FlatButton(
                  child: Text('Go'),
                  onPressed: () {
                    return Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Scaffold(
                          appBar: AccentAppBarWidget(
                            title: 'dsads',
                            steps: 3,
                            currentStep: 3,
                          ),
                          body: Container(),
                        ),
                      ),
                    );
                  },
                ),
                FlatButton(
                  child: Text('Back'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      }),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme(),
      home: Builder(builder: (context) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => screen2,
            ),
          );
        });

        return screen;
      }),
    );
  });

  dashbook.storiesOf('CheckoutSuccessScreen').decorator(CenterDecorator()).add(
        'default',
        (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme(),
          home: CheckoutSuccessScreen(),
        ),
      );

  dashbook
      .storiesOf('CheckoutPaymentDataScreen')
      .decorator(CenterDecorator())
      .add(
    'default',
    (context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme(),
        localizationsDelegates: [
          I18nDelegate(locales: ['pt']),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          // const Locale('en', ''),
          const Locale('pt', ''),
        ],
        localeResolutionCallback:
            (Locale locale, Iterable<Locale> supportedLocales) {
          if (locale == null) return supportedLocales.first;

          for (Locale supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode ||
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }

          return supportedLocales.first;
        },
        home: Builder(
          builder: (context) {
            GetIt.I.reset();
            SetUp.registerI18n(context);

            return CheckoutPaymentDataScreen();
          },
        ),
      );
    },
  );

  runApp(dashbook);
}
