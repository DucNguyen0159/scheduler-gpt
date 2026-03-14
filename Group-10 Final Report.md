**Group-10 Final Report**

**Members**

* Henry Nguyen:   
  [https://chatgpt.com/share/69a8e47e-0f00-8012-ba84-9241c7cf7140](https://chatgpt.com/share/69a8e47e-0f00-8012-ba84-9241c7cf7140)  
* Minh Thien Pham:  
  [https://chatgpt.com/share/69b33f37-71a8-800e-a926-168f1025ae0e](https://chatgpt.com/share/69b33f37-71a8-800e-a926-168f1025ae0e)

**Project Overview**

ChatGPT's implementation to simulate the scheduling of multiple processes under three algorithms: FIFO (First In, First Out), Pre-emptive SJF (Shortest Job First), and Round Robin in Rust, and calculate their turnaround time, response time, and wait time.

GitHub Link:

 [https://github.com/DucNguyen0159/scheduler-gpt](https://github.com/DucNguyen0159/scheduler-gpt)

The final program follows the assignment format and passes the provided test cases.

**Development Process and Iteration**

We first used ChatGPT to clarify the assignment because some parts were confusing. The assignment said Rust, but some lines still mentioned Python file names. After that, we used ChatGPT to generate the first version of the scheduler.

The code was refined through multiple prompts. We focused on output formatting, edge cases, tie-breaking in SJF, required error messages, and command-line behavior. The first versions were close, but not exact. Therefore, we had to fix some errors, such as spacing, line order, finish events at runfor, Round Robin formatting, and required error cases.

Later, we tested the code more carefully and compared it to the assignment. We also used more prompts to check invalid input cases and command-line behavior. One important improvement was tightening the CLI handling while still keeping the optional \--color bonus flag.

We stopped prompting when all three algorithms worked, the output matched the provided .out files, and the remaining fixes were faster to verify by hand.

The final code is the result of combining the conversations of team members; one conversation is for code generation and basic validation, and the other conversation is for detailed validation and refinement with valid and invalid test cases.

**How We Chose the Final Code**

The final code is mostly AI-generated, but it was reviewed and refined by hand.

**AI-generated or AI-assisted:**

* Core scheduling logic  
* Process data structures  
* Parsing structure  
* Summary metric generation  
* Most output formatting  
* Most of the colored output feature

**Human work:**

* Final formatting checks  
* Command-line behavior refinement  
* Manual testing with the provided files  
* Manual testing of missing-parameter cases  
* Checking assignment-specific output and error messages

We chose the final version because it matched the expected outputs and only needed small manual fixes.

**Evaluation of AI-Generated Code**

**Correctness**

The final code performs the required task correctly. It implements FCFS, preemptive SJF, and Round Robin. It also matches the expected output for the provided test files.

The main issues we found were:

* Output formatting differences  
* Handling a process that finished exactly at runfor  
* Round Robin display formatting  
* Command-line behavior

We fixed these issues through more prompts and small manual refinements.

We also learned that AI feedback still needed verification. At one point, AI incorrectly claimed that the usage string was wrong. We checked the Rust source and ran the program ourselves, and we confirmed that the usage string was already correct. This showed that manual review was still necessary.

The final version passed all 9 provided scheduling tests:

* c2-fcfs, c2-sjf, c2-rr  
* c5-fcfs, c5-sjf, c5-rr  
* c10-fcfs, c10-sjf, c10-rr

We also manually tested assignment-specific error cases, such as:

* Missing processcount  
* Missing runfor  
* Missing use  
* Missing name  
* Missing arrival  
* Missing burst  
* Missing RR quantum  
* Invalid command-line usage

Overall, the final code was correct after iterative prompting, testing, and manual review.

**Efficiency**

The code is efficient, at least it's efficient enough for this assignment. FCFS and Round Robin use VecDeque, which is well-suited for queue operations. SJF uses a Vec, so selecting the next process is O(n) each time. In the worst case, it takes O(runfor × n, which is acceptable for the small test sizes of this project.

It also builds an arrival map first, which avoids scanning the full process list every tick. A priority queue could improve SJF for larger inputs, but it was not necessary for now. The current approach is simple, readable, and fast enough for this assignment scale.

**Readability**

The code is highly readable and well-organized: 

* Parsing, simulation, and summary logic are separated   
* Each algorithm has its own function   
* Helper functions have clear names  
* Variable names are meaningful   
* The overall flow is easy to follow

There is some repeated code between the algorithms, but this is acceptable due to the project size (tiny), and it keeps the logic easy to read.

**Completeness**

The code is complete for the required assignment behavior and the cases we tested.

It handles:

* Idle CPU time  
* Unfinished processes  
* Simultaneous arrivals  
* Processes finishing at the last tick  
* Empty ready queues

It also handles the main required error cases:

* Missing input file shows Usage: scheduler-get.py \<input file\>  
* Missing parameters show Error: Missing parameter \<parameter\>.  
* Missing RR quantum shows Error: Missing quantum parameter when use is 'rr'

The final code also improved command-line behavior. It keeps \--color as the only allowed optional bonus flag and rejects other invalid extra arguments.

For same-time scheduling situations, the code uses a clear event order:

1. Arrivals  
2. Finishes  
3. Selection  
4. Idle check  
5. Execution

This order keeps the output consistent.

**Learning Assistance**

AI was helpful because our team members had limited to no Rust experience at the start. It helped with Rust syntax, choosing data structures, and explaining parts of the generated code.

At the same time, this project showed that AI is not enough by itself. We still had to understand the code, test it, and verify it. It is possible to use AI to build code in a language you do not know well, but there are limits somewhere. You can copy code without fully understanding it, but debugging becomes harder, and AI can still be wrong. Human checking is still required.

**Overall Quality and Final Recommendation**

Overall Quality Rating: 9/10

Our final code is strong for this assignment. It works, matches the expected output, and handles the main required cases.

Strengths:

* Correct scheduling behavior  
* Correct test results  
* Readable code and structure  
* Solid handling of required error messages  
* Useful bonus feature without changing grading output

Things that could still be improved:

* Reduce repeated code between algorithms  
* Add a few more comments in the complex logic  
* Add unit tests for helper functions  
* Add more test cases for algorithms

The process was easier than expected in some ways because AI helped us get working code quickly. It was harder in other ways because we still had to verify everything ourselves.

If we did this again, we would start with more specific prompts, test after each major change, ask for explanations sooner, and keep better notes on prompt history.

Our final recommendation is that AI is very useful for generating base code and speeding up development, but the best results come from combining AI help with careful human testing and source-code review.

**Bonus Features**

Colored Terminal Output

The program includes an optional colored terminal output feature using ANSI escape codes.

This feature:

* Makes terminal output easier to read  
* Keeps the .out files plain for grading  
* Only turns on with \--color

Color mapping:

* Blue: arrivals  
* Green: selections  
* Red: finishes  
* Yellow: idle  
* Cyan: headers and summary

This feature was developed with AI help and then manually tested and refined.

**Conclusion**

This project showed that AI can help a lot with building code in a language that is still new to the team. It helped generate the main structure and logic quickly.

At the same time, this project also showed that AI is not always correct. We had to inspect the code, test it, and fix issues ourselves. The final result came from both AI support and manual review.

Test Results

All provided scheduling tests passed:

* c2-fcfs, c2-sjf, c2-rr  
* c5-fcfs, c5-sjf, c5-rr  
* c10-fcfs, c10-sjf, c10-rr