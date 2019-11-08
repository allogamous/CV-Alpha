# function to create CV groups based on alfa-latice principles
# ten-fold with two replicates
tenfoldCV <- function(gid, seed = 29121983){
  require(agricolae)
  gid <- as.character(gid)
  replicates <- 2
  folds <- 10
  rest <- length(gid) - trunc(length(gid)/folds)*folds
  lb <- length(gid) - rest
  
  if (rest == 0) {
   book <- design.alpha(trt = gid, r = replicates, s = length(gid) / folds, k = folds, seed = seed)$book
  book <- data.frame(replicate = book[,5], fold = book[,2], gid = book[,4]) 
  rownames(book) <- NULL
  return(book)
  }
  
  if (rest > 0) {
    book <- design.alpha(trt = gid[1:lb], r = replicates, s = lb / folds, k = folds, seed = seed)$book
    book <- data.frame(replicate = book[,5], fold = book[,2], gid = book[,4]) 
     book2 <- data.frame(replicate = rep(1:replicates, each = rest), fold = c(sample(1:folds, rest), sample(1:folds, rest)), gid = c(gid[(lb+1):length(gid)]
, gid[(lb+1):length(gid)]))
    
     book3 <- rbind(book, book2)
     
    rownames(book3) <- NULL
    
    return(book3)
  }
    
}


system.time(example <- tenfoldCV(gid = as.character(1:906)))
head(example, 12)
head(example[example$replicate == 2,], 10)
tail(example, 10)

#################

# function to create CV groups based on alfa-latice principles
# five-fold with four replicates


fivefoldCV <- function(gid, seed = 29121983){
  require(agricolae)
  gid = as.character(gid)
  replicates <- 4
  folds <- 5
  lb <- length(gid)
  s <- lb / folds 
  odds <- seq(from = 1, to = s, by = 2)
  dvby3 <- (s / 3) - trunc(s / 3) 


  while (!s %in% odds | dvby3 == 0) {
    lb <- (lb - 1)
    s <- lb / folds # must be odd and not divisible by three
    dvby3 <- (s / 3) - trunc(s / 3) # Thus, it must be != 0
    }
  
  
 rest <- length(gid) - lb
  
  if (rest == 0) {
    book <- design.alpha(trt = gid, r = replicates, s = s, k = folds, seed = seed)$book
    book <- data.frame(replicate = book[,5], fold = book[,2], gid = book[,4]) 
    rownames(book) <- NULL
    return(book)
  }
  
  if (rest > 0) {
    book <- design.alpha(trt = gid[1:lb], r = replicates, s = s, k = folds, seed = seed)$book
    book <- data.frame(replicate = book[,5], fold = book[,2], gid = book[,4]) 
    book2 <- data.frame(replicate = rep(1:replicates, each = rest), fold = c(sample(1:folds, rest, replace = TRUE), sample(1:folds, rest, replace = TRUE), sample(1:folds, rest, replace = TRUE), sample(1:folds, rest, replace = TRUE)), gid = c(gid[(lb + 1):length(gid)], gid[(lb + 1):length(gid)], gid[(lb + 1):length(gid)], gid[(lb + 1):length(gid)]))
    
    book3 <- rbind(book, book2)
    
    rownames(book3) <- NULL
    
    non.ortho <- rest/length(gid)*100
    
    cat(rest, "individual were not assigned in the main scheme, that represent", non.ortho, "%") 
    
    output <- list(CV = book3, size = length(gid), rest = rest, non.ortho = non.ortho)
    
    return(output)
    
    
  }
  
}
