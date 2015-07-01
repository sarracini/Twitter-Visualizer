String[] theSavedTweets;
boolean doIChangeTweet = false;

class tweetBox {
  float x;
  float y;
  String myTweet;
  int sizeX;
  int sizeY;
  int tag;

  tweetBox (int theTag, String theTweet, float xpos, 
  float ypos, int theSizeX, int theSizeY) {
    tag = theTag;
    x = xpos;
    y = ypos;
    myTweet = theTweet;
    sizeX = theSizeX;
    sizeY = theSizeY;
  }

  int gimmeTag() {
    return tag;
  }

  void drawTweetBox() {
    text(myTweet, x, y, sizeX, sizeY);
    noStroke();
    noFill();
    rect(x, y+25, sizeX, sizeY-50, 7);

  }

  void setThePosition(float xpos) {
    x = xpos - 310;
  }

  String accessTweet() {
    return myTweet;
  } 
}

