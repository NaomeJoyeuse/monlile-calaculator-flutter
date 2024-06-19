import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output = "0";
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  Widget buildButton(String buttonText, Color buttonColor, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.all(20.0),
            ),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
          ),
          onPressed: () {
            buttonPressed(buttonText);
          },
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "±") {
      if (_output.contains("-")) {
        _output = _output.substring(1);
      } else {
        _output = "-" + _output;
      }
    } else if (buttonText == "%") {
      _output = (double.parse(_output) / 100).toString();
    } else if (buttonText == "." && !_output.contains(".")) {
      _output = _output + buttonText;
    } else if (buttonText == "+" ||
               buttonText == "-" ||
               buttonText == "×" ||
               buttonText == "÷") {
      num1 = double.parse(_output);
      operand = buttonText;
      _output = "0";
    } else if (buttonText == "=") {
      num2 = double.parse(_output);

      if (operand == "+") {
        _output = (num1 + num2).toString();
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      if (operand == "×") {
        _output = (num1 * num2).toString();
      }
      if (operand == "÷") {
        _output = (num1 / num2).toString();
      }

      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else {
      _output = _output + buttonText;
    }

    setState(() {
      output = double.parse(_output).toStringAsFixed(2).replaceFirst(RegExp(r'\.00$'), '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.centerRight,
            child: Text(
              output,
              style: TextStyle(color: Colors.white, fontSize: 80.0),
            ),
          ),
          Row(
            children: [
              buildButton('C', Colors.grey),
              buildButton('±', Colors.grey),
              buildButton('%', Colors.grey),
              buildButton('÷', Colors.orange),
            ],
          ),
          Row(
            children: [
              buildButton('7', Colors.grey.shade800),
              buildButton('8', Colors.grey.shade800),
              buildButton('9', Colors.grey.shade800),
              buildButton('×', Colors.orange),
            ],
          ),
          Row(
            children: [
              buildButton('4', Colors.grey.shade800),
              buildButton('5', Colors.grey.shade800),
              buildButton('6', Colors.grey.shade800),
              buildButton('−', Colors.orange),
            ],
          ),
          Row(
            children: [
              buildButton('1', Colors.grey.shade800),
              buildButton('2', Colors.grey.shade800),
              buildButton('3', Colors.grey.shade800),
              buildButton('+', Colors.orange),
            ],
          ),
          Row(
            children: [
              buildButton('0', Colors.grey.shade800, flex: 2),
              buildButton('.', Colors.grey.shade800),
              buildButton('=', Colors.orange),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
