# Install pdftools
install.packages("pdftools")

# Install tm
install.packages("tm")

# Install lsa
install.packages("lsa")

# Install LSAfun
install.packages("LSAfun")

install.packages("igraph")

install.packages("wordcloud")

setwd("C:/Users/Sofea Taufik/Documents/Y3S1/CPC353/Assignment 1/YT2")

require(pdftools)
require(tm)
require(lsa)
require(LSAfun)

files <- list.files(pattern = "pdf$")
print(files)

docs <- sapply(files, pdf_text,USE.NAMES = TRUE)

lAcorp <- Corpus(VectorSource(docs))

#Cleaning the data
szCorpus <- tm_map(lAcorp, content_transformer(tolower))
szCorpus <- tm_map(szCorpus, removePunctuation)
szCorpus <- tm_map(szCorpus, removeNumbers)
szCorpus <- tm_map(szCorpus, removeWords, stopwords("english"))
szCorpus <- tm_map(szCorpus, stripWhitespace)

TDM <- TermDocumentMatrix(szCorpus)

lsaTdmSpace = lsa(TDM, dims = 20)

#Word count in each document
as.textmatrix(lsaTdmSpace)

#Relationship between words
lsaTdmSpace$tk[5:10,1:20]

#Relationship between document
lsaTdmSpace$dk[1:20,5:10]

#Graphical representation

tk <- lsaTdmSpace$tk
dk <- lsaTdmSpace$dk

plot(tk[,1], y=tk[,2], col="red",cex=.50, main="TK Plot")
text(tk[,1], y=tk[,2], labels=rownames(tk), cex=.70)