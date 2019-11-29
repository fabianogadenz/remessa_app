import 'package:remessa_app/helpers/screen_state.dart';
import 'package:remessa_app/models/pagination_model.dart';
import 'package:remessa_app/models/responses/transaction_response_model.dart';

class DashboardScreenState extends ScreenState<List<Transaction>> {
  final PaginationModel pagination;

  DashboardScreenState({
    value,
    this.pagination,
  }) : super(value: value);

  static initialState() => DashboardScreenState(value: <Transaction>[]);
}
