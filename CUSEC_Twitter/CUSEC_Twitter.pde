/*
CUSEC Twitter Visualizer
Written for the Canadian University Software
Engineering Conference (CUSEC)2015. This application 
queries twitter for tweets with the hashtag #CUSEC2015
and displays them in a circular sun web fashion.

Authors: Ursula Sarracini, Nichie Enriquez
*/
import java.util.Collection;
import java.util.HashSet;
import java.util.Arrays;

//For the visualization
ArrayList<particle> particles=new ArrayList<particle>();
ArrayList<spring> springs=new ArrayList<spring>();

//nodes
particle letter;
particle word;
particle sentence;
particle base;

// distances
float scaleVal;  //how much I'm scaling down form OF original
float letterDist;   //space from word node to letter
float wordDist;     //space from sentence node to word node
float sentenceDist;  //space from base node to sentence node

// fonts
PFont pMainHash;
//PFont pTweets;

// to read in a file
BufferedReader r;
String line;
String item;
float locY;
float locX;
int counter = 0;
int time;

boolean hasFileChanged = true;
long lastTime = 0;

String theLetter;


TwitterHandler twitterHandler;
StringList hashtags = new StringList();

/**
*  Just processing things, builds stuff before app can be displayed.
*/
void setup() {
  size(displayWidth, displayHeight);
  noStroke();
  smooth();

  // set fonts
  pMainHash = createFont("Montserrat", 65);
  //pTweets = createFont("Raleway", 16);

  // particle
  particle myParticle;

  //starting word
  myParticle=new particle();
  myParticle.setInitialCondition(width/2 + 60, height/2, 0, 0);
  particles.add(myParticle);
  word = myParticle;
  addSpring(wordDist, 0.2, sentence, word);
  letter = word;

  // Read in a file that contains hashtags to query for
  readInFile();
  
  twitterHandler = new TwitterHandler(hashtags);
  twitterHandler.queryTwitter();
  
  println("this happened");
}

/**
*  Clearly this wants to draw, no seriously draw the UI please.
*/
void draw() {
  background(0);
  smooth();
  textAlign(CENTER, CENTER);

  // Draw the main hashtag
  item = twitterHandler.getCurrentHashTag();
  textFont(pMainHash);
  hashTag theHashTag = new hashTag(item, (displayWidth/4)-415, (displayHeight/4)-300, 600, 200);
  theHashTag.drawTheHashTag();
  textFont(pMainHash,19);
  text("Tweet with " + item + " and see it here!", displayWidth/4-122, displayHeight/4-150);
  textFont(pMainHash,15);

   if(millis() - lastTime > 30000){
      println("20 seconds have gone by");
      lastTime = millis();
      twitterHandler.queryTwitter();
      
      for (int i = particles.size()-1; i >= 0; i--){
        particles.remove(i);
        springs.remove(i);
        println(particles.size());
        background(0);
      }
      
      for(int i = 0; i < 7; i++){
        particle myParticle;
        scaleVal = scaleVal;
        float angle = atan2(letter.pos.y-word.pos.y, letter.pos.x);
        myParticle = new particle();
        fill(random(120, 255), random(120, 255), random(120, 255));
        myParticle.setInitialCondition(word.pos.x+cos(angle)*letterDist + i*10, word.pos.y+sin(angle)*letterDist, 0, 0);
        addSpring(letterDist, 0.62, word, myParticle);
        myParticle.thisIsTheTweet = twitterHandler.getTweet(i);
        particles.add(myParticle);
      } 
  }

   // to draw the scale of the arms properly
   for (int i = 0 ; i < twitterHandler.getTweeteesSize(); i++) {
    float tempScaleVal = 25.75;
    float normScale = map(tempScaleVal, 0, 17, .45, 2);
    scaleVal = normScale;
    }

   letterDist = 70*scaleVal;  //centre node to tweet particle distance
   wordDist = 130*scaleVal;   //spacing between tweet arms

  // don't ever touch this it makes things move
  for (int i = 0; i < particles.size(); i++) {
    particles.get(i).resetForce();
  }
  for (int i = 0; i < particles.size(); i++) {
    particles.get(i).addRepulsionForce(random( (float) displayWidth), random( (float) displayHeight), 200, 0.7f);
    for (int j = 0; j < i; j++) {
      particles.get(i).addRepulsionForce(particles.get(j), wordDist, 0.3);
    }
  }
  for (int i = 0; i < springs.size(); i++) {
    springs.get(i).update();
  }
  for (int i = 0; i < particles.size(); i++) {
    particles.get(i).addDampingForce();
    particles.get(i).update();
  }


  
  if (hasFileChanged == true) {;
    hasFileChanged = false;
    particles=new ArrayList<particle>();
    springs=new ArrayList<spring>();

      for (int i = 0; i < 7; i++){
        particle myParticle;
        scaleVal = scaleVal;
        float angle = atan2(letter.pos.y-word.pos.y, letter.pos.x);
        myParticle = new particle();
        fill(random(120, 255), random(120, 255), random(120, 255));
        myParticle.setInitialCondition(word.pos.x+cos(angle)*letterDist + i*10, word.pos.y+sin(angle)*letterDist, 0, 0);
        addSpring(letterDist, 0.62, word, myParticle);

        // Check if we have a tweet to show
        if(twitterHandler.hasTweets()) { 
          myParticle.thisIsTheTweet = twitterHandler.getTweet(i);
        } else {
          myParticle.thisIsTheTweet = "Well this is awkward\n" + twitterHandler.getCurrentHashTag() 
                                      + " is on vacation, come back soon!";
        }
        particles.add(myParticle);
     }

    }

  // draw particles
 for (int i = 0; i < 7; i++) {   
    if(particles.size() > i) particles.get(i).draw();
  }
  // draw lines
   stroke(255, 100);
  for (int i = 0; i < springs.size(); i++) {
    springs.get(i).draw();
  }

  text("Coded with love by Ursula & Nichie", displayWidth/4-130, displayHeight/4+700);

}

/**
*  Util to read the file of hashtags
*/
public void readInFile()
{
  r = createReader("hashtags.txt");
  try {
    String line;
    while ( (line = r.readLine ()) != null) {
      String[] words = split(line, "\n");
      hashtags.append(words);
    }
  } 
  catch (IOException e)
  {
    e.printStackTrace();
    line = null;
  }
}

/**
*  kk spring?
*/ 
void addSpring(float dist, float springiness, particle a, particle b) {
  spring mySpring = new spring();
  mySpring.distance = dist;
  mySpring.springiness  = springiness;
  mySpring.particleA = a;
  mySpring.particleB = b;
  springs.add(mySpring);
}
