# Homework 9 
## Problem 1

```
library(qqman)
library(patchwork)
library(nycflights13)
library(ggplot2)
library(dplyr)
library(gridExtra)
library(grid)

setwd("/Users/Julio/Desktop/Class/HW9")

# Linear Regression Model
P1 <- flights %>%
  filter(!is.na(distance) & !is.na(arr_delay)) %>%
  ggplot(aes(x = distance, y = arr_delay)) +
  geom_point(alpha = 0.5, color = "blue") +
  geom_smooth(method = "lm", color = "red") +
  labs(title = "Arrival Delay vs. Distance", x = "Distance (miles)", y = "Arrival Delay (minutes)")

print(P1)

# Bar Graph
P2 <- ggplot(temp_flights, aes(x = reorder(carrier, -m_arr_delay), y = m_arr_delay))
+ geom_bar(stat = "identity", fill = "steelblue") 
+ labs(title = "Mean Arrival Delay by Carrier", x = "Carrier", y = "Mean Arrival Delay (minutes)") 
+ theme_minimal()

print(P2)

# Boxplot
P3 <- flights %>%
  filter(!is.na(arr_delay)) %>%
  ggplot(aes(x = carrier, y = arr_delay)) + 
  geom_boxplot(outlier.color = "red", outlier.shape = 16) +
  labs(title = "Arrival Delay Distribution by Carrier", x = "Carrier", y = "Arrival Delay (minutes)") +
  theme_minimal()

print(P3)

# Histogram

P4 <- flights %>%
  filter(!is.na(arr_delay)) %>%
  ggplot(aes(x = arr_delay)) +
  geom_histogram(bins = 50, fill = "skyblue", color = "black") +
  labs(title = "Distribution of Arrival Delays", x = "Arrival Delay (minutes)", y = "Count") +
  theme_minimal()

# Arrangin Plots
grid.arrange(P1, P2, P3, P4, ncol = 2)

lay <- rbind(
  c(1,1,1,2),
  c(1,1,1,3),
  c(1,1,1,4)
)

tiff("figure1.tiff", width = 7, height = 6, units = "in", res = 600)

grid.arrange(P1, P2, P3, P4, layout_matrix = lay)
```

# Problem 2

I used data from Week 7 to do this section. I just loaded the directoryu for HW7 in R studion.

I was having issues using grid.arrange to plot the plots made in week 7. So I ended up using the individuals plots saved from week 7.

```
 plot1 <- ggplot2::ggplot() + annotation_custom(rasterGrob(png::readPNG("C:/Users/julio/OneDrive/Desktop/class/PCA.png")))
 plot2 <- ggplot2::ggplot() + annotation_custom(rasterGrob(png::readPNG("C:/Users/julio/OneDrive/Desktop/class/Varplot.png")))
 plot2 <- ggplot2::ggplot() + annotation_custom(rasterGrob(png::readPNG("C:/Users/julio/OneDrive/Desktop/class/Volcano.png")))
 plot3 <- ggplot2::ggplot() + annotation_custom(rasterGrob(png::readPNG("C:/Users/julio/OneDrive/Desktop/class/Volcano.png")))
 plot4 <- ggplot2::ggplot() + annotation_custom(rasterGrob(png::readPNG("C:/Users/julio/OneDrive/Desktop/class/heatmap.png")))
 title <- ggdraw() + draw_label("RNAseq Heatmap and Volcano plot", fontface='bold')
 row1<- plot_grid(plot1, plot2)
 row2<-plot_grid(plot3,plot4)
 figure<-plot_grid(title, row1, row2, ncol=1, rel_heights=c(0.1,1,1))
 print(figure)

```

