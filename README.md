# Load Flow Analysis of a Multi-Bus Power System Network

![Project Status](https://img.shields.io/badge/Status-Completed-success)
![Subject](https://img.shields.io/badge/Subject-Power_System_Analysis-blue)
![Tools](https://img.shields.io/badge/Tools-PowerWorld%20%7C%20MATLAB-orange)

## 📖 Project Overview
This project performs a steady-state **Load Flow Analysis** on a 9-bus power system. [cite_start]The study determines bus voltages, phase angles, and power flows to assess system performance under specified load and generation conditions[cite: 13, 14]. 

[cite_start]The analysis was conducted using the **Newton-Raphson method**, implemented mathematically in **MATLAB** and validated using **PowerWorld Simulator** software[cite: 18, 22]. [cite_start]This project was submitted as part of the *Power System Analysis Sessional (EEE-3520)* course[cite: 4].

## 🎯 Objectives
* [cite_start]**Determine** voltage magnitudes and phase angles at all buses[cite: 20].
* [cite_start]**Calculate** active and reactive power flows across transmission lines[cite: 14].
* [cite_start]**Identify** potential system weaknesses, such as voltage violations or excessive power losses[cite: 16].
* [cite_start]**Compare** results between the numerical MATLAB algorithm and PowerWorld simulation[cite: 18].

## ⚙️ System Specifications
[cite_start]The power system modeled in this project consists of **9 Buses** interconnected by 10 transmission lines[cite: 23]. [cite_start]The specific parameters (Resistance, Reactance, Generation, and Load) were derived using a unique algorithm based on Student ID **ET231056**[cite: 19, 25].

* **Bus Types:**
    * [cite_start]**1 Slack Bus:** Bus 1 (Voltage fixed at 1.0 p.u., 0°)[cite: 23, 42].
    * [cite_start]**2 PV (Generator) Buses:** Bus 2 & 3[cite: 23].
    * [cite_start]**6 PQ (Load) Buses:** Bus 4 through 9[cite: 23].
* [cite_start]**Base Values:** 100 MVA, 25 kV[cite: 34].

## 🛠️ Requirements & Tools Used
To replicate or view this project, you will need the following software:

1.  **PowerWorld Simulator** (Primary Tool)
    * [cite_start]Used for modeling the single-line diagram and running the load flow simulation[cite: 22, 90].
2.  **MATLAB** (Verification Tool)
    * [cite_start]Used to manually implement the Newton-Raphson algorithm and verify the Jacobian matrix calculations[cite: 38].

## 📊 Methodology
The project follows these steps:
1.  [cite_start]**Data Calculation:** Deriving line impedance and bus data from the unique ID constraints[cite: 25].
2.  [cite_start]**Y-Bus Matrix Formation:** Constructing the admittance matrix based on line data[cite: 45].
3.  [cite_start]**Newton-Raphson Algorithm:** Iteratively solving non-linear power flow equations until convergence (tolerance < 1e-6 p.u.)[cite: 47, 52].
4.  [cite_start]**Simulation:** Modeling the network in PowerWorld to visualize power flow and validate MATLAB results[cite: 78].

## 📈 Key Results
The analysis yielded the following findings regarding the system's steady-state operation:

* [cite_start]**Total Generation:** 701.03 MW / 184.26 MVAr[cite: 220].
* [cite_start]**Total Load:** 690.00 MW / 96.00 MVAr[cite: 221].
* **System Losses:**
    * [cite_start]Active Power Loss: **11.03 MW** (~1.6%)[cite: 224, 246].
    * [cite_start]Reactive Power Loss: **88.26 MVAr**[cite: 224].
* **Voltage Profile:** All buses remained within the standard ±5% limit. [cite_start]The lowest voltage was observed at **Bus 8 (0.977 p.u.)**, indicating a potential need for reactive compensation in that area[cite: 245, 257].

## 📸 Screenshots
<img width="1060" height="670" alt="image" src="https://github.com/user-attachments/assets/7d9848bd-1585-428b-a56c-00e1291a5efa" />
<img width="883" height="802" alt="image" src="https://github.com/user-attachments/assets/1f6faebf-5f8b-40e4-a56f-c14b51414f58" />

![PowerWorld Simulation Output](path/to/your/image_e2c378.png)
[cite_start]*Fig 1: Load Flow Analysis Output in PowerWorld Simulator [cite: 141]*

## 📝 Author
**Md Jahirul Islam**

---
[cite_start]*This repository serves as a record of Complex Engineering Activity (CEA) focusing on power system planning and operation[cite: 226].*
