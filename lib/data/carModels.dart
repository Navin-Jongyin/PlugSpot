class CarModels {
  static List<List<String>> _carModel = [
    [
      'ATTO 3',
      'E2',
      'E6',
      'M3',
      'T3',
    ],
    [
      "EQS",
      "EQC",
      "EQV",
      "S 580e",
      "A 250e",
    ],
    [
      'Cayenne',
      'Cayenne E-Hybrid',
      'Panamera E-Hybrid',
      'Taycan',
      'Taycan Turbo',
      'Taycan Turbo S'
    ],
    ['Model S', 'Model 3', 'Model X', 'Model Y', 'Roadster'],
    ['C40', 'S60', 'S90', 'V90', 'XC40 Pure Electric']
  ];
  static List<List<String>> getModels() {
    return _carModel;
  }
}
