double completionValue(double value, double completed) {
  if (value == 0) return 0.0;
  return (completed / value).toDouble();
}

String? calculatePercentage(int length, int index) {
  if (length == 0) return null;
  double percentage = (index + 1) / length;
  if (percentage <= 0.25) return "25%";
  if (percentage == 0.50) return "50%";
  if (percentage <= 0.75 && percentage > 0.5) return "75%";
  if (percentage == 1.00) return "100%";
  return null;
}
