package Servlet;

/**
 * Per line sentiment
 * 
 * 
 */
public class TweetWithSentiment {

    private String line;
    private String cssClass;
    private int avgRating;

    public int getAvgRating() {
		return avgRating;
	}

	public void setAvgRating(int avgRating) {
		this.avgRating = avgRating;
	}

	public TweetWithSentiment() {
    }

    public TweetWithSentiment(String line, String cssClass) {
        super();
        this.line = line;
        this.cssClass = cssClass;
    }

    public String getLine() {
        return line;
    }

    public String getCssClass() {
        return cssClass;
    }

    @Override
    public String toString() {
        return cssClass;
    }
    
    

}
