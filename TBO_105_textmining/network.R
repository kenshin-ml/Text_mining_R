setwd("C:/Users/kenshin/Desktop/TBO_105_textmining")

library(dplyr)
library(igraph)

#step.1 ネットワーク図のデータを準備する
tbo <- read.csv("result2/ngram_tango2.csv", header = T) %>% 
  dplyr::filter(Freq >=33) %>%
  dplyr::select(N1, N2, Freq)

#step.2 ネットワーク図のデータフレームを指定する
network <- graph.data.frame(tbo[1:2],directed=T)
E(network)$weight <- tbo[[3]]

#step.3 ネットワーク図を描く
png("result3/ngram_tango2.png", width = 1000, height = 1000)
plot(network,
     vertex.size=9,
     vertex.shape="circle",
     vertex.label=V(network)$name,
     vertex.color="white",
     vertex.label.color="black",
     vertex.label.font=2, 
     vertex.frame.color="gray",
     vertex.label.cex=1.1,
     edge.width=E(network)$weight,
     edge.color="gray",
     layout=layout.fruchterman.reingold)
dev.off()

#step4. 密度と中心性を計算する
#density
graph.density(network)

#degree centrality
sink("result3/degree.txt")
degree(network)
sink()

#closeness centrality
sink("result3/closeness.txt")
closeness(network)
sink()

#eigenvector centrality
sink("result3/evcent.txt")
evcent(network)$vector
sink()

#betweenness centrality
sink("result3/betweenness.txt")
betweenness(network)
sink()
