
  # Example:
  # Rodenbrock in dim 10 with constraints
  # 0 <= x <= 0.5 [and sum(x) == 1}

library(adagio)

n <- 10; x0 <- rep(0, n)
lb <- rep(0, n); ub <- rep(0.5, n)

sol <- optim(par = x0, fn = fnRosenbrock, gr = NULL,
             method = c("L-BFGS-B"),
             lower = lb, upper = ub,
             control = list(maxit = 1000, factr = 1e-12))
## $par
## [1] 0.50000000 0.26306547 0.08003088 0.01657413 0.01038071 0.01021201
## [7] 0.01020842 0.01020418 0.01000218 0.00000000
## 
## $value
## [1] 7.594814

library(nloptr)
sol <- tnewton(x0 = x0, fnRosenbrock, gr = grRosenbrock,
               lower = lb, upper = ub,
               precond = TRUE, restart = TRUE, nl.info = FALSE,
               control = list(maxeval = 1000, xtol_rel =1e-12))
## $par
## [1] 0.5000000000 0.2630659827 0.0800311137 0.0165742343 0.0103806763
## [6] 0.0102120052 0.0102084109 0.0102042121 0.0100040851 0.0001000817
## 
## $value
## [1] 7.594813

library(optimx)
sol <- opm(par = x0, fn = fnRosenbrock, gr = grRosenbrock,
           method = "nvm", lower = lb, upper = ub)
## p1       p2         p3         p4         p5         p6         p7
## nvm 0.5 0.263066 0.08003111 0.01657423 0.01038068 0.01021201 0.01020841
##             p8         p9          p10    value fevals gevals hevals
## nvm 0.01020421 0.01000409 0.0001000817 7.594813     79     38      0
##     convergence  kkt1  kkt2 xtime
## nvm           0 FALSE FALSE 0.008

#----
library(BB)
n <- 10
fn1 <- adagio::fnRosenbrock
gr1 <- adagio::grRosenbrock

A1 <- rbind(diag(1, n), diag(-1, 10))
b1 <- c(rep(0.0, n), rep(-0.5, n))
mex <- 0
p1 <- rep(1/n, n)

sol <- spg(par = p1, fn = fn1, gr = gr1,
           project = "projectLinear",
           projectArgs = list(A = A1, b = b1, meq = 0))

