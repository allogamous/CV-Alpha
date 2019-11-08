# CV-Alpha
The CV-α is a cross-validation methodology and was meant to create scenarios with two, three, or four replicates, regardless of the number of treatments. 
Each replicate is split into folds, and the number of folds will determine the percentage of training and validation population. 
Each fold across replicates is based on the α(0,1) lattice design aiming to reduce the concurrences of any two treatments in the same 
fold (block) across replicates. 

## Authors: Rafael Massahiro Yassue; José Felipe Gonzaga Sabadin; Giovanni Galli; Filipe Couto Alves; Roberto Fritsche-Neto


## Example

```{r cars}
source("https://github.com/allogamous/CV-Alpha/blob/master/codes.R")
example2 <- fivefoldCV(gid = 1:906)
head(example2[[1]], 12)
example2$size
example2$rest
example2$non.ortho
```
