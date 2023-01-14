# Twitter Text Mining
## Extracting frequent words from twitter and creating a wordcloud using clustering - KMeans technique

The project involves the need to perform Text Mining on a trending hashtag (I have worked with #covid). Tweets mined have to be transformed to text by changing letters to lowercase, removing punctuation/numbers and removing stop words. The frequently used words in the tweets are visualised by using a word cloud.
The tweets are clustered using k-means algorithm into 5 main clusters. This technique is useful to further analyse the data collected for various other purposes like finding potential classification, sentiment analysis, etc.

### Implementation

#### Authentication
Twitter uses Open Authentication (OAuth) to grant access to the information. To setup the authentication, setup_twitter_oauth() function is to be used which takes consumer_key, consumer_secret, access_token and access_secret as the parameters. These parameters are generally provided by Twitter after we gain developer access. 

#### Data Retrieval:

* Querying Twitter

To access the Twitter data, we need to query our requirement to Twitter. In this project I have retrieved data based on #covid. In this project, function searchTwitter() retrieves the tweets based on #covid. tweetCovid = searchTwitter(“#covid”, n=5000, lang= “en”)
For further analysis these tweets are converted to a data frame and are stored locally.

#### Processing and Analysing the Data:

* Cleaning the Data

Tweets retrieved have a lot of unwanted text and characters which would have to be removed in order to obtain meaningful results. This is done by removing punctuations, numbers, special, characters, extra whitespaces and non-ASCII characters. The “tm” package provides us with function tm_map() which helps in removing unwanted characters. But to use tm_map() we need to convert our data object into a Corpus. A Corpus is a collection of text document on which text mining and natural language processing routines can be applied.

* The Document Term Matrix

After cleaning the data, the data is converted to a Document Term Matrix. A Document Term Matrix consists of rows and columns in which rows correspond to the documents and columns corresponds to the terms. The Document Term Matrix enables us to perform numerical calculations on the data.

#### Visualising data using plots

The frequent terms with frequency of at least 50 are found and plotted as a word cloud. K-means clustering is performed on the data and is clustered into 5 groups. These clusters are visualised using function clusplot().

### WordCloud

![WordCloud](https://user-images.githubusercontent.com/65553135/212463100-bf2bbaab-6c3d-468d-99cf-ab19c3149ab7.png)

### Clusterplot

![image](https://user-images.githubusercontent.com/65553135/212463321-b3284cf9-3029-4c55-8da0-1bf612d11a1b.png)

### Bargraph - Frequent words

![image](https://user-images.githubusercontent.com/65553135/212463299-f281ad07-f621-4a86-b5e9-50ff144c69cb.png)


