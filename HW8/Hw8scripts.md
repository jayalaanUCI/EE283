### Used wget http://wfitch.bio.uci.edu/~tdlong/allhaps.malathion.200kb.txt.gz to dowload data on HPC3 and then download to local directory
### In R studio
library(tidyverse)
mal=read_tsv("/allhaps.malathion.200kb.txt.gz")
mal2=mal >%>filter(chr=="chrX" & pos==316075)

mal2

levels(as.factor(mal2$pool))
```
[1] "mcF" "mcM" "msF" "msM" 
```
levels(as.factor(mal$founder))
```
[1]  "A1"  "A2"  "A3"  "A4"  "A5"  "A6"  "A7"  "AB8"
```
mal2=mal2 %>% mutate(treat=str_sub(pool,2,2))

mal2= mal2 %>% mutate(treat=str_sub(pool,2,2))

anova(lm(asin(sqrt(freq)) ~ treat + founder +treat:founder, data=mal2))

```
Analysis of Variance Table

Response: asin(sqrt(freq))
              Df  Sum Sq  Mean Sq  F value    Pr(>F)    
treat          1 0.00062 0.000624   0.2761   0.60648    
founder        7 2.04258 0.291797 129.0335 7.195e-13 ***
treat:founder  7 0.03490 0.004985   2.2044   0.09027 .  
Residuals     16 0.03618 0.002261                       
---
Signif. codes:  
0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

```
### Problem 1
mal=mal %>% mutate(treat=str_sub(pool,2,2))

mal<- mal %>% mutate(treat =as.factor(treat), founder=as.factor(founder))

mymodel <- function(df){
+ anova(lm(asin(sqrt(freq)) ~ treat + founder + treat:founder, data= df))
+ }

extract_pval <- function(anova_table){
+ return(anova_table$`Pr(>F)`[3])

results <- mal %>%
  filter(!is.na(freq)) %>%
  group_by(chr, pos) %>%
  nest() %>%
  mutate(
    anova_table = map(data, mymodel),
    p_value = map_dbl(anova_table, extract_pval),
    neg_log10p = -log10(p_value)
  ) %>%
  select(chr, pos, neg_log10p)

 write.csv(results, "HW8_prob1.csv")

ggplot(data=results, aes(x=pos, y=neg_log10p, color = neg_log10p)) +
+     geom_point()+
+     facet_grid(~chr) +
+     xlab("Position") + ylab("Log(p-value)") +
+     labs(title = "Model 1") + 
+     theme(plot.title = element_text(hjust = 0.5, size = 20),
+           axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))

### Problem 2
mymodel2<- function(df){
+ anova(lm(asin(sqrt(freq)) ~ founder + treat %in% founder, data=df))
+}

results2 <- mal %>%
  filter(!is.na(freq)) %>%
  group_by(chr, pos) %>%
  nest() %>%
  mutate(
    anova_table = map(data, fit_model2),
    p_value = map_dbl(anova_table, extract_pval2),
    neg_log10p = -log10(p_value)
  ) %>%
  select(chr, pos, neg_log10p)
write.csv(results2, "HW8_prob2.csv")

 ggplot(data=results2, aes(x=pos, y=neg_log10p, color = neg_log10p)) +
+     geom_point()+
+     facet_grid(~chr) +
+     xlab("Position") + ylab("Log(p-value)") +
+     labs(title = "Model 1") + 
+     theme(plot.title = element_text(hjust = 0.5, size = 20),
+           axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))

### Problem 3

library(dplyr)
model1_results <- read.csv("HW8_prob1.csv", check.names=FALSE) %>%
select(-1) %>% rename_with(~ "neg_log10p_model1", .cols=neg_log10p)

model2_results <- read.csv("HW8_prob2.csv", check.names=FALSE) %>%
select(-1) %>% rename_with(~ "neg_log10p_model1", .cols=neg_log10p)

merge_results<- left_join(model1_results, model2_results, by= c("chr", "pos"))
write.csv(merged_results, "merged_model.csv", row.names=FALSE)
