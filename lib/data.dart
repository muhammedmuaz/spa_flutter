List<List<double>> trainingDataOrGate = [
  [0, 0, 0], // Input: 0 OR 0 = 0
  [0, 1, 1], // Input: 0 OR 1 = 1
  [1, 0, 1], // Input: 1 OR 0 = 1
  [1, 1, 1], // Input: 1 OR 1 = 1
];

List<List<double>> trainingDataAndGate = [
  [0, 0, 0], // Input: 0 OR 0 = 0
  [0, 1, 0], // Input: 0 OR 1 = 1
  [1, 0, 0], // Input: 1 OR 0 = 1
  [1, 1, 1], // Input: 1 OR 1 = 1
];

// Initialize weights and bias for the OR gate
double orGateweight1 = 0.1; // Weight for input 1
double orGateweight2 = 0.1; // Weight for input 2
double orGatebias = -0.39; // Bias term

// Initialize weights and bias for the OR gate
double andGateweight1 = 0.1; // Weight for input 1
double andGateweight2 = 0.1; // Weight for input 2
double andGatebias = -0.39; // Bias term