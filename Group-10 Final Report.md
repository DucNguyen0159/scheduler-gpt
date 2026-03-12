Members:  
Henry Nguyen (Duc Nguyen): [https://chatgpt.com/share/69a8e47e-0f00-8012-ba84-9241c7cf7140](https://chatgpt.com/share/69a8e47e-0f00-8012-ba84-9241c7cf7140)  
Minh Thien Pham:   
[https://chatgpt.com/share/69b33f37-71a8-800e-a926-168f1025ae0e](https://chatgpt.com/share/69b33f37-71a8-800e-a926-168f1025ae0e)

# Project Overview

Github Link: [https://github.com/DucNguyen0159/scheduler-gpt](https://github.com/DucNguyen0159/scheduler-gpt)

This project involved implementing three process scheduling algorithms in Rust using ChatGPT as a coding assistant:  
\- FCFS (First-Come First-Served)  
\- Preemptive SJF (Shortest Job First)  
\- Round Robin (RR)

The implementation successfully handles process simulation, calculates turnaround time, wait time, and response time for each process, and includes comprehensive error handling and edge case management.

# Development Process and Iteration

## Initial Approach

We began with prompts to ChatGPT requesting clarification of the project because the description is much longer than expected and also confusing due to information mismatch (Rust programming language, but only mentions .py files).

Then, we started requesting implementation of the three scheduling algorithms, focusing on:

* Understanding the input file format requirements  
* Implementing the core data structures (Process struct with arrival, burst, and remaining time)  
* Creating scheduler functions for each algorithm  
* Handling the specific output format requirements

## Iterative Refinement

Through multiple iterations, the following refinements were made:

**1\. Output Format Precision:**   
Initial implementations had minor formatting differences. Through specific prompts about exact output format (including spacing, capitalization, and line ordering), the output was refined to match the expected format exactly.

**2\. Edge Case Handling:**   
ChatGPT initially missed some edge cases, such as:

* Processes finishing exactly at \`run\_for\` time  
* Simultaneous process arrivals  
* Idle CPU periods  
* Unfinished processes

     
These were addressed through targeted prompts asking for specific edge case handling.

**3\. Tie-Breaking Logic:**   
For SJF, the tie-breaking logic (arrival time, then input order) required clarification through multiple prompts to ensure behavior.

**4\. Error Handling:**   
Error messages needed to match the exact format specified in the assignment ("Error: Missing parameter \<parameter\>"). This required explicit prompting about error message formatting.

## Decision to Stop Prompting

The decision to stop prompting and complete the project manually was made when:

* The core algorithms were functionally correct  
* Output formatting matched the expected results for all test cases  
* The remaining issues were minor formatting tweaks that were faster to fix manually  
* The bonus feature (ANSI colored output) was added successfully, with a minor issue related to the Windows permission

## Final Code Selection

The final code is primarily AI-generated with minor human modifications:  
\- AI-Generated: Core algorithm logic, data structures, input parsing, output generation, bonus colored output feature  
\- Human-Modified: Minor output formatting adjustments, colored output feature test on admin/user Powershell

# Evaluation of AI-Generated Code

## Correctness

The AI-generated code performs the intended tasks correctly. All three scheduling algorithms have been implemented and tested against the provided test cases. The implementation correctly:

* Parses input files with the specified format  
* Implements FCFS scheduling in arrival order  
* Implements Preemptive SJF with correct tie-breaking (shortest remaining time, then earlier arrival, then input order)  
* Implements Round Robin with proper quantum handling  
* Calculates turnaround time, wait time, and response time correctly  
* Handles edge cases, including idle periods, unfinished processes, and simultaneous arrivals

**Issues Found and Fixed:**

1\. Output Formatting: Initial output had minor spacing inconsistencies. Fixed through manual refinement for exact format matching.

2\. Finish Time Handling: Processes finishing exactly at \`run\_for\` needed special handling. This was addressed by adding explicit checks after the main simulation loop.

3\. Quantum Display: The Round Robin quantum display format required specific prompting to match the expected output format.

**Testing Results:**  
\- All test cases (c2, c5, c10 for each algorithm) pass successfully  
\- The test script (\`test.ps1\`) confirms all outputs match expected results  
\- No runtime errors or crashes observed

The code shows high correctness with only minor formatting adjustments needed.

## Efficiency

The AI-generated code demonstrates good efficiency:

**Strengths:**

* Uses appropriate data structures: \`VecDeque\` for FCFS and Round Robin queues (O(1) push/pop operations)  
* Uses \`Vec\` for ready queue in SJF, which is appropriate for the selection algorithm  
* Pre-builds arrival map (\`build\_arrival\_map\`) to avoid repeated searches during simulation O(n) preprocessing instead of O(n) per time tick  
* Time complexity: O(run\_for × n) for all algorithms, which is optimal for this simulation approach  
* Space complexity: O(n \+ run\_for), which is reasonable

**Potential Optimizations:**

* For SJF, a priority queue (heap) could theoretically improve selection from O(n) to O(log n), but given the small process counts in test cases (2-10 processes), the linear search is more than sufficient and actually simpler  
* The current implementation is clear and maintainable, which outweighs micro-optimizations for this assignment scale

**Assessment:**  
The code is efficient for the problem scale. The AI chose appropriate data structures and algorithms. No significant optimizations are needed, and the code prioritizes clarity over premature optimization, which is appropriate for this assignment.

## Readability

The AI-generated code demonstrates excellent readability:

**Code Organization:**

* Clear separation of concerns: parsing, simulation, and output generation are in separate functions  
* Each algorithm has its own dedicated function (\`run\_fcfs\`, \`run\_sjf\_preemptive\`, \`run\_rr\`)  
* Helper functions are well-named and focused (\`build\_arrival\_map\`, \`sjf\_better\`, \`build\_summary\`)

**Variable Naming:**

* Descriptive names: \`process\_count\`, \`run\_for\`, \`remaining\`, \`start\_time\`, \`finish\_time\`  
* Consistent naming conventions throughout (snake\_case for Rust)  
* Clear abbreviations where appropriate (\`cfg\` for config, \`procs\` for processes)

**Code Style:**

* Consistent formatting and indentation  
* Logical flow: parse input → run simulation → generate output  
* Comments are minimal, but the code is self-documenting through good naming

**Code Duplication:**

* Some duplication exists in the three algorithm functions (arrival handling, idle detection), but this is acceptable as each algorithm has unique logic  
* Shared helper functions (\`build\_arrival\_map\`, \`build\_summary\`) reduce duplication effectively

**Documentation:**

* The code includes helpful comments explaining key decisions (e.g., "finish is printed at time t+1")  
* The README.md provides comprehensive usage documentation  
* Error messages are clear and informative

**Assessment:**  
The code is highly readable and follows Rust best practices. The AI maintained a consistent style across all prompts, and the code structure makes it easy to understand the logic flow. The naming conventions are intuitive, and the separation of concerns makes the code maintainable.

## Completeness

The code demonstrates comprehensive completeness:

**Edge Cases Handled:**  
1\. Idle CPU: Correctly prints "Idle" when no processes are ready  
2\. Unfinished Processes: Properly identifies and reports processes that don't finish within \`run\_for\` time  
3\. Simultaneous Arrivals: The arrival map handles multiple processes arriving at the same time, processing them in input order  
4\. Process Finishing at End: Handles processes that finish exactly at \`run\_for\` time  
5\. Empty Ready Queue: Correctly handles when the ready queue is empty during simulation

**Error Handling:**  
1\. Missing Input File: Returns error "Error: Could not read input file."  
2\. Missing Parameters: Checks for all required parameters (processcount, runfor, use) and returns specific error messages:

* "Error: Missing parameter processcount."  
* "Error: Missing parameter runfor."  
* "Error: Missing parameter use."

3\. Missing Quantum for RR: Specifically checks and returns "Error: Missing quantum parameter when use is 'rr'"  
4\. Invalid Parameters: Validates parameter values (e.g., invalid numbers)  
5\. Missing Command-Line Arguments: Displays usage message "Usage: scheduler-get.py \<input file\>" (it should be "Usage: scheduler-get.rs \<input file\>", just follow the description)  
6\. Malformed Input: Handles missing process parameters (name, arrival, burst) with specific error messages

**Race Conditions:**  
The code properly handles simultaneous events through a well-defined event ordering:  
1\. Process arrivals at time t  
2\. Process finishes at time t (from previous tick)  
3\. Process selection at time t  
4\. Idle detection at time t  
5\. Execution of one time tick

This ordering ensures deterministic behavior when multiple events occur at the same time. The arrival map processes simultaneous arrivals in input order, maintaining consistency.

**Flexibility:**

* Handles variable numbers of processes (tested with 2, 5, and 10 processes)  
* Supports different \`run\_for\` values  
* Works with various quantum values for Round Robin  
* Handles processes with different arrival times and burst times

**Assessment:**  
The code is highly complete. It handles all specified edge cases, provides comprehensive error handling with appropriate error messages, and properly manages simultaneous events. The event ordering ensures deterministic behavior, addressing the "race condition" concern through explicit ordering rather than relying on undefined behavior.

## Learning Assistance

**Learning Rust Through AI:**

Initially, team members had limited or no experience with Rust. The AI assistance was instrumental in learning the language:

1\. Syntax Learning: Prompts like "How do I declare a struct in Rust?" and "What's the difference between \`Vec\` and \`VecDeque\`?" helped understand Rust-specific constructs.

2\. Ownership and Borrowing: Questions about Rust's ownership system were necessary, particularly for understanding why certain patterns were used (e.g., using references \`&\[Process\]\` instead of moving ownership).

3\. Error Handling: Learning Rust's \`Result\<T, E\>\` type and \`match\` expressions for error handling was facilitated through AI explanations.

4\. Standard Library: Understanding which data structures to use (\`VecDeque\` for queues, \`Vec\` for lists) came from AI recommendations.

**Code Clarity:**

The AI-generated code was generally clear enough that extensive additional learning resources weren't necessary. The code's self-documenting nature (good variable names, logical structure) made it understandable even with limited Rust knowledge. However, some concepts still required clarification:  
\- Understanding why certain patterns were used (e.g., \`Option\<usize\>\` for nullable values)  
\- Rust's pattern-matching syntax  
\- String handling in Rust (owned vs borrowed strings)

**Assessment of AI-Assisted Programming in Unknown Languages:**

**Feasibility:** Yes, it is possible to use AI to code in languages you don't know, but with important caveats:

**Advantages:**

* AI can generate syntactically correct code quickly  
* AI can explain language-specific concepts when asked  
* AI can suggest appropriate libraries and patterns  
* Reduces initial learning curve

**Limitations:**  
1\. Understanding vs. Copying: There's a risk of copying code without understanding it, which becomes problematic when debugging or modifying code.

2\. Language-Specific Idioms: AI may not always use the most idiomatic patterns for a language. Human review is needed to ensure code follows best practices.

3\. Error Messages: When code fails, understanding Rust's compiler errors requires some language knowledge. AI can help explain errors, but there's still a learning curve.

4\. Debugging: Debugging AI-generated code in an unknown language is challenging. You need enough understanding to trace through the logic.

5\. Maintenance: Long-term maintenance of AI-generated code requires understanding the language. You can't effectively modify or extend code you don't understand.

6\. AI Limitations: AI may generate code that compiles but doesn't work correctly, or uses deprecated patterns. Without language knowledge, it's harder to identify these issues.

**Recommendation:**

* AI is excellent for learning and getting started, but it should be used as a learning tool, not a replacement for understanding. The ideal approach is to:  
* Use AI to generate initial code  
* Ask AI to explain the code it generated  
* \-Study the explanations and experiment  
* Gradually build understanding through iterative development

For this project, the AI assistance was valuable for learning Rust while building a functional solution, but team members still needed to understand the code to verify correctness and make necessary adjustments.

## Overall Quality and Final Recommendation

**Overall Quality Rating:** 9/10

The AI-generated code is of high quality. It correctly implements all required functionality, handles edge cases well, is readable and maintainable, and demonstrates a good understanding of the problem domain. The minor deductions are for:

* Some code duplication across algorithm functions (acceptable given the requirements)  
* Minor formatting adjustments needed (addressed through iteration)

**Recommended Improvements:**  
1\. Code Organization: Consider extracting common simulation logic into a shared function to reduce duplication, though the current approach is acceptable for clarity.

2\. Testing: Add unit tests for individual functions (e.g., \`sjf\_better\` tie-breaking logic) to catch regressions during refactoring.

3\. Documentation: Add more inline documentation for complex algorithms (especially the SJF preemption logic), though the code is generally self-explanatory.

4\. Error Messages: Consider more descriptive error messages for invalid input values (e.g., negative burst times), though current error handling is adequate.

**Overall Experience:** 8.5/10

**Easier or Harder Than Expected:**  
The experience was easier than expected in some ways and more challenging in others:

**Easier:**  
\- Getting initial working code was faster than writing from scratch  
\- AI could quickly generate boilerplate and common patterns  
\- AI helped with syntax and language-specific questions  
\- Iterative refinement was efficient \- could quickly ask for changes

**More Challenging:**  
\- Ensuring correctness required careful testing and verification  
\- Some AI suggestions needed correction (e.g., output formatting)  
\- Understanding AI-generated code in an unfamiliar language took time  
\- Balancing when to prompt more vs. fix manually required judgment

**Key Learnings:**

1\. Prompt Engineering Matters: The quality of prompts directly impacts output quality. Specific, detailed prompts with examples produce better results than vague requests.

2\. Iteration is Essential: First AI output is rarely perfect. Multiple rounds of refinement are necessary, but there's a point of diminishing returns.

3\. Verification is Critical: AI-generated code must be thoroughly tested. AI can make logical errors or miss edge cases.

4\. AI as a Tool, Not a Replacement: AI accelerates development but doesn't eliminate the need for understanding. You still need to verify, debug, and understand the code.

5\. Language Learning: AI can help learn new languages, but it's most effective when used actively (asking questions, understanding explanations) rather than passively (copying code).

6\. Code Review: AI-generated code benefits from human review just like human-written code. Fresh eyes catch issues AI might miss.

**What Would We Do Differently:**

1\. Start with More Specific Prompts: Begin with detailed requirements and examples rather than generic requests. This would reduce iteration cycles.

2\. Test Earlier and More Frequently: Test after each major prompt iteration rather than waiting until the end. Catch issues earlier.

3\. Ask for Explanations Proactively: When AI generates code, immediately ask it to explain the logic, especially for unfamiliar patterns. This builds understanding faster.

4\. Document Prompt History Better: Keep detailed notes on what prompts worked and what didn't. This helps refine the approach.

5\. Set Clear Stopping Criteria: Define upfront when to stop prompting and fix manually. This prevents over-iteration on minor issues.

6\. Request Test Cases: Ask AI to suggest test cases for edge conditions. This helps identify gaps in implementation.

7\. Code Review Sessions: Schedule dedicated time to review AI-generated code together as a team, discussing the logic and potential improvements.

**Final Recommendation:**

The AI-generated code is production-ready for this assignment. It correctly implements all requirements, handles edge cases, and is maintainable. The development process demonstrated that AI can be a powerful tool for rapid prototyping and learning, but human oversight, testing, and understanding remain essential.

**For future AI-assisted development:**

* Use AI for initial implementation and learning  
* Invest time in understanding the generated code  
* Test thoroughly and verify correctness  
* Know when to stop prompting and fix manually  
* Treat AI as a collaborative tool, not a replacement for programming skills

The overall experience was positive and educational, providing valuable insights into the capabilities and limitations of AI-assisted programming.

# Bonus Features

## Colored Terminal Output

The implementation includes an optional colored output feature using ANSI escape codes. This feature:

* Enhances terminal visualization with color-coded events  
* Separates presentation (terminal) from artifact output (\`.out\` files)  
* Grading files remain unchanged (plain text format)  
* Only activates with the \`--color\` flag

**Color Mapping:**  
🔵 Blue: Process arrivals  
🟢 Green: Process selections  
🔴 Red: Process finishes  
🟡 Yellow: Idle periods  
🔷 Cyan: Headers and summary information

This feature was implemented manually as a bonus enhancement, demonstrating the ability to extend AI-generated code with additional features.

# Conclusion

This project successfully demonstrated the use of AI-assisted programming to implement complex algorithms in an unfamiliar language. The AI-generated code achieved high quality across all evaluation criteria: correctness, efficiency, readability, and completeness. The iterative refinement process showed the importance of clear prompts and thorough testing.

The experience highlighted both the capabilities and limitations of AI coding assistants. While AI significantly accelerated development and learning, human oversight, understanding, and verification remained essential. The project provided valuable insights into effective AI-assisted development workflows and the balance between leveraging AI capabilities and maintaining code quality and understanding.

# Test Results

All test cases pass successfully:  
\-  c2-fcfs, c2-sjf, c2-rr  
\- c5-fcfs, c5-sjf, c5-rr  
\- c10-fcfs, c10-sjf, c10-rr

**Total:** 9/9 test cases passing  
