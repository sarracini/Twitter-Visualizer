class hashTag {

  String tag;
  float x;
  float y;
  int sizeX;
  int sizeY;

  hashTag (String theTag, float xpos, float ypos, int theSizeX, int theSizeY) {
    tag = theTag;
    x = xpos;
    y = ypos;
    sizeX = theSizeX;
    sizeY = theSizeY;
  }

  void drawTheHashTag() {
    text(tag, x, y, sizeX, sizeY);
  }

}

