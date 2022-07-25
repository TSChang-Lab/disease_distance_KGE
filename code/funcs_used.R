# This script includes all functions used in Disease Similarity project
# Listed below
# 1. RVadjMaye: calculate RV adjustment coefficient
# 2. makeSymm: make symmetric matrix
# 3. get_upper_tri: get upper triangle of matrix
# 4. range01: scale variable to [0,1]
# 5. '%!in%': not in
# 6. group_cor2: get Spearman correlation and associate p-value with try-error 

#=================================================
group_cor2 <- function(DF,x,y) {
  check = try(cor.test(DF[,x], DF[,y], use = "na.or.complete", method = "spearman")[["p.value"]], silent = TRUE)
  if(class(check) == "try-error") {
    print("try-error")
    return(cor = NA)
  } else {
    cor = cor.test(DF[,x], DF[,y], use = "na.or.complete", method = "spearman")[["p.value"]]
    return(cor)
  }
}

#=================================================
'%!in%' <- function(x,y)!('%in%'(x,y))

#=================================================
range01 <- function(x){(x - min(x, na.rm = T))/(max(x, na.rm = T) - min(x, na.rm = T))}

#=================================================
get_upper_tri <- function(CorMat){
  CorMat[upper.tri(CorMat)]<- NA
  return(CorMat)
}

#=================================================
makeSymm <- function(m) {
  m[upper.tri(m)] <- t(m)[upper.tri(m)]
  return(m)
}

#=================================================
RVadjMaye <- function(X1, X2, center = TRUE){
  X1 <- as.matrix(X1)
  X2 <- as.matrix(X2)
  if(center){
    X1 <- X1 - rep(colMeans(X1), each = nrow(X1))
    X2 <- X2 - rep(colMeans(X2), each = nrow(X1))
  }
  n <- dim(X1)[1]
  p <- dim(X1)[2]
  q <- dim(X2)[2]
  pq   <- p*q; pp <- p*p; qq <- q*q
  AA   <- tcrossprod(X1)
  BB   <- tcrossprod(X2)
  sx1  <- std(X1); sx2 <- std(X2)
  msxy <- c(min(sx1), max(sx1), min(sx2), max(sx2))
  
  if( any(msxy > 1+10^-12) || any(msxy < 1-10^-12)){       # Not standardized X/Y
    X1s <- X1/rep(sx1, each=p); X2s <- X2/rep(sx2, each=q) # Standardize
    AAs <- tcrossprod(X1s)
    BBs <- tcrossprod(X2s)
    
    # Find scaling between R2 and R2adj
    xy <- Trace(AAs %*% BBs) / (pq-(n-1) / (n-2)*(pq-Trace(AAs %*% BBs) / (n-1)^2))
    xx <- Trace(AAs %*% AAs) / (pp-(n-1) / (n-2)*(pp-Trace(AAs %*% AAs) / (n-1)^2))
    yy <- Trace(BBs %*% BBs) / (qq-(n-1) / (n-2)*(qq-Trace(BBs %*% BBs) / (n-1)^2))
    
    # Apply scaling to non-standarized data
    RVadj <- (Trace(AA %*% BB) / xy) / (Trace(AA %*% AA) / xx*Trace(BB %*% BB) / yy)^0.5
  } else {
    RVadj <- (pq-(n-1)/(n-2)*(pq-Trace(AA %*% BB)/(n-1)^2)) /
      sqrt((pp-(n-1)/(n-2)*(pp-Trace(AA %*% AA) / (n-1)^2)) *
             (qq-(n-1)/(n-2)*(qq-trace(BB %*% BB) / (n-1)^2)))
  }
  RVadj
}