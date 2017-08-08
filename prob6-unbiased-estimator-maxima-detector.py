
# coding: utf-8

# In[41]:

import numpy as np

trails = 10000

def estFunc(n=5):  
    buffMax=0
    samples = np.random.random(size=n) * 300
    for element in samples:
        buffMax = max(buffMax, int(element))
        unbias = buffMax *(n+1)/n -1
    return unbias


# In[42]:

buff = 0
for i in range(trails):
    buff = buff + estFunc()
Expectation = buff/trails


# In[43]:

Expectation


# In[ ]:



