# BL-dynamic-stall-model

*Author: Luiz Pancini*

This repository contains the source code for the modified Beddoes-Leishman semi-empirical dynamic stall model presented in the [article](https://www.sciencedirect.com/science/article/pii/S0889974621001584) [^1].

## Usage

The main program is the `src/BL_model.m` file. It calculates the two-dimensional unsteady aerodynamic coefficients for an airfoil pitching sinusoidally about its quarter-chord, under specified flow and motion conditions (Mach number, reduced frequency, mean angle of attack and angle of attack range). The freestream Mach number is assumed to be smaller then 0.3. Test cases may be input as an experimental set from [NASA's database](https://apps.dtic.mil/sti/pdfs/ADA121598.pdf) [^2], or from the [University of Glasgow database](https://researchdata.gla.ac.uk/464/) [^3].

The scripts `NASA Data/generate_frame.m` and `Glasgow Data/generate_GUD.m` are included to create the `.mat` files containing the data sets for comparison.

If you find this model helpful in your work, please cite the original [article](https://www.sciencedirect.com/science/article/pii/S0889974621001584) [^1].

## References
[^1]: dos Santos, L. G. P., & Marques, F. D. (2021). 
Improvements on the Beddoes–Leishman dynamic stall model for low speed applications. 
Journal of Fluids and Structures, 106, 103375.

[^2]: McAlister, K. W., Pucci, S. L., McCroskey, W. J., & Carr, L. W. (1982). 
An Experimental Study of Dynamic Stall on Advanced Airfoil Sections. Volume 2. Pressure and Force Data. 
NATIONAL AERONUATICS AND SPACE ADMINISTRATION, MOFFETT FIELD, CA, AMES RESEARCH CENTER.

[^3]: Green, R. B. & Giuni, M. (2017).
Dynamic stall database R and D 1570-AM-01: Final Report.
