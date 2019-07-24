# Stacked Bar Plot with Colors and Legend
counts <- table(mtcars$vs, mtcars$gear)
barplot(counts, main="Car Distribution by Gears and VS",
        xlab="Number of Gears", col=c("darkblue","red"),
        legend = rownames(counts))

# Simple Scatterplot
attach(mtcars)
plot(wt, mpg, main="Scatterplot Example", 
     xlab="Car Weight ", ylab="Miles Per Gallon ", pch=19)

