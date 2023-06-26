AirPassengers
class(AirPassengers)
start(AirPassengers)
end(AirPassengers)
summary(AirPassengers)
plot(AirPassengers,col="palegreen4",
     main="Passengers vs time")
abline(lm(AirPassengers~time(AirPassengers)))
plot(decompose(AirPassengers))
boxplot(AirPassengers~cycle(AirPassengers))
plot(AirPassengers)
plot(log(AirPassengers)) #make variance equal
abline(lm(log(AirPassengers)~time(log(AirPassengers))))

plot(diff(log(AirPassengers)))
abline(lm(diff(log(AirPassengers))~time(diff(log(AirPassengers)))))

#AR I MA
#p  d  q

acf(AirPassengers)
acf(diff(AirPassengers))

#q = 1
pacf(AirPassengers)
#p = 0
#d = 1 , no. of times we differentiate to get mean constant

arima(log(AirPassengers) , c(0,1,1) , 
      seasonal = list(order=c(0,1,0), period=12)) -> mod_time
predict(mod_time,10*12) -> pred_time
print(pred_time)

2.718^(pred_time$pred) -> pred_time
print(pred_time)

ts.plot(AirPassengers,pred_time,log="y",lty=c(1,3),
        col="palegreen4",main="forecastedvalues")


       