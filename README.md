# Load Flow Analysis of a Multi-Bus Power System Network

![Project Status](https://img.shields.io/badge/Status-Completed-success)
![Subject](https://img.shields.io/badge/Subject-Power_System_Analysis-blue)
![Tools](https://img.shields.io/badge/Tools-PowerWorld%20%7C%20MATLAB-orange)

## 📖 Project Overview
This project performs a steady-state **Load Flow Analysis** on a 9-bus power system. The study determines bus voltages, phase angles, and power flows to assess system performance under specified load and generation conditions. 

The analysis was conducted using the **Newton-Raphson method**, implemented mathematically in **MATLAB** and validated using **PowerWorld Simulator** software. This project was submitted as part of the *Power System Analysis Sessional (EEE-3520)* course.

## 🎯 Objectives
* **Determine** voltage magnitudes and phase angles at all buses.
* **Calculate** active and reactive power flows across transmission lines.
* **Identify** potential system weaknesses, such as voltage violations or excessive power losses.
* **Compare** results between the numerical MATLAB algorithm and PowerWorld simulation.

## ⚙️ System Specifications
The power system modeled in this project consists of **9 Buses** interconnected by 10 transmission lines. The specific parameters (Resistance, Reactance, Generation, and Load) were derived using a unique algorithm based on Student ID **ET231056**.

* **Bus Types:**
    * **1 Slack Bus:** Bus 1 (Voltage fixed at 1.0 p.u., 0°).
    * **2 PV (Generator) Buses:** Bus 2 & 3.
    * **6 PQ (Load) Buses:** Bus 4 through 9.
* **Base Values:** 100 MVA, 25 kV.

## 🛠️ Requirements & Tools Used
To replicate or view this project, you will need the following software:

1.  **PowerWorld Simulator** (Primary Tool)
    * Used for modeling the single-line diagram and running the load flow simulation.
2.  **MATLAB** (Verification Tool)
    * Used to manually implement the Newton-Raphson algorithm and verify the Jacobian matrix calculations.

## 📊 Methodology
The project follows these steps:
1.  **Data Calculation:** Deriving line impedance and bus data from the unique ID constraints.
2.  **Y-Bus Matrix Formation:** Constructing the admittance matrix based on line data.
3.  **Newton-Raphson Algorithm:** Iteratively solving non-linear power flow equations until convergence (tolerance < 1e-6 p.u.).
4.  **Simulation:** Modeling the network in PowerWorld to visualize power flow and validate MATLAB results.

## 📈 Key Results
The analysis yielded the following findings regarding the system's steady-state operation:

* **Total Generation:** 701.03 MW / 184.26 MVAr.
* **Total Load:** 690.00 MW / 96.00 MVAr.
* **System Losses:**
    * Active Power Loss: **11.03 MW** (~1.6%).
    * Reactive Power Loss: **88.26 MVAr**.
* **Voltage Profile:**
All buses remained within the standard ±5% limit. The lowest voltage was observed at **Bus 8 (0.977 p.u.)**, indicating a potential need for reactive compensation in that area.

## 📸 Screenshots

<img width="1060" height="670" alt="Screenshot 2026-02-04 020425" src="https://github.com/user-attachments/assets/eab39478-f3a0-454b-963d-7fb5805332af" />
<img width="883" height="802" alt="Screenshot 2026-02-04 020510" src="https://github.com/user-attachments/assets/b5ba406c-2760-46bc-8be3-5f58832fe445" />

## 📝 Author
**Md Jahirul Islam**

---
*This repository serves as a record of Complex Engineering Activity (CEA) focusing on power system planning and operation.*
