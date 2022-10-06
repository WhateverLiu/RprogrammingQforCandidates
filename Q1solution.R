

dat = data.table::data.table(
  xind = as.integer( ( locationLoss$longitude - (-180) ) / (5 / 120) ),
  yind = as.integer( ( locationLoss$latitude -  (-90 ) ) / (5 / 120) ),
  loss = locationLoss$loss)


sd(dat[, .(loss = mean(loss)), by = .(xind, yind)]$loss)

