setwd("C:/Users/kenshin/Desktop/TBO_105_textmining")

library(RMeCab)
library(dplyr)

#�`�ԑf��͂����Č��ʂ������o��
Freq <- RMeCabFreq("results/tbo.txt") %>% 
  dplyr::arrange(desc(Freq)) %>% 
  write.csv("results/tbo_kei.csv")

#�K�v�ȒP��̂ݒ��o����
Freq2 <- read.csv("results/tbo_kei.csv", header = T) %>%
  dplyr::filter(Freq >= 200, Info1 %in% c("����","�`�e��"), Info2 != "��") %>%
  dplyr::arrange(desc(Freq)) %>% 
  dplyr::select(Term, Freq) %>% 
  write.csv("results/tbo_kei2.csv")

#�_�O���t��`��
library(ggplot2)
library(cowplot)

#�ēx�ǂݍ���
Freq2 <- read.csv("results/tbo_kei2.csv", header = T)

Freq2_bar <- ggplot(Freq2)+
  geom_bar(aes(x=reorder(Term,Freq),y=Freq),
           stat = "identity",
           fill = "skyblue",
           colour = "white")+
  coord_flip()+
  theme_cowplot()+
  scale_y_continuous(breaks=seq(0,1300,by=200),limits=c(0,1300))+
  xlab("�P��")+
  ylab("�p�x")
Freq2_bar
ggsave("results/Freq2_bar.png", Freq2_bar)