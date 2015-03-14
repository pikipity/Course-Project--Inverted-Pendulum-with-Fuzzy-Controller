# Course Simulation Project -- Inverted Pendulum with Fuzzy Controller

In this project, a inverted pendulum system controled by a simple fuzzy controller is simulated in the Matlab environment. The main refereence is the book "*Fuzzy Control*" [1]. The main purpose is to evaluate effects of different parameters. There are three types of files: supported functions, simulation functions and simulation results.

# Supported Functions

1. Model of the inverted pendulum system `InvertedPendulum.m`: Calculate the current enviroment values based on values of previous time step;
2. Fourth order Runge Kutta method `ODE_RK.m`: Solve the ODE by using the fourth order Runge Kutta method. It is used in the `InvertedPendulum.m`;
3. Fuzzy Controller `FuzzyController.m`: Based on the user's settings and measured values to calculate the force which will transferred to the inverted pendulum system. It is only contains two inputs and one outputs. One input is the angle error. Another input is the angle speed error. The output is the force.
4. `ConvertEps2Pdf.sh`: Convert simulation results from eps figures to pdf figures. Only for Mac OS System. How to use it: In terminal, run `chmod +x ./ConvertEps2Pdf.sh;./ConvertEps2Pdf.sh`

# Simulation Functions

1. `test_membershipfunction.m`: Plot the membership functions based on the user's settings. Example results are `e_membershipfunction.pdf`, `de_membershipfunction.pdf` and `F_membershipfunction.pdf` in `Test_Results` floder.;
2. `test_InvertedPendulum_without_controller.m`: Test the model of the inverted pendulum. No control is performed. Example results are `without_control_1.pdf` and `without_control_2.pdf` in `Test_Results` floder.;
3. `test_InvertedPendulum_with_fuzzy_controller.m`: Simulate the fuzzy control process of the inverted pendulum. Example results are `force_**.pdf` and `angleandposition_**.pdf` in `Test_Results` floder.
4. `Diff_Parameters_Diff_Results_triangle_min.m`: This file is to show the simulation results for effects of different parameters. Simulation results are in the `Simulation_Results_triangle_min` floder (Membership functions are triangular. And use minimum to represent the premise and implication and COG classification)
4. `Diff_Parameters_Diff_Results_Gaussian_product.m`: This file is to show the simulation results for effects of different parameters. Simulation results are in the `Simulation_Results_Gaussian_product` floder (Membership functions are Gaussian. And use product to represent the premise and implication and COG classification)
5. `Diff_Parameters_Diff_Results_49rules.m`: For the previous simulations, only 25 rules are used. This simulation is to show the effect of rule base. The number of rules is increased to 49.

# Simulation Results

1. There are some example results for testing simulation functions in the folder `Test_Results`. These example all follows the section "2.4 Simple Desgin Example: The Inverted Pendulum" of [1].
2. Simulation results of `Diff_Parameters_Diff_Results_triangle_min.m` are all in the folder `Simulation_Results_triangle_min`. These simulations also follows the section "2.4 Simple Desgin Example: The Inverted Pendulum" of [1].
3. Simulation results of `Diff_Parameters_Diff_Results_Gaussian_product.m` are all in the folder `Simulation_Results_Gaussian_product`. These simulations are for "2.10 Design Problem 2.1" of [1].
4. Simulation results of `Diff_Parameters_Diff_Results_49rules.m` are all in the folder `Simulation_Results_49rules`. These simulations are for "2.10 Design Problem 2.1" of [1].

## Reference

[1] K. M. Passion and S. Yurkovich, *Fuzzy Cntrol*. Menlo Park, CA: Addison-Wesley, 1998.
