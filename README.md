# Energy-Efficient Low-Precision NPU with Dynamic Scaling and Zero-Skipping

**FPGA NPU Architecture · Verilog RTL · PYNQ-Z2 · Low-Precision Computing · Design-Space Exploration**

*Presented at the 2026 ISE Summer Conference*  
*Oral Presentation · Live FPGA Demonstration · Live Demonstration Award*

---

## Overview

This project presents an energy-efficient low-precision Neural Processing Unit (NPU) for on-device AI inference.

The proposed architecture combines **Leading-One Detection (LOD)-based Dynamic Scaling** with **Switching-Aware Zero-Skipping** to improve the trade-off between inference fidelity, hardware resource usage, and dynamic power consumption.

The NPU was implemented in **Verilog RTL** and prototyped on a **PYNQ-Z2 FPGA at 100 MHz**.

A total of **45 NPU configurations** were evaluated by varying mantissa precision and zero-skipping schemes. Based on fidelity, hardware cost, and power consumption, **M3_no8** was selected as the final architecture.

The resulting NPU was also integrated into a live-camera CIFAR-10 inference pipeline and demonstrated at the **2026 ISE Summer Conference**.

---

## Key Contributions

- Designed and implemented a low-precision NPU architecture in **Verilog RTL**
- Introduced **LOD-based Dynamic Scaling** for adaptive low-bit computation
- Implemented **Switching-Aware Zero-Skipping** to reduce unnecessary switching activity
- Explored **45 hardware configurations** across precision and zero-skipping parameters
- Evaluated the architecture in terms of:
  - Inference fidelity
  - LUT / FF / BRAM utilization
  - Dynamic power consumption
- Prototyped and validated the NPU on a **PYNQ-Z2 FPGA**
- Integrated the accelerator into a **live-camera CIFAR-10 inference demonstration**
- Presented the research through a **conference paper, oral presentation, and live demonstration**

---

## Key Results

| Metric | Result |
|---|---|
| FPGA Platform | PYNQ-Z2 |
| FPGA Clock | 100 MHz |
| Design Space | 45 NPU configurations |
| Baseline | INT8 NPU |
| Proposed Precision | 3-bit mantissa Dynamic Scaling (M3) |
| M3 Fidelity | **92.0%** |
| Fixed-7 Fidelity | **74.0%** |
| LUT Reduction vs. Fixed-7 | **23.7%** |
| BRAM Reduction vs. Fixed-7 | **11.1%** |
| Dynamic Power Reduction vs. Fixed-7 | **12.9%** |
| M3_no8 Power Reduction vs. ungated M3 | **13.0%** |

The proposed M3 Dynamic Scaling architecture achieved higher inference fidelity while using fewer hardware resources and consuming less dynamic power than the Fixed-7 baseline.

---

## Proposed Architecture

### 1. LOD-Based Dynamic Scaling

Conventional fixed-scaling architectures statically truncate low-precision operands, which can cause significant information loss as the bit width decreases.

The proposed architecture detects the **leading-one position** of each operand and dynamically selects a significant bit window.

This allows the NPU to preserve important numerical information while operating with a reduced mantissa width.

> **Goal:** Maintain inference fidelity while reducing arithmetic precision and hardware cost.

---

### 2. Switching-Aware Zero-Skipping

Neural-network workloads contain a significant number of zero-valued operands.

The proposed NPU detects zero inputs and weights and suppresses unnecessary switching activity inside the processing elements.

Two levels of zero detection are used:

- External zero flags generated before entering the systolic array
- Cell-level zero detection inside each processing element

The resulting gating mechanism disables unnecessary arithmetic activity when the corresponding computation does not affect the output.

> **Goal:** Reduce dynamic power consumption without changing the functional result.

---

## Design-Space Exploration

Rather than evaluating a single architecture, this project explored **45 NPU configurations**.

The design space consists of:

- **5 mantissa configurations:** M1 – M5
- **9 zero-skipping configurations:** no1 – no9

The final architecture was selected using a three-stage filtering process:

1. **Fidelity constraint**
2. **Hardware-area constraint**
3. **Dynamic-power constraint**

This process identified **M3_no8** as the final architecture.

---

## FPGA Implementation

The proposed architecture was implemented in **Verilog RTL** and synthesized for the **PYNQ-Z2 FPGA**.

The NPU uses a weight-stationary systolic-array architecture for matrix multiplication.

CNN convolution operations are transformed into GEMM operations using `im2col`, and the resulting matrix multiplications are executed by the FPGA NPU.

### Experimental Workloads

The architecture was evaluated using multiple neural-network workloads, including:

- HeavyCNN
- LightVGG
- MLP
- SmallVGG for the live demonstration

---

## Live FPGA Demonstration

The proposed NPU was demonstrated as part of an end-to-end CIFAR-10 image-classification system.

### Demonstration Pipeline

```text
USB Camera
    |
    v
Image Capture
    |
    v
32x32 RGB Crop / Resize
    |
    v
Normalization
    |
    v
im2col
    |
    v
+---------------------------+
|       PYNQ-Z2 FPGA        |
|                           |
|   Low-Precision NPU       |
|   Systolic Array / GEMM   |
|   Dynamic Scaling         |
|   Zero-Skipping           |
+---------------------------+
    |
    v
CNN Classification
    |
    v
Predicted Class + Logits

```
The demonstration verified that the proposed architecture operates on an actual FPGA as part of a complete CNN inference pipeline rather than only in software simulation.

---

## Demo

A live demonstration was conducted using a **USB camera and PYNQ-Z2 FPGA** to verify the proposed NPU architecture on real hardware.

The demonstration performs the following sequence:

1. Capture an image from the USB camera
2. Crop and resize the image to 32×32 RGB
3. Normalize the input image
4. Convert convolution operations into GEMM using `im2col`
5. Execute matrix multiplication on the FPGA NPU
6. Complete the remaining CNN operations
7. Display the predicted CIFAR-10 class and output logits

### Live Demo Video

<!-- Replace the path below with your actual video or GIF -->

[▶ Watch the Live FPGA Demonstration](https://drive.google.com/file/d/1lzkIqhfIcX4UrQ2W33rvNfDzw1MxMoIF/view?usp=drive_link)

---

## Publication

**Bonseo Koo**, Youngjin Lee, Taewon Jung, and Sungju Ryu,  
*"Maximizing NPU Fidelity and Efficiency with LOD-Based Dynamic Scaling and Switching-Aware Zero-Skipping,"*  
**2026 ISE Summer Conference**

### Conference Activities

- Undergraduate Oral Presentation
- Live FPGA Demonstration
- **Live Demonstration Award**

<!-- Add a paper link only if redistribution is permitted. -->

[Take a look at the published paper](https://drive.google.com/file/d/1E2n2r2hTkK8z5EnhQzTTAbOcefPSNtiD/view?usp=drive_link)

---

## My Contributions

My primary contributions to this project included:

- Verilog RTL design and implementation of NPU modules
- Development of the low-precision NPU architecture
- Implementation and evaluation of LOD-based Dynamic Scaling
- Implementation and analysis of Switching-Aware Zero-Skipping
- FPGA synthesis and hardware evaluation
- Design-space exploration across multiple NPU configurations
- Neural-network model development and evaluation
- Live FPGA demonstration development
- Research paper preparation
- Oral conference presentation

---

## Repository Structure

```text
.
├── rtl/
|   ├── testbench/
│   ├── baseline/
│   ├── fixed_scaling engines/
|   |    ├── Fixed-7/
|   |    ├── Fixed-6/
|   |    ├── Fixed-5/
|   |    └── Fixed-4/
|   |
│   └── dynamic_scaling engines/
│        ├── M1/
|        |    ├── M1_no1/
|        |    ├── M1_no2/
|        |    ...
|        |    └── M1_no9/
│        ├── M2/
|        |    ├── M2_no1/
|        |    ├── M2_no2/
|        |    ...
|        |    └── M2_no9/
│        ...
|        └── M5/
|             ├── M5_no1/
|             ├── M5_no2/
|             ...
|             └── M5_no9/
│
├── pytorch software/
│
├── results/
│   ├── Overall data/
│   └── power/
│
├── docs/
│   ├── architecture/
│   └── live_demo/
│
└── README.md
```

---

## Tools & Technologies

### Hardware Design
- Verilog HDL
- AMD/Xilinx Vivado
- RTL Simulation
- FPGA Synthesis and Implementation

### Hardware Platform
- PYNQ-Z2 FPGA
- USB Camera

### Software
- Python
- PyTorch
- Jupyter Notebook

### Architecture & Optimization
- Neural Processing Unit (NPU)
- Systolic Array
- Low-Precision Computing
- LOD-Based Dynamic Scaling
- Switching-Aware Zero-Skipping
- CNN Quantization
- Design-Space Exploration

---

## Research Outcome

This project progressed through the following research and engineering workflow:

**Architecture Design**  
↓  
**RTL Implementation**  
↓  
**FPGA Prototyping**  
↓  
**Design-Space Exploration**  
↓  
**Fidelity / Area / Power Evaluation**  
↓  
**Conference Paper**  
↓  
**Oral Presentation**  
↓  
**Live FPGA Demonstration**  
↓  
**Live Demonstration Award**

The project provided experience spanning **NPU architecture design, RTL implementation, FPGA prototyping, quantitative hardware evaluation, and academic presentation**.

It also motivated subsequent work toward **real-time neural-network inference and hardware/software co-design on FPGA-based SoC platforms**.

---
## Testbench Strategy

The zero-skipping behavior of the NPU is primarily characterized by five activity metrics:

1. **Input switching rate**  
   Fraction of input transitions corresponding to `NZ → ZR` or `ZR → NZ`

2. **Input zero (ZR) rate**

3. **Input non-zero (NZ) rate**

4. **Weight zero (ZR) rate**

5. **Weight non-zero (NZ) rate**

Rather than creating a separate testbench for every sparsity-map configuration, the verification environment was designed around these five metrics.

The input stimulus was divided into three representative activity patterns:

- `NZ`: all input values are non-zero
- `SW`: alternating zero/non-zero input values, maximizing ZR↔NZ switching
- `ZR`: all input values are zero

The weight stimulus was divided into two patterns:

- `NZ`: all weights are non-zero
- `ZR`: all weights are zero

This results in six testbench scenarios:

| Testbench | Input SW Rate | Input ZR Rate | Input NZ Rate | Weight ZR Rate | Weight NZ Rate |
|---|---:|---:|---:|---:|---:|
| `tb_nznz` | 0% | 0% | 100% | 0% | 100% |
| `tb_nzzr` | 0% | 0% | 100% | 100% | 0% |
| `tb_swnz` | 100% | 50% | 50% | 0% | 100% |
| `tb_swzr` | 100% | 50% | 50% | 100% | 0% |
| `tb_zrnz` | 0% | 100% | 0% | 0% | 100% |
| `tb_zrzr` | 0% | 100% | 0% | 100% | 0% |

For example, `tb_swnz` uses an alternating zero/non-zero input sequence with non-zero weights.
Its five activity metrics are therefore:

`[100%, 50%, 50%, 0%, 100%]`

for:

`[Input SW, Input ZR, Input NZ, Weight ZR, Weight NZ]`.

These six scenarios were used to exercise the complete set of **64 sparsity-map configurations** without maintaining 64 nearly identical testbench files.

The testbench structure therefore emphasizes the activity characteristics that directly affect the zero-skipping logic rather than treating each sparsity map as an independent stimulus pattern.
## Future Work

The next stage of this project focuses on extending the current image-based inference system toward **real-time video inference**.

Planned improvements include:

- Migrating PS-side control from **Jupyter/Python to Vitis**
- Improving PS–PL communication using **AXI-based interfaces**
- Introducing **DMA-based high-throughput data transfer**
- Reducing PS–PL communication overhead
- Integrating the existing NPU with a real-time camera pipeline
- Targeting sustained inference throughput of **30 FPS or higher**

This extension aims to evolve the current FPGA NPU prototype into a more complete **real-time hardware/software co-designed inference system**.

---

## Author

**Bonseo Koo**

Research Interests:
- AI Accelerators
- Neural Processing Units
- Digital VLSI
- FPGA Architecture
- Hardware/Software Co-Design
- Energy-Efficient Computing

<!-- Optional links -->

[CV](https://github.com/kooseo1296-debug/Bonseo-Koo/blob/main/Bonseo_Koo_CV_Aug17_2026.pdf) · [Email](kooseo1296@gmail.com)
