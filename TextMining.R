library(tm)
library(SnowballC)
library(wordcloud)
library(cluster)
library(factoextra)
library(ggplot2)
#Building a corpus using the content in file in which tweets were retrived

tweetCovid.df$text = iconv(tweetCovid.df$text,"latin1","ASCII",sub="")
covidCorpus = Corpus(VectorSource(tweetCovid.df$text))

#Removing special characters
for(i in seq(covidCorpus))
{
  covidCorpus[[i]] = gsub('@\\S*',"",covidCorpus[[i]])
  covidCorpus[[i]] = gsub('#\\S*',"", covidCorpus[[i]])
  covidCorpus[[i]] = gsub('RT' , "", covidCorpus[[i]])
  covidCorpus[[i]] = gsub('http\\S+\\s*', "", covidCorpus[[i]])
  covidCorpus[[i]] = gsub('[[:cntrl:]]', "", covidCorpus[[i]])
  covidCorpus[[i]] = gsub('[[:punct:]]', "", covidCorpus[[i]])
}


#Removing Punctuation
covidCorpus = tm_map(covidCorpus,removePunctuation)

#Removing Numbers
covidCorpus = tm_map(covidCorpus,removeNumbers)

#Converting characters to lowercase
covidCorpus = tm_map(covidCorpus, content_transformer(tolower))

#Removing stopwords
stopwrd = c(stopwords("en"),"just","how")
covidCorpus = tm_map(covidCorpus, removeWords, stopwrd)

#Stripping Whitespaces
covidCorpus = tm_map(covidCorpus, stripWhitespace)

#Creating TermDoc)umentMatrix
dtm = DocumentTermMatrix(covidCorpus)
rownames(dtm) = c(1:nrow(dtm))
covidMat = as.matrix(dtm)
ord = sort(colSums(covidMat),decreasing = TRUE)

#Saving the matrix into a .csv file for later use
write.csv(covidMat, file="DocumentTermMatrix.csv") 

df = data.frame(term = names(ord),freq=ord)

d = df

term_frequency = findFreqTerms(dtm,lowfreq=50)

#Plotting the frequent terms 
ggplot(df,aes(x =term,y=freq)) + geom_bar(data=subset(df,df$freq>=150),stat="identity") + scale_colour_gradientn(colors=terrain.colors(10)) + xlab("Frequently used Words") + ylab("Frequency") + coord_flip()

#Creating wordcloud with the frequent terms
set.seed(1234)
wordcloud(words=df$term,freq = df$freq,min.freq=50,max.words=500,random.order=FALSE,rot.per=0.35,colors=brewer.pal(5,"Dark2"))


#Creating a sparse matrix
dtms = removeSparseTerms(tdm,1)

d = dist(t(dtms),method="euclidian")
kf = kmeans(d,centers = 5, nstart = 25)

#Cluster plot after k-means
clusplot(as.matrix(d),kf$cluster,color=T,shade=T,labels=2,lines=0,main="Clusters")

pam.res = pam(df,5)
fviz_cluster(pam.res)

