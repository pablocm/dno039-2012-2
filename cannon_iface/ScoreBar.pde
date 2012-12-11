class ScoreBar {
  int x, y;
  int minValue;
  int maxValue;
  int currentValue;
  PImage dogsImg;

  public ScoreBar(int x, int y) {
    this.x = x;
    this.y = y;
    this.minValue = 0;
    this.maxValue = 10;
    
    dogsImg = loadImage("data/perro.png");
  }
  
  void setValue(int value) {
    // clamp entre min y max
    this.currentValue = Math.max(Math.min(value, maxValue), minValue);
  }
  
  void addValue(int value) {
    // clamp entre min y max
    this.currentValue = Math.max(Math.min(currentValue + value, maxValue), minValue);
  }
  
  void draw() {
    for (int i = 0; i < this.currentValue; i++) {
      image(dogsImg, x + i*pixelX(51), y, pixelX(51), pixelY(27));
    }
  }
}
