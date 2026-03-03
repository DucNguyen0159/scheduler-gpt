# Process Scheduler - COP4600 PA1

A Rust implementation of three process scheduling algorithms: **First-Come First-Served (FCFS)**, **Preemptive Shortest Job First (SJF)**, and **Round Robin (RR)**.

## Features

- ✅ **FCFS (First-Come First-Served)**: Processes are scheduled in the order they arrive
- ✅ **Preemptive SJF (Shortest Job First)**: Always runs the process with the shortest remaining time
- ✅ **Round Robin**: Time-sliced scheduling with configurable quantum
- ✅ Calculates turnaround time, wait time, and response time for each process
- ✅ Handles edge cases: idle CPU, unfinished processes, simultaneous arrivals

## Requirements

- **Rust** (rustc compiler)
  - Install from [rustup.rs](https://rustup.rs/)
  - Or via: `winget install Rustlang.Rustup`

## Building

```bash
rustc scheduler-gpt.rs
```

This will create `scheduler-gpt.exe` (Windows) or `scheduler-gpt` (Linux/Mac).

## Usage

```bash
./scheduler-gpt.exe <input_file.in>
```

The program will generate an output file with the same base name and `.out` extension.

### Example

```bash
./scheduler-gpt.exe c2-fcfs.in
# Generates: c2-fcfs.out
```

## Input File Format

```
processcount 3
runfor 20
use sjf
process name A arrival 0 burst 5
process name B arrival 1 burst 4
process name C arrival 4 burst 2
end
```

### Directives

- `processcount`: Number of processes
- `runfor`: Total simulation time
- `use`: Algorithm (`fcfs`, `sjf`, or `rr`)
- `quantum`: Time slice for Round Robin (required when `use` is `rr`)
- `process`: Process definition with `name`, `arrival`, and `burst` parameters
- `end`: End of file marker

Comments are supported using `#`.

## Output Format

The output includes:
- Number of processes
- Algorithm used
- Quantum value (for Round Robin)
- Time-tick events (arrivals, selections, finishes)
- Idle periods
- Final summary with metrics (wait time, turnaround time, response time)

## Testing

A PowerShell test script is included to verify correctness:

```powershell
.\test.ps1
```

This will:
- Run all `.in` test files
- Compare generated outputs with expected `.out` files
- Report pass/fail for each test case

```

## Test Files

The repository includes test cases:
- `c2-*.in/out`: 2-process tests
- `c5-*.in/out`: 5-process tests  
- `c10-*.in/out`: 10-process tests

Each test set includes FCFS, SJF, and Round Robin variants.

## Algorithm Details

### FCFS (First-Come First-Served)
- Non-preemptive
- Processes run to completion in arrival order
- Simple queue-based implementation

### Preemptive SJF (Shortest Job First)
- Preemptive: can interrupt running process
- Always selects process with shortest remaining time
- Tie-breaking: earlier arrival time, then input order

### Round Robin
- Time-sliced with configurable quantum
- Processes run for quantum time, then move to back of queue
- Fair scheduling for all processes

## Metrics

- **Turnaround Time**: `finish_time - arrival_time`
- **Wait Time**: `turnaround_time - burst_time`
- **Response Time**: `start_time - arrival_time`

## Error Handling

The program handles:
- Missing required parameters
- Invalid parameter values
- Missing input file
- Missing quantum for Round Robin
- Malformed input files

All errors follow the format: `Error: <description>`

## License

This project is part of UCF COP4600 coursework.

## Authors

Henry Nguyen
---

**Note**: This implementation was developed with AI assistance as part of a course assignment exploring AI-assisted programming.
