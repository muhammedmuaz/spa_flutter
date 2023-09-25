import 'package:flutter/material.dart';
import 'package:orgate/data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('SLP Gates'),
        ),
        body: PerceptronScreen(),
      ),
    );
  }
}

class PerceptronScreen extends StatefulWidget {
  @override
  _PerceptronScreenState createState() => _PerceptronScreenState();
}

class _PerceptronScreenState extends State<PerceptronScreen> {
  double learningRate = 0.1;
  double calculateWeightedSum(
      double input1, double weight, double input2, double weight2) {
    return (input1 * weight) + (input2 * weight2) + orGatebias;
  }

  int activationFunction(double weightedSum) {
    if (weightedSum > 0) {
      return 1;
    } else {
      return 0;
    }
  }

  void trainPerceptronAndGate() {
    for (var data in trainingDataAndGate) {
      double input1 = data[0];
      double input2 = data[1];
      int targetOutput = data[2].toInt();
      double weightedSum =
          calculateWeightedSum(input1, andGateweight1, input2, andGateweight1);
      int predictedOutput = activationFunction(weightedSum);
      int error = targetOutput - predictedOutput;
      andGateweight1 += learningRate * error * input1;
      andGateweight2 += learningRate * error * input2;
      andGatebias += learningRate * error;
    }
  }

  void trainPerceptron() {
    for (var data in trainingDataOrGate) {
      double input1 = data[0];
      double input2 = data[1];
      int targetOutput = data[2].toInt();
      double weightedSum =
          calculateWeightedSum(input1, orGateweight1, input2, orGateweight2);
      int predictedOutput = activationFunction(weightedSum);
      int error = targetOutput - predictedOutput;
      orGateweight1 += learningRate * error * input1;
      orGateweight2 += learningRate * error * input2;
      orGatebias += learningRate * error;
    }
  }

  void predictAndGate() {
    double userinput1 = double.tryParse(input3Controller.text) ?? 0.0;
    double userinput2 = double.tryParse(input4Controller.text) ?? 0.0;

    double weightedSum = calculateWeightedSum(
        userinput1, andGateweight1, userinput2, andGateweight2);
    int predictedOutput = activationFunction(weightedSum);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Prediction Result'),
          content: Text(
              'Input: $userinput1 OR $userinput2\nPredicted Output: $predictedOutput'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Handle the prediction when the user presses the "Predict" button
  void predict() {
    // Get user input from text fields
    double userinput1 = double.tryParse(input1Controller.text) ?? 0.0;
    double userinput2 = double.tryParse(input2Controller.text) ?? 0.0;

    // Calculate the predicted output
    double weightedSum = calculateWeightedSum(
        userinput1, orGateweight1, userinput2, orGateweight2);
    int predictedOutput = activationFunction(weightedSum);

    // Show a dialog with the prediction result
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Prediction Result'),
          content: Text(
              'Input: $userinput1 OR $userinput2\nPredicted Output: $predictedOutput'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Or Gate Controller
  TextEditingController input1Controller = TextEditingController();
  TextEditingController input2Controller = TextEditingController();

  // And Gate Controller
  TextEditingController input3Controller = TextEditingController();
  TextEditingController input4Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('OR Gate Perceptron', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 20),
          // Text fields for user input
          TextField(
            controller: input1Controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Input 1'),
          ),
          TextField(
            controller: input2Controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Input 2'),
          ),
          const SizedBox(height: 20),
          // Buttons for training and prediction
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: trainPerceptron,
                child: Text('Train'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: predict,
                child: Text('Predict'),
              ),
            ],
          ),

          const SizedBox(
            height: 40,
          ),

          const Text('And Gate Perceptron', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 20),
          // Text fields for user input
          TextField(
            controller: input3Controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Input 1'),
          ),
          TextField(
            controller: input4Controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Input 2'),
          ),
          const SizedBox(height: 20),
          // Buttons for training and prediction
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: trainPerceptronAndGate,
                child: const Text('Train'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: predictAndGate,
                child: const Text('Predict'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
