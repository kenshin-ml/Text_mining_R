setwd("C:/Users/kenshin/Desktop/TBO_105_textmining")

library(dplyr)
library(RMeCab)

#step.1 ������N-gram���쐬����(type = 0 �͕���, N = 2��2��)
curry <- Ngram("rawdata/tmdata.txt", type = 0, N = 2) %>%
  dplyr::arrange(desc(Freq)) %>% 
  write.csv("result2/ngram2.csv", row.names = F)

curry2 <- Ngram("rawdata/tmdata.txt", type = 0, N = 3) %>%
  dplyr::arrange(desc(Freq)) %>% 
  write.csv("result2/ngram3.csv", row.names = F)

curry3 <- Ngram("rawdata/tmdata.txt", type = 0, N = 4) %>%
  dplyr::arrange(desc(Freq)) %>% 
  write.csv("result2/ngram4.csv", row.names = F)

#step.2 �P���N-gram���쐬����(type = 1 �͒P��, N = 2��2��)
curry4 <- Ngram("rawdata/tmdata.txt", type = 1, N = 2) %>%
  dplyr::arrange(desc(Freq)) %>% 
  write.csv("result2/ngram_tango.csv", row.names = F)

#step.3 �i���̏���������N-gram���쐬����
curry5 <- docDF("rawdata/tmdata.txt", 
                pos = c("����", "�`�e��","����"), type = 1, N = 2, nDF = 1) %>%
  dplyr::rename(Freq = tmdata.txt) %>% 
  dplyr::arrange(desc(Freq)) %>% 
  write.csv("result2/ngram_tango2.csv", row.names = F)