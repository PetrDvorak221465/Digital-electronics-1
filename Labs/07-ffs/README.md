# *Digital-electronics-1.*

# *Labs DE1* 

# *07-ffs*

## Task 1. Preparation tasks 

### Characteristic equations and completed tables for D, JK, T flip-flops.
![CharEq](Images/CharEq.png)


   | **clk** | **d** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-- |
   | ![rising](Images/eq_uparrow.png) | 0 | 0 | 0 | Signal sampled by rising edge of *clk* |
   | ![rising](Images/eq_uparrow.png) | 0 | 1 | 0 | Signal sampled by rising edge of *clk*  |
   | ![rising](Images/eq_uparrow.png) | 1 | 0 | 1 | Signal sampled by rising edge of *clk*  |
   | ![rising](Images/eq_uparrow.png) | 1 | 1 | 1 | Signal sampled by rising edge of *clk*  |

   | **clk** | **j** | **k** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-: | :-- |
   | ![rising](Images/eq_uparrow.png) | 0 | 0 | 0 | 0 | No change |
   | ![rising](Images/eq_uparrow.png) | 0 | 0 | 1 | 1 | No change |
   | ![rising](Images/eq_uparrow.png) | 0 | 1 | 0 | 0 | Reset |
   | ![rising](Images/eq_uparrow.png) | 0 | 1 | 1 | 0 | Reset |
   | ![rising](Images/eq_uparrow.png) | 1 | 0 | 0 | 1 | Set |
   | ![rising](Images/eq_uparrow.png) | 1 | 0 | 1 | 1 | Set |
   | ![rising](Images/eq_uparrow.png) | 1 | 1 | 0 | 1 | Toggle |
   | ![rising](Images/eq_uparrow.png) | 1 | 1 | 1 | 0 | Toggle |

   | **clk** | **t** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-- |
   | ![rising](Images/eq_uparrow.png) | 0 | 0 | 0 | No change |
   | ![rising](Images/eq_uparrow.png) | 0 | 1 | 1 | No change |
   | ![rising](Images/eq_uparrow.png) | 1 | 0 | 1 | Invert (Toggle) |
   | ![rising](Images/eq_uparrow.png) | 1 | 1 | 0 | Invert (Toggle) |