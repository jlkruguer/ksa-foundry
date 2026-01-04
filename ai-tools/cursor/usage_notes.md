This guide is specific to cursor in terms of hot keys etc. 

Init your project yourself. Install your own dependencies etc. AI can run terminal commands but it's cleaner and there's less headache if you do this part manually. 


CMD+e switches between agent and editor mode. Hotkey. 

Agent mode: Opus 4.5 for planning 
Planning mode: If you know which tools you want to use you can set that upp. 

Work trees .... come back later...


Planning: Generate the plan, answer the questions, read the plan thoroughly. This will be an .md file. Discuss in planning mode to clarify or modify the plan. If you want to make edits ask for "Changes" and list them in bullet points. 


Ok after you have a plan you can use work trees they are a nice in between. L1 - agent in editor on one task. L2 - work tree split tasks into different directories that can be merged which helps avoid PR bloat and if you have a little addition you can solve it easily. L3 - full background agent which can be overkill. 

Worktrees also allow you to use different models or compare the same models. You can select the number of instances to use as well (need to understand why). 

Now you can say implement the project... diferent instances working in different paths see them in .cursor.

worktree json ... setup actions e.g. if you want each one to get .env file copied from the root path. also in .cursor 

Review tab.. shows full diff of all files. Great to review everything. 
