# Prob6- Code & Evaluation 

## A-session--(Estimator choosing)



$$ \widehat{N} = max  (x_1, x_2, ..., x_i)   $$     i is the No. of samples(for the below scenario, i=5)

What we want is the Maxima of all N samples, while what we can obtain is only limited numbers of samples, thus we can choose the maxima one amongst **given** samples as an estimator for the maxima of **all** sample.

*Hard to explain it mathematically, it's just intuition.*



## B-Session--(Sample K=5, simulation) 



#### Code(Python3-Jupyter) 

```python
import numpy as np

trails = 10000

def estFunc(n=5):  
    buffMax=0
    samples = np.random.random(size=n) * 300
    for element in samples:
        buffMax = max(buffMax, int(element))
         ## buffMax = buffMax *(n+1)/n -1 
         ## De-# the above line, gives the unbiased estimator
    return buffMax

buff = 0
for i in range(trails):
    buff = buff + estFunc()
Expectation = buff/trails
```
---
```python
Expectation
```

```python
249.2256
```



### Evaluation 

According to the law of big number, we could assert that **the Expectation(average) is 249.2256**, which is NOT equal to N(300). Hence, we assert that the estimator is **biased**.



## C-Session --(Probability Calculation)

+ $$ P(m \leq i)$$ is the probability of the event that **estimator is no greater than i(a given number)**;
+ Our estimator is **chosen** as $$max(x_1, x_2, ..., x_k) $$ 
  + $$ P(m \leq i) = $$ $$P$$ (for all sampled $$x_i, x_i \leq i$$) $$= P( x_1 \leq i)P(x_2 \leq i) ... P(x_k \leq i| x_)$$ 

Since 

+ samples are distributed **uniformly**;
+ samples are done without repetition

Assume the number of remaining samples is $$S$$, $$P( a \leq i |$$ $$S$$ total remains, R items remains smaller than i) $$= \frac R S $$ , each time an item is sampled and verfied to be no greater than $$i$$, the number of **valid** items that are smaller than i is **reduced by 1**.

Hence, $$ P(m \leq i) = \frac {i}{N} *  \frac {i-1}{N-1} * ...*  \frac {i-(k-1)}{N-(k-1)}$$ 


## D-Session--(Expectation Calculation)
$$P(\widehat N = m)$$, the probabily of the event that our estimator $$ \widehat N = m$$, (m is a certain value among{1,2,...,N=300}) can be written as:

$$P(\widehat N = m) = P(\widehat N \leq m) - P(\widehat N \leq m-1) $$ 

​                    $$ = \frac {C(m,k)} {C(N,k)} - \frac {C(m-1,k)} {C(N,k)} $$                      ------ C(a,b)=$$\frac {a!} {b!(a-b)!}$$ 

Based on above,

​                     $$ E(\widehat N) = \sum_{m}^N mP(\widehat N = m)=\sum_{m}^N m (\frac {C(m,k)} {C(N,k)} - \frac {C(m-1,k)} {C(N,k)}) $$ 

Here, we introduce a property of combination,

​                     $$ C(n,m) = C(n-1, m-1) + C(n-1, m)$$ 

Based on this, $$E(\widehat N) $$ can be rewritten as:

​                      $$ E(\widehat N) = \frac {1} {C(N, k)}\sum_{m}^N m (C(m-1, k-1)+C(m-1,k)- C(m-1,k)) $$ 

​			$$ =\frac {1} {C(N,k)} \sum_m^N mC(m-1, k-1)  = \frac {1} {C(N,k)} \sum_m^N    m \frac {(m-1)!} {(k-1)!(m-k)!}  = \frac {k} {C(N,k)} \sum_m^N \frac {m!} {k!(m-k)!}   $$ 

​                        $$= \frac {k} {C(N,k)} \sum_{m=k}^N {m \choose k}$$ 

With given property, i.e.,      $$\sum_{i=k}^N {i \choose k} = {N+1 \choose k+1} $$ , the above result is computed as 

​                	$$ E[\widehat N] = \frac {k} {N \choose k} {N+1 \choose k+1}=  k \frac {N+1} {k+1}= (1- \frac {1} {k+1})(N+1)$$



## E-Session--(Unbiased Estimator)

With the above analysis, the unbiased estimator can be presented as:

$$ \hat N_{unbiased} = \widehat N \frac {1} {1- \frac {1}{k+1}} -1 = \frac {k+1} {k} max(x_i) -1$$ ,  i is the number of samples

+ Re-simulation

Rerun the python script *with the "##" line 'de-##*', gives the below result:

```python
Expectation
```
```python
298.13960000000077
```
  Based on the above performance, we assert that the estimator is unbiased under tolerable error.