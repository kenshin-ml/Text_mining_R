setwd("C:/Users/kenshin/Desktop/TBO_105_textmining")

library(RMeCab)
library(dplyr)

#形態素解析をして結果を書き出す
Freq <- RMeCabFreq("results/tbo.txt") %>% 
  dplyr::arrange(desc(Freq)) %>% 
  write.csv("results/tbo_kei.csv")

#必要な単語のみ抽出する
Freq2 <- read.csv("results/tbo_kei.csv", header = T) %>%
  dplyr::filter(Freq >= 200, Info1 %in% c("名詞","形容詞"), Info2 != "数") %>%
  dplyr::arrange(desc(Freq)) %>% 
  dplyr::select(Term, Freq) %>% 
  write.csv("results/tbo_kei2.csv")

#棒グラフを描く
library(ggplot2)
library(cowplot)

#再度読み込み
Freq2 <- read.csv("results/tbo_kei2.csv", header = T)

Freq2_bar <- ggplot(Freq2)+
  geom_bar(aes(x=reorder(Term,Freq),y=Freq),
           stat = "identity",
           fill = "skyblue",
           colour = "white")+
  coord_flip()+
  theme_cowplot()+
  scale_y_continuous(breaks=seq(0,1300,by=200),limits=c(0,1300))+
  xlab("単語")+
  ylab("頻度")
Freq2_bar
ggsave("results/Freq2_bar.png", Freq2_bar)
