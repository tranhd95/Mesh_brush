public static class Statistics {

  public static float mean(float[][] data) {
    float sum = 0;
    for (int i = 0; i < data.length; i++) {
      sum += data[i][0];
    }
    return sum / data.length;
  }
}