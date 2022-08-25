class Formula {
  double pie = 3.14;
  double coreDiameterInInches;
  int poll;
  int volts;
  double length;

  Formula();

  bool isNotNull() {
    return pie != null && coreDiameterInInches != null && poll != null && volts != null && length != null;
  }
}
