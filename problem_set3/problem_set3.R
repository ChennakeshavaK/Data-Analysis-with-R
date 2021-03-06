# Diamonds

library(ggplot2)
data(diamonds)

summary(diamonds)

?diamonds

# Price Histogram

ggplot(data = diamonds, aes(x = price)) +
  geom_histogram() +
  scale_x_continuous(breaks=seq(0,20000,1000))

# Price Histogram Summary

summary(diamonds$price)

# Diamond Counts

sum(diamonds$price < 500)
sum(diamonds$price < 250)
sum(diamonds$price >= 15000)

# Cheaper Diamonds

ggplot(data = diamonds, aes(x = price)) +
  geom_histogram() +
  scale_x_continuous(limits=c(500, 1500), breaks=seq(500,1500,250))

# Price by Cut Histograms
ggplot(data = diamonds, aes(x = price)) +
  geom_histogram() +
  facet_wrap(~cut)

# Price by Cut
by(diamonds$price, diamonds$cut, max)
by(diamonds$price, diamonds$cut, min)
by(diamonds$price, diamonds$cut, median)

# Scales and Multiple Histograms
ggplot(data = diamonds, aes(x = price)) +
  geom_histogram() +
  facet_wrap(~cut, scales = "free_y")

# Price per Carat by Cut
ggplot(data = diamonds, aes(x = price/carat)) +
  geom_histogram(binwidth = 0.01) +
  scale_x_log10() +
  facet_wrap(~cut, scales = "free_y")

# Price Box Plots
ggplot(data = diamonds, aes(x = cut, y = price)) + 
  geom_boxplot() +
  coord_cartesian(ylim=c(0, 7500))

ggplot(data = diamonds, aes(x = color, y = price)) + 
  geom_boxplot() +
  coord_cartesian(ylim=c(0, 8000))

ggplot(data = diamonds, aes(x = clarity, y = price)) + 
  geom_boxplot() +
  coord_cartesian(ylim=c(0, 7000))

# Interquartile Range - IQR
by(diamonds$price, diamonds$color, summary)
IQR(subset(diamonds, color == 'D')$price)
IQR(subset(diamonds, color == 'J')$price)

# Price per Carat Box Plots by Color
ggplot(data = diamonds, aes(x = color, y = price/carat)) + 
  geom_boxplot() +
  coord_cartesian(ylim=c(1000, 6000))

# Carat Frequency Polygon
ggplot(data = diamonds, aes(x = carat)) +
  geom_freqpoly(binwidth=0.01) + 
  scale_x_continuous(breaks=seq(0,5,0.1))

# Gapminder Data
setwd("/Users/jasondamiani/Udacity/Data Analysis with R/problem_set3/")

electricity <- read.csv("Electricity Generation.xls.csv", as.is = TRUE, stringsAsFactors = FALSE)
names(electricity)[1] <- "country"
electricity <- data.frame(electricity[1], lapply(electricity[,2:20], function(x) as.numeric(gsub(",", "", x))))

n <- electricity$country

electricity_t = as.data.frame(t(electricity))
colnames(electricity_t) <- n
electricity_t <- electricity_t[-1, ]
rownames <- lapply(row.names(electricity_t), function(x) gsub("X", "", x))
electricity_t <- data.frame(lapply(electricity_t[,1:64], function(x) as.numeric(as.character(x))))
row.names(electricity_t) <- rownames

ggplot(data = electricity_t, aes(x = Ukraine)) +
  geom_histogram()
