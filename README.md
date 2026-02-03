# Load Flow Analysis of a Multi-Bus Power System Network

![Project Status](https://img.shields.io/badge/Status-Completed-success)
![Subject](https://img.shields.io/badge/Subject-Power_System_Analysis-blue)
![Language](https://img.shields.io/badge/Language-MATLAB-orange)
![Simulation](https://img.shields.io/badge/Simulation-PowerWorld-red)

## 📖 Project Overview
This project performs a steady-state **Load Flow Analysis** on a 9-bus power system. The study determines bus voltages, phase angles, and power flows to assess system performance under specified load and generation conditions. 

The analysis was conducted using the **Newton-Raphson method**, implemented mathematically in **MATLAB** and validated using **PowerWorld Simulator** software. This project was submitted as part of the *Power System Analysis Sessional (EEE-3520)* course.

## 📂 Project Structure
* `NewtonRaphson_LoadFlow.m`: The main MATLAB script that calculates the Y-Bus matrix, Jacobian matrix, and iteratively solves for bus voltages and angles.
* `Project_Report.pdf`: The detailed engineering report explaining the methodology and student ID-based parameter derivation.
* `Simulation_Design.pwb`: (Optional) The PowerWorld Simulator file.
* `images/`: Folder containing simulation screenshots and single-line diagrams.

## 🎯 Objectives
* **Determine** voltage magnitudes and phase angles at all buses.
* **Calculate** active and reactive power flows across transmission lines.
* **Identify** potential system weaknesses, such as voltage violations or excessive power losses.
* **Compare** results between the numerical MATLAB algorithm and PowerWorld simulation.

## ⚙️ System Specifications
The power system modeled in this project consists of **9 Buses** interconnected by 10 transmission lines. The specific parameters were derived using a unique algorithm based on Student ID **ET231056**.

* **Bus Types:**
    * **1 Slack Bus:** Bus 1 (Voltage fixed at 1.0 p.u., 0°).
    * **2 PV (Generator) Buses:** Bus 2 & 3.
    * **6 PQ (Load) Buses:** Bus 4 through 9.
* **Base Values:** 100 MVA, 25 kV.
* **Line Parameters:** R = 0.0032 p.u., X = 0.0256 p.u.

## 🚀 How to Run the Code
To verify the load flow results using the numerical method:

1.  Open **MATLAB**.
2.  Open the file `NewtonRaphson_LoadFlow.m`.
3.  Run the script.
4.  The Command Window will output:
    * **Final Bus Voltages & Angles** (Compare these with Table 1 in the report).
    * **Power Injections** (Generated vs. Consumed Power).
    * **Line Power Flows** (MW and MVAr flow between buses).

## 📈 Key Results
The analysis yielded the following findings regarding the system's steady-state operation:

* **Total Generation:** 701.03 MW / 184.26 MVAr.
* **Total Load:** 690.00 MW / 96.00 MVAr.
* **System Losses:**
    * Active Power Loss: **11.03 MW** (~1.6%).
    * Reactive Power Loss: **88.26 MVAr**.
* **Voltage Profile:** All buses remained within the standard ±5% limit. The lowest voltage was observed at **Bus 8 (0.977 p.u.)**.

## 📸 Screenshots

<img width="1060" height="670" alt="Screenshot 2026-02-04 020425" src="https://github.com/user-attachments/assets/eab39478-f3a0-454b-963d-7fb5805332af" />
<img width="883" height="802" alt="Screenshot 2026-02-04 020510" src="https://github.com/user-attachments/assets/b5ba406c-2760-46bc-8be3-5f58832fe445" />

## 📝 Author
**Md Jahirul Islam**

---
*This repository serves as a record of Complex Engineering Activity (CEA) focusing on power system planning and operation.*
