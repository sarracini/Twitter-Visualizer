
/**
*  Description: Handle everything to do with twitter.
*
*  Creator:     Skyler Layne (@skylerto)
*  Version:     0.1
*/
class TwitterHandler {
  
  // Needed objects
  private Twitter twitter;

  // Class attributes
  private StringList hashtags;
  private ArrayList tweetees;
  private String currentHashTag;
  private ArrayList tweets;
  
  int hashSize = 0;
  
  public TwitterHandler(StringList hashtags){
    
    tweets = new ArrayList();
    
    this.currentHashTag = ""; 
    this.hashtags = hashtags;
    this.tweetees = new ArrayList();
    this.authenticate();
  }
  
  public int getTweeteesSize(){
   return this.tweetees.size(); 
  }
  
  public int getAmountOfHashtags(){
   return this.hashtags.size(); 
  }
  
  /**
  *
  */
  public String getTweet(int index){
    TweetWord tweetword = (TweetWord) tweetees.get(index);
    return tweetword.getText();
  }
  
  /**
  *  Determine if there is a tweet
  */
  public boolean hasTweets(){
   return tweetees.size() - 1 > 0;
  }
  
  public void queryTwitter()
  {
    currentHashTag = hashtags.get((int) random(0, this.getAmountOfHashtags()));
    
    Query query = new Query(currentHashTag);
    query.count(100);

    try {
      // search twitter for the hashtag at randomvar
      QueryResult result = twitter.search(query);
      
      // put ALL instances of found tweets in arraylist "tweets" & iterate 
      tweets = (ArrayList) result.getTweets();
      int numberOfTweets = tweets.size();
      println("Number of tweets available: " + (numberOfTweets));
      for (int i = 0; i < numberOfTweets; i++)
      {
        // create a username & status encapsulated in "twit" tweet object
        // add all "twits" to an arraylist of tweet objects called "tweetees"
        // haha
        Status status = (Status) tweets.get(i);
        User user = (User) status.getUser();
        String msg = status.getText();
        String name = user.getScreenName();
        TweetWord twit = new TweetWord(name, msg);
        tweetees.add(twit);
      }
    } 
    catch (TwitterException e) {
      println("Couldn't connect: " + e);
    }
  }
  
  public String getCurrentHashTag() {
   return this.currentHashTag; 
  }
  
  public ArrayList getTweetees() {
   return this.tweetees; 
  }
  
  /**
  *
  */
  private void authenticate(){
         
    ConfigurationBuilder cb = new ConfigurationBuilder();
    cb.setOAuthConsumerKey("LnOiYHKt7WQjVLN6sy6RJQ");
    cb.setOAuthConsumerSecret("tW23dNjZ7QAfPFF7Pz3aktKh7f8WTec2wtPkYZkHwNc");
    cb.setOAuthAccessToken("562619363-5asMhVErH1LtNExKudZKBx8aUHwpuuwbbke3I4Df");
    cb.setOAuthAccessTokenSecret("gj5wqb48o4D6cK5SlCbrfbqOVoAG2zj6N6fqKl5z9ge7c");
    
    this.twitter = new TwitterFactory(cb.build()).getInstance(); 
  }

}
