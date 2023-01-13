library(twitteR)

#AUthenticating
consumer_key = ""
consumer_secret = ""
access_token = ""
access_secret = ""

#Setting up twitter authentication
setup_twitter_oauth(consumer_key,consumer_secret,access_token,access_secret)

#Retriving twitter data with "#covid"
tweetCovid = searchTwitter("#covid", n=5000, lang ="en")
#Saving the data as .df file
tweetCovid.df = twListToDF(tweetCovid) 

write.csv(tweetCovid.df, file="CovidTweets.csv") 
