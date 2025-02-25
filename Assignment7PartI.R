#set workig directory
getwd()

#Install rentrez package and load library
install.packages("rentrez")
library(rentrez)

#creates a vector of three objects (ID's for records ina database) called ncbi_ids
ncbi_ids<-c("HQ433692.1", "HQ433694.1","HG433691.1")
#looks through the database nuccore, finds genetic sequences that match the ID we input with the nci_ids vector, and returns those sequences in a fasta file
Bburg<-entrez_fetch(db="nuccore", id=ncbi_ids, rettype="fasta")

#create a new object called seqences that contains an object for every sequence
sequences<- strsplit(Bburg, split="\n\n", fixed=F)

#convert object to a dataframe
sequences<-unlist(sequences)

#seperate the sequences from the headers
#create an object of sequence headers
header<-gsub("(^>.*sequence)\\n[ATCG].*","\\1", sequences)

#remove arrow
header2<-gsub(">", "", header)

#create an object of just sequences
seq<-gsub("^>.*sequence\\n([ATCG].*)", "\\1", sequences)

#remove the newline character
seq2<-gsub("\n", "", seq)

#combine headers and sequences into a dataframe
sequences<-data.frame(name=header2, sequence=seq2)
head(sequences)

#output data frame to a csv file
write.csv(sequences, file="./Seqeunces.csv", row.names=F)
