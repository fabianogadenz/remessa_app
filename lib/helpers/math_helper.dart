class MathHelper {
  static double totalValueFromPercentageDiscount(
          double currentValue, double discount) =>
      (currentValue / (100 - discount)) * 100;
}
