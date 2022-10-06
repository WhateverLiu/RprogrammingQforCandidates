################################################################################
# Question I: Compute standard deviation of mean losses in 5km x 5km bins.
#
#
#   A hurricane hit Boston and damaged 10000 buildings. Geocoordinates and
#   losses of these buildings are given in a 3-column data frame: 
#   (longitude, latitude, loss).
#
#
#   The surface of the globe is divided into a grid of small bins starting from
#   (-180, -90) and ending at (180, 90) in geocoordinates. For simplicity, we
#   ignore curvature and assume a `d`km x `d`km bin is equivalent to a
#   (d / 120) x (d / 120) bin in geocoordinate terms. 
#
#   
#   To decide if two geocoordinates (x1, y1), (x2, y2) are in the same 
#   `d`km x `d`km bin, we compare the bin indices of the two locations:
#
#       x1ind = as.integer( ( x1 - (-180) ) / (d / 120) )
#       y1ind = as.integer( ( y1 - ( -90) ) / (d / 120) )
#
#       x2ind = as.integer( ( x2 - (-180) ) / (d / 120) )
#       y2ind = as.integer( ( y2 - ( -90) ) / (d / 120) )
#
#   If x1ind == x2ind AND y1ind == y2ind, the two locations are in the same bin.
#
#
#   Compute the mean loss of every 5km x 5km bin that contains at least one 
#   building. Report the standard deviation of these means.
################################################################################


# ==============================================================================
# Data generation. Please do not change the code.
# ==============================================================================
set.seed(123)
locationLoss = data.frame(longitude = runif( 10000, 71.0589 - 1, 71.0589 + 1),
                          latitude  = runif( 10000, 42.3601 - 1, 42.3601 + 1),
                          loss      = rgamma(10000, shape = 2, scale = 2) * 1e6)


# ==============================================================================
# [Please enter your code below]
# ==============================================================================
# The problem can be solved with R-base functions only. Please use any package 
# in your preference. Feel free to google the APIs. Your code does not need to
# run smoothly or even be strictly R, but should have all the crucial components 
# in the right order for solving the problem.













