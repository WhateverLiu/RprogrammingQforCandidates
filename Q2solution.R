

Nhouse = length(pmfs)
sampleSize = 500L


# Generate samples from pmfs.
houseLossSamples = lapply(pmfs, function(x)
{
  if (nrow(x) == 1) rep(x$loss, sampleSize)
  else sort(sample(x$loss, sampleSize, replace = TRUE, prob = x$P))
  # For in-group aggregation, samples need to be sorted due to comonotonicity.
})


# Gross loss for every house
houseGrossSamples = mapply(function(x, y)
{
  ded = y[1]; lim = y[2]
  pmin(lim, pmax(0, x - ded))
}, houseLossSamples, as.data.frame(t(houseTerms)), SIMPLIFY = FALSE)


# Gather house indices by group IDs.
houseIndicesGrouped = aggregate(list(index = 1:Nhouse),
                                list(groupID = groupIDs), 
                                function(x) x, simplify = FALSE)
str(houseIndicesGrouped)


# Add samples in every group.
groupLossSamples = lapply(houseIndicesGrouped$index, function(x)
{
  rowSums(as.data.frame(houseGrossSamples[x]))
})


# Align group IDs for fetching financial terms on groups.
groupTerms = groupTerms[
  match(houseIndicesGrouped$groupID, groupTerms$groupID), ]


# Apply financial terms on group losses.
groupGrossSamples = mapply(function(x, y)
{
  ded = y[1]; lim = y[2]
  sample(pmin(lim, pmax(0, x - ded))) 
  # Shuffle the samples because groups are independent.
}, groupLossSamples, as.data.frame(t(groupTerms[2:3])), SIMPLIFY = FALSE)


# Add group gross losses.
portfolioGrossSamples = rowSums(as.data.frame(groupGrossSamples))


hist(portfolioGrossSamples, xlab = "Loss", main = "Portfolio gross")



