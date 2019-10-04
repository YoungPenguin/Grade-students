# Grade-student
The final project from DTU 02633 Introduction to Programming and Data Processing

Program for grading students (all comments in the code are in Danish... sorry... but it's fairly straightforward)

WARNING! not maintained: The code was developed in MATLAB2018a then convertet to 2018b. if you're using a newer version of MATLAB you might have to throw some extra exceptions.

This project takes a comma-separated-values (CSV) file. This Program has been extended so it can handle files with letters in the file, aswell as files with missing values. Exampels of the files can be found in 

basic files:
            *basis1.csv 
						*basis2.csv
						*basis3.csv
            
weird looking files:
            *funk1.csv
						*funk2.csv
						*funk3.csv

then it can:


| #  | choice     |
| ---| ---       |
| 1  | Load new data.  |
| 2  | Check for data errors  |
| 3  | Generate plots.  |
| 4  | Display list of grades.  |
| 5  | Quit.  |



Load new data: 
At start, to enter the program, you need to type the name of the file you want to load (a list will be displayed in consol) after, when loading new data a GUI can be used. The consol is only used to meed the requirements from the assignments.


Errror tjeck:
If the user chooses to check for data errors, you must display a report of errors (if any)
in the loaded data file. Your program must at least detect and display information
about the following possible errors:
    1. If two students in the data have the same student id.
    2. If a grade in the data set is not one of the possible grades on the 7-step-scale.


plots include:
A) A bar plot of the number of students who have received each of possible final grades on the 7-step-scale


B) A plot with the assignments on the x-axis and the grades
on the y-axis. The x-axis must show all assignments from 1 to M, and the y-axis
must show all grade −3 to 12. The plot must contain:
    1. Each of the given grades marked by a dot. You must add a small random
number (between -0.1 and 0.1) to the x- and y-coordinates of each dot, to
be able tell apart the different dots which otherwise would be on top of each
other when more than one student has received the same grade in the same
assignment.
    2. The average grade of each of the assignments plotted as a line
