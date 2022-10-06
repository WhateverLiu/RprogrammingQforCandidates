################################################################################
# Question II: Monte Carlo simulation of gross loss.
# 
#
#   A hurricane hit Boston and damaged 1000 houses. The ground-up loss to a 
#   house is characterized by a probability mass function (PMF). A PMF is 
#   represented by a 2-column data frame (loss, P) sorted by loss. P has
#   nonnegative elements that sum up to 1.
#
#
#   Every house is also labeled by a risk group ID. ALL LOSS RANDOM VARIABLES
#   IN THE SAME RISK GROUP ARE COMONOTONIC (PERFECTLY RANK-CORRELATED). ANY 
#   TWO LOSS RANDOM VARIABLES IN DIFFERENT GROUPS ARE INDEPENDENT.
# 
# 
#   The company that insured the portfolio of the 1000 houses will apply 
#   certain financial terms on the ground-up losses for gross loss estimation. 
#   In this portfolio, the insurance policy on a house has a (deductible, limit) 
#   term; the policy on a risk group's total loss also has a (deductible, limit) 
#   term. The way to apply (deductible, limit) is:
#
#
#       gross = min( limit, max( 0, loss - deductible ) )
# 
# 
#   For example, consider the following toy portfolio of 3 houses in 2 groups:
# 
# 
#       Risk group A = { house1, house2 }
#       Risk group B = { house3 }
# 
# 
#                        house1   house2   house3
#       Ground-up loss:  10       20       30
#       Deductible:       1        2        3
#       Limit:            6       17       28
# 
# 
#                        risk group A      risk group B
#       Deductible:      5                 7
#       Limit:           13                20
#
#  
#   The portfolio gross is computed as follows:
#
#
#       house1gross    = min( 6,  max( 0, 10 - 1 ) )
#       house2gross    = min( 17, max( 0, 20 - 2 ) )
#       house3gross    = min( 28, max( 0, 30 - 3 ) )
#       groupAgross    = min( 13, max( 0, house1gross + house2gross - 5) )
#       groupBgross    = min( 20, max( 0, house3gross - 7) )
#       portfolioGross = groupAgross + groupBgross
#
#
#   Given:
#
#       (i)   A list of 1000 PMFs that characterize the ground-up loss random
#             variables to the 1000 houses, 
#
#       (ii)  Risk group IDs of the houses, 
#
#       (iii) Financial terms on the houses, 
#
#       (iv)  Financial terms on the risk groups.
#
#   Generate 500 random samples of the portfolio gross via Monte Carlo 
#   simulation. Plot histogram of the distribution.
################################################################################


# ==============================================================================
# Data generation code. Please do not modify the code. Reading the code is 
# unnecessary for solving the problem. After execution, four R objects will 
# exist in the global environment:
#
# 1. `pmfs`:       a list of 1000 2-column data frames (loss, P). `pmfs[[i]]` is
#     the loss PMF for the i-th house.
#
# 2. `groupIDs`:   a character vector of size 1000. `groupIDs[i]` is the group 
#    ID for the i-th house.
#
# 3. `houseTerms`: a 2-column data frame (ded, lim). `houseTerms[i, ]` are the
#    deductible and limit on the i-th house.
#
# 4. `groupTerms`: a 3-column data frame (groupID, ded, lim). A look-up table
#    giving the deductible and limit on a group's total loss.
# ==============================================================================
if (TRUE) # Run the entire `if` block to generate the four inputs.
{
  
  
  set.seed(456)
  
  
  pmfs = lapply(1:1000, function(i)
  {
    supportSize = sample(100, 1)
    support = sort(runif(supportSize)) * 1e6
    P = runif(supportSize)
    data.frame(loss = support, P = P / sum(P))
  })
  
  
  groupIDs = sample(c(letters, LETTERS), 1000, replace = TRUE)
  
  
  houseTerms = data.frame(t(as.data.frame(lapply(pmfs, function(x)
  {
    sort(runif(2, x$loss[1], x$loss[nrow(x)]))
  }))))
  rownames(houseTerms) = NULL
  colnames(houseTerms) = c("ded", "lim")
  
  
  tmp = unlist(lapply(pmfs, function(x) sum(x$loss * x$P)))
  mu = mean(tmp) / length(unique(groupIDs))
  s = sd(tmp) / sqrt(length(unique(groupIDs)))
  groupTerms = matrix(pmax(0, rnorm(length(unique(groupIDs)) * 2L,
                                    mean = mu, sd = s)), nrow = 2)
  groupTerms = as.data.frame(t(apply(groupTerms, 2, function(x)
  {
    sort(x)
  })))
  rownames(groupTerms) = NULL
  colnames(groupTerms) = c("ded", "lim")
  groupTerms = data.frame(groupID = unique(groupIDs), groupTerms)
  
  
  rm(tmp, mu, s)
}




# ==============================================================================
# [Please enter your code below]
# ==============================================================================
# The problem can be solved with R-base functions only. Please use any package 
# in your preference. Feel free to google the APIs. Your code does not need to
# run smoothly or even be strictly R, but should have all the crucial components 
# in the right order for solving the problem.
str(pmfs)
str(groupIDs)
str(houseTerms)
str(groupTerms)














