setwd("C:/Users/kenshin/Desktop/TBO_105_textmining")

library(dplyr)
library(RMeCab)

#step.1 文字のN-gramを作成する(type = 0 は文字, N = 2は2語)
curry <- Ngram("rawdata/tmdata.txt", type = 0, N = 2) %>%
  dplyr::arrange(desc(Freq)) %>% 
  write.csv("result2/ngram2.csv", row.names = F)

curry2 <- Ngram("rawdata/tmdata.txt", type = 0, N = 3) %>%
  dplyr::arrange(desc(Freq)) %>% 
  write.csv("result2/ngram3.csv", row.names = F)

curry3 <- Ngram("rawdata/tmdata.txt", type = 0, N = 4) %>%
  dplyr::arrange(desc(Freq)) %>% 
  write.csv("result2/ngram4.csv", row.names = F)

#step.2 単語のN-gramを作成する(type = 1 は単語, N = 2は2語)
curry4 <- Ngram("rawdata/tmdata.txt", type = 1, N = 2) %>%
  dplyr::arrange(desc(Freq)) %>% 
  write.csv("result2/ngram_tango.csv", row.names = F)

#step.3 品詞の情報を加えたN-gramを作成する
curry5 <- docDF("rawdata/tmdata.txt", 
                pos = c("名詞", "形容詞","動詞"), type = 1, N = 2, nDF = 1) %>%
  dplyr::rename(Freq = tmdata.txt) %>% 
  dplyr::arrange(desc(Freq)) %>% 
  write.csv("result2/ngram_tango2.csv", row.names = F)
