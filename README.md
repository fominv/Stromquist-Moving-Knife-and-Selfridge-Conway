# Stromquist Moving Knife and Selfridge Conway

This repository contains Matlab files related to the ETH-Zürich course "Mathematics in Politics and Law". The corresponding paper can be found  [here](https://fomin.xyz/An_Algorithmic_Application_of_Cake-Cutting.pdf).

## How to use this repository?

The folder `src` contains all the source code. The files are structured as follows:

- All files prefixed with `ip_` deal with discretizing the problem as described in the paper. 
- All files prefixed with `sc_` correspond to the *Selfridge Conway* algorithm.
- All files prefixed with `mk_` correspond to the *Stromquist Moving Knife* algorithm.

 If you want to see a quick presentation of the code, just run the file `src/execute_me.m` using a current version of [Matlab](mathworks.com) or [Octave](https://www.gnu.org/software/octave/). The following two figures will be produced.

![](https://gitea.fomin.xyz/vfomin/Stromquist_Moving_Knife_and_Selfridge_Conway/raw/branch/master/assets/problem_instance.png)

This figure represents the solution of both algorithms. The graphs stand for the preference function of the three players, while the bottom two colored bars define the cuts of the cake to be distributed. 
As we can see the lower bar which corresponds to the *Selfridge Conway* algorithm exhibits disjoint cake pieces. In contrast, the upper bar provided by the *Stromquist Moving Knife* algorithm retains three whole separate pieces.

![](https://gitea.fomin.xyz/vfomin/Stromquist_Moving_Knife_and_Selfridge_Conway/raw/branch/master/assets/average_case.png)Here we can see that the average case of the preference functions is indeed the constant function over the cake interval [0,1].

For a more detailed explanation refer to the [paper](https://fomin.xyz/An_Algorithmic_Application_of_Cake-Cutting.pdf).
