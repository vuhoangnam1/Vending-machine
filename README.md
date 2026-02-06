# Vending Machine – FSM Design and UVM Verification

## Overview
This project implements a **Vending Machine Controller** based on a **Finite State Machine (FSM)** and verifies its functionality using the **UVM (Universal Verification Methodology)**.
The design models basic vending machine behavior such as coin insertion, product selection, and item dispensing.

This project is intended for **FSM design practice** and **learning UVM-based verification methodology**.

---

## Design Description
The vending machine is designed as an **FSM**, where each state represents a stage of operation, such as:
- Select id product
- Idle / Waiting for top up coin
- Accepting coins
- Checking coin
- Respone product
- Returning change 

State transitions depend on coin inputs, selection signals, and internal credit value.

---

## Verification Methodology
The verification environment is built using **UVM**, including:

- Interface to connect UVM components with the DUT
- Transaction to represent coin input and selection data
- Sequence to generate and control transactions
- Sequencer to manage transaction flow
- Driver to apply transactions to the DUT
- Monitor to observe DUT inputs and outputs
- Subscriber to collect functional coverage
- Scoreboard to check functional correctness
- Agent to integrate monitor && driver && sequencer
- Environment to integrate agent && scoreboard && subscriber
- UVM test to configure the environment and start sequences
- UVM testbench (top) to instantiate the DUT, generate clock/reset, and run the UVM test
- my_pkg to include all UVM class files and avoid compilation issues

---

## Test Scenarios
The following scenarios are verified using UVM:

- Reset and initial state verification
- Single coin insertion
- Multiple coin accumulation
- Product selection with sufficient credit
- Product selection with insufficient credit
- Correct product dispensing
- Correct state transitions of the FSM
- Functional coverage of all vending machine states

---

## Functional Coverage
Functional coverage is collected to ensure:

- All FSM states are exercised
- All coin input combinations are tested
- All valid product selections are covered
- Cross coverage between credit value and selection behavior

---

## Tools
- Language: SystemVerilog
- Verification: UVM
- Simulator: ModelSim & Quartus

---

## How to Run Simulation
1. Compile RTL and UVM files
2. Run makefile
3. Observe waveform and UVM report output

---

## Project Scope
- RTL implementation of vending machine FSM
- Functional verification using UVM
- Learning and practicing FSM-based design and UVM methodology
- Verification of state transitions, control logic, and timing behavior

---

## Author
Vu Hoang Nam  
Design verification
