import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:remessa_app/screens/calculator/bloc/bloc.dart';
import 'package:remessa_app/widgets/screen/screen_widget.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final _formKey = GlobalKey<FormState>();

  double dollarSpread = 0;
  double iofValue = 0;
  double result = 0;

  final valueCtrl = TextEditingController();
  final dollarCtrl = TextEditingController();
  final spreadCtrl = TextEditingController();
  final iofCtrl = TextEditingController(text: '6.38');

  CalculatorBloc _calculatorBloc;

  @override
  void initState() {
    _calculatorBloc = CalculatorBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: BlocListener<CalculatorBloc, CalculatorState>(
        bloc: _calculatorBloc,
        listener: (context, state) {
          if (state is PtaxDollarState) {
            dollarCtrl.text = state.dollarValue.toString();
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 80,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: valueCtrl,
                    decoration: InputDecoration(
                      labelText: 'Valor do produto (em dólar)',
                      hintText: '1000',
                      prefixText: '\$ ',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: TextFormField(
                            controller: dollarCtrl,
                            decoration: InputDecoration(
                              labelText: 'Dólar',
                              hintText: '4.1',
                              prefixText: '\$ ',
                              suffixIcon: IconButton(
                                icon: Icon(Icons.attach_money),
                                onPressed: () {
                                  _calculatorBloc.dispatch(
                                    LoadPtaxDollar(dateTime: DateTime.now()),
                                  );
                                },
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 75,
                              height: 75,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 7.5),
                                // child: DropdownButton(
                                //   value: 0,
                                //   onChanged: (_) {},
                                //   items: [
                                //     DropdownMenuItem(
                                //       value: 0,
                                //       child: Center(
                                //         child: Image.network(
                                //             'https://beta.paganresearch.io/images/Nubank.jpg'),
                                //       ),
                                //     ),
                                //     DropdownMenuItem(
                                //       value: 1,
                                //       child: Text('lslsadas'),
                                //     ),
                                //   ],
                                // ),
                                child: TextFormField(
                                  controller: spreadCtrl,
                                  decoration: InputDecoration(
                                    labelText: 'Spread',
                                    hintText: '4',
                                    suffixText: '%',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 7.5),
                                child: TextFormField(
                                  controller: iofCtrl,
                                  decoration: InputDecoration(
                                    labelText: 'IOF',
                                    hintText: '6.38',
                                    suffixText: '%',
                                  ),
                                  keyboardAppearance: Brightness.dark,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          final valueDollar =
                              double.parse(valueCtrl.value.text);
                          final dollar = double.parse(dollarCtrl.value.text);
                          final spread = double.parse(spreadCtrl.value.text);
                          final iof = double.parse(iofCtrl.value.text);

                          dollarSpread = dollar * (spread / 100) + dollar;
                          final value = valueDollar * dollarSpread;
                          setState(() {
                            iofValue = value * (iof / 100);
                            result = value + iofValue;
                          });
                        }

                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: Text('Calcular'),
                    ),
                  ),
                  DataTable(
                    columns: [
                      DataColumn(
                        label: Text(
                          'LABEL',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'VALOR',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                    rows: [
                      DataRow(
                        cells: [
                          DataCell(
                            Text('Produto'),
                          ),
                          DataCell(
                            Text('R\$ ${result - iofValue}'),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text('Dólar Spread'),
                          ),
                          DataCell(
                            Text('R\$ $dollarSpread'),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text('IOF'),
                          ),
                          DataCell(
                            Text('R\$ $iofValue'),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              'Total',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DataCell(
                            Text('R\$ $result'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
