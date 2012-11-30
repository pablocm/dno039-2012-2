class ProgressBar {
  int x, y;
  int barLength, barWidth;
  color fillColor;
  color backColor;
  int minValue;
  int maxValue;
  int currentValue;

  public ProgressBar(int x, int y, int barWidth, int barLength) {
    this.x = x;
    this.y = y;
    this.barLength = barLength;
    this.barWidth = barWidth;
    this.fillColor = color(0, 224, 0);
    this.backColor = color(64);
    this.minValue = 0;
    this.maxValue = 100;
  }
  
  void setValue(int value) {
    // clamp entre min y max
    this.currentValue = Math.max(Math.min(value, maxValue), minValue);
  }
  
  void addValue(int value) {
    // clamp entre min y max
    this.currentValue = Math.max(Math.min(currentValue + value, maxValue), minValue);
  }
  
  float getPercentage() {
    return ((float)currentValue-minValue)/(maxValue-minValue);
  }
  
  void draw() {
    fill(backColor);
    rect(x,y, barWidth, barLength);

    fill(fillColor);
    rect(x,y, barWidth*getPercentage(), barLength);
  }
}
