setwd("C:/Users/kenshin/Desktop/TBO_105_textmining")

library(dplyr)
library(RMeCab)

#step.1 単語文書行列を作成する
tbo_cat <- docMatrix("rawdata/Category", pos = c("名詞","形容詞")) %>%
  write.csv("result1/tbo_CA.csv")

#step.2 MeCabの結果を加工する
tbo_cat2 <- read.csv("result1/tbo_CA.csv", skip = 40, header = F) %>% 
  dplyr::rename(Term=V1, business=V2,
                culture=V3,
                datademirutottori=V4,
                opinion=V5,
                press_release=V6,
                public=V7) %>%
  dplyr::mutate(total=(business + culture + datademirutottori + opinion + press_release + public)) %>% 
  dplyr::arrange(desc(total)) %>%
  write.csv("result1/tbo_CA2.csv")

library(ggplot2)
library(tidyr)

#step.3 縦長のデータに変換した後，グラフを描く
tbo_CA2_bar <- read.csv("result1/tbo_CA2.csv", header = T) %>% 
  dplyr::filter(total >=230) %>%
  dplyr::select(Term,	business, culture, datademirutottori, opinion, press_release, public) %>%
  tidyr::gather(Category, Freq, -Term) %>% 
  #write.csv("result1/tbo_CA3.csv", row.names = F)
  ggplot2::ggplot()+
  geom_bar(aes(x=Term, y=Freq), stat = "identity", fill="lightblue")+
  facet_grid(Category ~ .) +
  theme_bw() +
  xlab("単語")+
  ylab("頻度")+
  theme(axis.title.x = element_text(size=8),
        axis.title.y = element_text(size=8),
        axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0, size = 8),
        axis.text.y = element_text(size=8))
tbo_CA2_bar
ggsave("result1/tbo_CA2_bar.png", tbo_CA2_bar)
