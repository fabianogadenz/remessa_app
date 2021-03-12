import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/helpers/track_events.dart';
import 'package:remessa_app/models/responses/error_response_model.dart';
import 'package:remessa_app/stores/simulator_store.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/core/widgets/close_button_widget.dart';
import 'package:remessa_app/v2/core/widgets/gradient_button_widget.dart';
import 'package:remessa_app/v2/core/widgets/text_input/text_input_widget.dart';

class CouponWidget extends StatefulWidget {
  final SimulatorStore simulatorStore;

  const CouponWidget({Key key, @required this.simulatorStore})
      : assert(simulatorStore != null),
        super(key: key);

  @override
  _CouponWidgetState createState() => _CouponWidgetState();
}

class _CouponWidgetState extends State<CouponWidget> {
  SimulatorStore get simulatorStore => widget.simulatorStore;
  final couponTextCtrl = TextEditingController();
  final _i18n = GetIt.I<I18n>();

  String _voucherCode;

  bool _isDisabled = true;
  bool _isLoading = false;
  bool _isSuccess = false;
  ErrorResponseModel _voucherError;

  bool get _hasError => _voucherError != null;

  @override
  void initState() {
    if (simulatorStore.voucherCode != null) {
      couponTextCtrl.text = simulatorStore.voucherCode;
      _isSuccess = true;
    }

    super.initState();
  }

  _onTextChanged(String value) {
    if (value == '') {
      setState(() {
        _isDisabled = true;
      });
    } else {
      _voucherCode = value;

      setState(() {
        _isDisabled = false;
        _isSuccess = false;
        _voucherError = null;
      });
    }
  }

  _autoClose() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (_isSuccess) GetIt.I<NavigatorHelper>().pop();
      },
    );
  }

  _applyCoupon() async {
    setState(() {
      _isLoading = true;
    });

    _voucherError = await simulatorStore.applyVoucher(_voucherCode);

    TrackEvents.log(
      TrackEvents.SIMULATOR_VALIDATE_COUPON_CLICK,
      {'is_valid': !_hasError},
    );

    setState(() {
      _isLoading = false;
      _isSuccess = !_hasError;
    });

    if (_isSuccess) {
      _autoClose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: StyleColors.SUPPORT_NEUTRAL_10,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _i18n.trans('simulator_screen', ['coupon', 'title']),
                  style: TextStyle(
                    color: StyleColors.BRAND_PRIMARY_80,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CloseButtonWidget(),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextInputWidget(
                  controller: couponTextCtrl,
                  isDisabled: _isLoading,
                  hasError: _hasError,
                  onChanged: _onTextChanged,
                  decoration: InputDecoration(
                    suffixIconConstraints: BoxConstraints(
                      maxHeight: 0,
                      minWidth: 25,
                    ),
                    labelText: _i18n.trans('coupon'),
                  ),
                ),
                _hasError
                    ? Text(
                        _voucherError.message,
                        style: TextStyle(
                          color: StyleColors.SUPPORT_DANGER_40,
                        ),
                      )
                    : Container(),
              ],
            ),
            SizedBox(
              height: 48,
            ),
            GradientButtonWidget(
              label: _isSuccess
                  ? _i18n.trans(
                      'simulator_screen', ['coupon', 'action', 'success'])
                  : _i18n.trans(
                      'simulator_screen', ['coupon', 'action', 'default']),
              isDisabled: _isDisabled || _hasError,
              isLoading: _isLoading,
              isSuccess: _isSuccess,
              onPressed: _applyCoupon,
            ),
          ],
        ),
      ),
    );
  }
}
