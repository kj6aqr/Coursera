library(quantmod)
from.dat <- as.Date("01/01/08",format="%m/%d/%y")
to.dat <- as.Date("12/31/13",format="%m/%d/%y")
getSymbols("GOOG", src="google", from=from.dat, to=to.dat)

mGoog <- to.monthly(GOOG)
googOpen <- Op(mGoog)
ts1 <- ts(googOpen, frequency=12)
plot(ts1,xlab="Years+1",ylab="GOOG")