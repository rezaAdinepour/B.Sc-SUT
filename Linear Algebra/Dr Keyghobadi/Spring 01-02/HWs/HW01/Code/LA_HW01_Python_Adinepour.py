#           ******************************************************
#          **   course         : Linear Algebra                  **
#         ***   HomeWork       : 01                              ***
#        ****   Topic          : Calculate Determinant           ****
#        ****   AUTHOR         : Reza Adinepour                  ****
#         ***   Student ID:    : 9814303                         ***
#          **   Github         : github.com/reza_adinepour/      **
#           ******************************************************

import numpy as np
import os

clear = lambda: os.system('cls')
clear()

A = np.array([ [1, 2, 3, -1],
               [0, 1, 2, 7],
               [2, 4, -3, 2],
               [3, 0, 15, 3] ])

print('matrix A is:\n {}' .format(A))
print('\ndet(A) = {}' .format(np.linalg.det(A)))