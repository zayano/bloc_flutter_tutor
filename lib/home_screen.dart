import 'package:bloc_flutter_tutor/bloc/calculator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _controllerNumberA = TextEditingController();
  final TextEditingController _controllerNumberB = TextEditingController();
  final CalculatorBloc _calculatorBloc = CalculatorBloc();

  void calculate(Operation operation) {
    int numberA = int.parse(_controllerNumberA.text.toString());
    int numberB = int.parse(_controllerNumberB.text.toString());
    _calculatorBloc.add(CalculatorEvent(operation, numberA, numberB));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter BLoC Calculator'),
      ),
      body: BlocProvider<CalculatorBloc>(
        create: (context) => _calculatorBloc,
        child: BlocListener<CalculatorBloc, CalculatorState>(
          listener: (context, state) {
            if (state is CalculatorFailed) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.error}'),
                ),
              );
            }
          },
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    controller: _controllerNumberA,
                    decoration: InputDecoration(
                      labelText: 'Number A',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: _controllerNumberB,
                    decoration: InputDecoration(
                      labelText: 'Number B',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          child: Text('+'),
                          onPressed: () {
                            calculate(Operation.plus);
                          },
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Expanded(
                        child: RaisedButton(
                          child: Text('-'),
                          onPressed: () {
                            calculate(Operation.minus);
                          },
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Expanded(
                        child: RaisedButton(
                          child: Text('X'),
                          onPressed: () {
                            calculate(Operation.multiple);
                          },
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Expanded(
                        child: RaisedButton(
                          child: Text('/'),
                          onPressed: () {
                            calculate(Operation.divide);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  BlocBuilder<CalculatorBloc, CalculatorState>(
                    builder: (context, state) {
                      if (state is CalculatorInitial) {
                        return Text('Result: -');
                      } else if (state is CalculatorSuccess) {
                        return Text('Result: ${state.result}');
                      } else if (state is CalculatorFailed) {
                        return Text('Result: ${state.error}');
                      } else {
                        return Container();
                      }
                    },
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
