## Testbench Strategy

Although the design space includes **64 sparsity maps**, I did not create one separate testbench for each map.

Instead, the verification environment uses **6 testbench scenarios** that collectively exercise all 64 sparsity-map configurations.

The reason for this structure is that many sparsity maps share the same verification flow and differ only in the sparsity pattern applied to the NPU. Creating 64 nearly identical testbench files would introduce unnecessary code duplication and make the verification environment harder to maintain.

Each testbench therefore covers a group of sparsity-map cases by reusing the same stimulus and checking procedure while changing the corresponding sparsity configuration.

```text
6 testbench scenarios
        ↓
multiple sparsity configurations per scenario
        ↓
64 sparsity maps covered in total
