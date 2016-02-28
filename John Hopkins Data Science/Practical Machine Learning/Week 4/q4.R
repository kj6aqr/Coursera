library(lubridate)  # For year() function below
dat = read.csv("gaData.csv")
training = dat[year(dat$date) < 2012,]
testing = dat[(year(dat$date)) > 2011,]
tstrain = ts(training$visitsTumblr)

library(forecast)
testLength <- dim(testing)[1]

modFitBats<-bats(tstrain)
plot(modFitBats)
forecastBats <- forecast(modFitBats, level = 95, h = testLength)
plot(forecastBats);lines(testing$date,testing$visitsTumblr,col="red")

accBats <- accuracy(forecastBats, testing$visitsTumblr)

withinCt <- 0
for(i in 1:testLength) {
  if((testing$visitsTumblr[i] < forecastBats$upper[i]) & (testing$visitsTumblr[i] > forecastBats$lower[i])) {
    withinCt <- withinCt + 1
  }
}
print(withinCt/testLength)