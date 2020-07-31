import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/helpers/track_events.dart';
import 'package:remessa_app/helpers/uxcam_helper.dart';
import 'package:remessa_app/models/responses/beneficiary_response_model.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/router.dart';
import 'package:remessa_app/screens/recurrence/widgets/beneficiary_list_item_widget.dart';
import 'package:remessa_app/screens/redirect/website_redirect_screen_args.dart';
import 'package:remessa_app/stores/beneficiary_store.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/widgets/gradient_button_widget.dart';
import 'package:screens/overlay_widget.dart';

class BeneficiaryScreen extends StatefulWidget {
  BeneficiaryScreen({
    Key key,
  }) : super(key: key);

  @override
  _BeneficiaryScreenState createState() => _BeneficiaryScreenState();
}

class _BeneficiaryScreenState extends State<BeneficiaryScreen> with RouteAware {
  final i18n = GetIt.I<I18n>();

  final navigator = GetIt.I<NavigatorHelper>();

  final beneficiaryStore = BeneficiaryStore()..getBeneficiaries();

  @override
  void initState() {
    FlutterUxcam.tagScreenName(UxCamHelper.BENEFICIARY);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    try {
      navigator.subscribeRoute(this, context);
    } catch (e) {
      // Throw error when navigate to modal/bottom sheet
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    navigator.unsubscribeRoute(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    FlutterUxcam.tagScreenName(UxCamHelper.BENEFICIARY);
  }

  websiteRedirect(String url) => navigator.pushNamed(
        Router.WEBSITE_REDIRECT_ROUTE,
        arguments: WebsiteRedirectScreenArgs(
          url: url,
        ),
      );

  Widget _buildEmptyState(BeneficiaryResponseModel beneficiaryResponseModel) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'images/new_transaction_empty_state.png',
                    width: 170,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 260,
                    child: Text(
                      i18n.trans('beneficiary_screen', ['body']),
                      style: TextStyle(
                        color: StyleColors.BRAND_SECONDARY_50,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 24),
              child: GradientButtonWidget(
                  label: i18n.trans('beneficiary_screen', ['action']),
                  onPressed: () {
                    TrackEvents.log(
                      TrackEvents.BENEFICIARY_NEW_TRANSACTION_CLICK,
                      {'first_remittance': true},
                    );
                    websiteRedirect(beneficiaryResponseModel.defaultUrl);
                  }),
            ),
          ],
        ),
      );

  Widget _buildBeneficiariesList(
      BuildContext context, BeneficiaryResponseModel beneficiaryResponseModel) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: 65,
            bottom: 110,
            left: 24,
            right: 24,
          ),
          child: Column(
            children: beneficiaryResponseModel.beneficiaries
                .map<Widget>(
                  (beneficiary) =>
                      BeneficiaryListItemWidget(beneficiary: beneficiary),
                )
                .toList(),
          ),
        ),
        Positioned(
          bottom: 0,
          child: GestureDetector(
            onTap: () {
              TrackEvents.log(
                TrackEvents.BENEFICIARY_NEW_TRANSACTION_CLICK,
                {'first_remittance': false},
              );
              websiteRedirect(beneficiaryResponseModel.defaultUrl);
            },
            child: Column(
              children: <Widget>[
                Container(
                  height: 80,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        StyleColors.SUPPORT_NEUTRAL_10.withOpacity(0),
                        StyleColors.SUPPORT_NEUTRAL_10,
                      ],
                    ),
                  ),
                ),
                Container(
                  color: StyleColors.SUPPORT_NEUTRAL_10,
                  height: 100,
                  width: screenWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        i18n.trans('beneficiary_screen', ['new_beneficiary']),
                        style: TextStyle(
                          color: StyleColors.BRAND_SECONDARY_50,
                        ),
                      ),
                      Text(
                        i18n.trans('beneficiary_screen', ['new_transaction']),
                        style: TextStyle(
                          color: StyleColors.BRAND_PRIMARY_40,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildState(context) {
    final beneficiaryResponseModel = beneficiaryStore?.beneficiaryResponseModel;

    return beneficiaryResponseModel?.beneficiaries != null &&
            beneficiaryResponseModel.beneficiaries.isNotEmpty
        ? _buildBeneficiariesList(context, beneficiaryResponseModel)
        : _buildEmptyState(beneficiaryResponseModel);
  }

  @override
  Widget build(BuildContext context) {
    final header = Container(
      decoration: BoxDecoration(
        color: StyleColors.SUPPORT_NEUTRAL_10,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 8,
          ),
          Container(
            height: 4,
            width: 60,
            decoration: BoxDecoration(
              color: StyleColors.SUPPORT_NEUTRAL_30,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  i18n.trans('beneficiary_screen', ['header']),
                  style: TextStyle(
                    color: StyleColors.BRAND_PRIMARY_80,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                GestureDetector(
                  onTap: navigator.pop,
                  child: Icon(
                    RemessaIcons.close,
                    color: StyleColors.BRAND_PRIMARY_40,
                    size: 18,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );

    return Observer(
      builder: (_) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: StyleColors.SUPPORT_NEUTRAL_10,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15),
          ),
        ),
        child: OverlayWidget(
          _buildState(context),
          fixedOverlayWidgets: <Widget>[header],
          loaderWidget: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15),
              ),
            ),
            height: double.infinity,
            width: double.infinity,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  StyleColors.BRAND_PRIMARY_60,
                ),
              ),
            ),
          ),
        )..loaderStreamController.add(beneficiaryStore.isLoading),
      ),
    );
  }
}
