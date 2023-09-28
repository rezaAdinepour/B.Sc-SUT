import numpy as np


a = np.array( [ [3], [4-2j], [1] ] )

print('a is: {}' .format(a))
print('shape of a: {}' .format(a.shape))

aAbs = np.abs(a)
N1 = np.linalg.norm(a, 1)
N2 = np.linalg.norm(a, 2)
Ni = np.linalg.norm(a, np.inf)


print('absolute(a): {}' .format(aAbs))
print('norm-1: {}' .format(N1))
print('norm-2: {}' .format(N2))
print('norm-inf: {}' .format(Ni))


aa = np.array([ [2, 2, -1],
                [2, 6, 0],
                [-1, 0, 1] ])

c = np.diag(aa) * 0
print(c)

