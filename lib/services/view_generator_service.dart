import 'package:dio/dio.dart';
import 'package:remessa_app/helpers/error.dart';
import 'package:remessa_app/models/view_model.dart';

class ViewGeneratorService {
  static Future<ViewGenerator> getViewGenerator(String url) async {
    try {
      // TODO: Remove mock
      // Response response = await GetIt.I<Dio>().get(url);

      // return ViewModel.fromJson(response.data);

      return Future.delayed(
        Duration(seconds: 2),
        () => ViewModel.fromJson(
          {
            'name': 'InfoStepperScreen',
            'params': {
              'steppers': [
                {
                  'header': {
                    'title': 'Novos Termos de Uso',
                  },
                  'title':
                      'Mudanças importantes na sua conta e novos dados bancários',
                  'content':
                      'Os novos dados bancários para pagar a TED serão exclusivos para você. Confira ao criar uma nova remessa.',
                },
                {
                  'header': {
                    'title': 'Novos Termos de Uso',
                    'link': {
                      'prefix': 'Acesse o',
                      'linkAction': {
                        'type': 'link',
                        'label': 'documento completo',
                        'url': 'google.com',
                        'trackEvent': 'kdskds',
                      },
                    },
                  },
                  'title':
                      'Mudanças importantes na sua conta e novos dados bancários',
                  'content':
                      'Os novos dados bancários para pagar a TED serão exclusivos para você. Confira ao criar uma nova remessa.',
                  'imageURL':
                      'https://cdn.icon-icons.com/icons2/1744/PNG/512/3643769-building-home-house-main-menu-start_113416.png',
                  'action': {
                    'type': 'action',
                    'label': 'Li e aceito os novos termos',
                    'action': 'accept_new_terms',
                  },
                  'linkAction': {
                    'type': 'content',
                    'label': 'Não aceito os novos termos',
                    'content': {
                      'name': 'InfoStepperScreen',
                      'params': {
                        'showAppBar': true,
                        'steppers': [
                          {
                            'title':
                                'Queremos entender você. Podemos conversar?',
                            'content':
                                'Para poder continuar utilizando os serviços da Remessa Online, é obrigatório aceitar os novos Termos de Uso, ou sua conta será bloqueada. Você ficou com alguma dúvida sobre os Termos? Fale com a gente pelo chat online.',
                            'imageURL':
                                'https://cdn.icon-icons.com/icons2/1744/PNG/512/3643769-building-home-house-main-menu-start_113416.png',
                            'action': {
                              'type': 'content',
                              'label': 'Aceito os termos',
                              'content': {
                                'name': 'InfoScreen',
                                'params': {
                                  'title':
                                      'Mudanças importantes na sua conta e novos dados bancários',
                                  'content':
                                      'Os novos dados bancários para pagar a TED serão exclusivos para você. Confira ao criar uma nova remessa.',
                                  'imageURL':
                                      'https://cdn.icon-icons.com/icons2/1744/PNG/512/3643769-building-home-house-main-menu-start_113416.png',
                                  'action': {
                                    'label': 'Li e aceito os novos termos',
                                    'action': 'go_to_dashboard',
                                  },
                                },
                              },
                            }
                          }
                        ],
                      },
                    },
                  },
                }
              ],
            },
          },
        ),
      );
    } on DioError catch (e) {
      ErrorHelper.throwFormattedErrorResponse(e);
    } catch (e) {
      throw e;
    }

    return null;
  }
}
