new_user:- retractall(career_choice(_)), retractall(marks(_,_)), retractall(recommended(_)).

enter_career:- write("What is your career choice? "), read(Choice), nl, assert(career_choice(Choice)).

enter_marks:- pre_req(_,Course), not(marks(Course,_)), write(Course), nl, write("Enter grade (0 if not done): "), read(Marks), nl, 
assert(marks(Course,Marks)), fail.

suggest_special:- (career_choice('Uncertain'), write('Skip special elective this semester to explore oppurtunities'));
marks('Real Analysis-1', Marks1), marks('Linear Algebra', Marks2), ((career_choice('Data Analytics'), write('Real Analysis-2')); 
(not(career_choice('Data Analytics')), Marks2<Marks1, write('Real Analysis-2')); write('Scientific Computing')), nl.

suggest:- current_course(Course), forall(pre_req(Course,Pre), (marks(Pre,Marks), Marks>0)), assert(recommended(Course)), fail.

recommend:- convert_to_list(List), predsort(higher, List, Sorted), write('Recommended Courses ranked in the order best suitable for you'), 
nl, write(Sorted), nl.

convert_to_list([Cx|Tail]):- retract(recommended(Cx)), convert_to_list(Tail).
convert_to_list([]).

decent_marks(Course):- forall(pre_req(Course,Pre), (marks(Pre,Marks), Marks>5)).

current_course('Machine Learning').
current_course('Artificial Intelligence').
current_course('Natural Language Processing').
current_course('Data Mining').
current_course('Computer Networks').
current_course('Fundamentals of Computer Security').
current_course('Introduction to Blockchain and Cryptography').
current_course('Applied Cryptography').
current_course('Computer Graphics').
current_course('Program Analysis').
current_course('Theory of Modern Cryptography').
current_course('Mining Large Networks').

career('Machine Learning','Data Analytics').
career('Artificial Intelligence','Data Analytics').
career('Natural Language Processing','Data Analytics').
career('Data Mining','Data Analytics').
career('Computer Networks','Network and Security').
career('Fundamentals of Computer Security','Network and Security').
career('Mining Large Networks','Network and Security').
career('Introduction to Blockchain and Cryptography','Cryptology').
career('Applied Cryptography','Cryptology').
career('Theory of Modern Cryptography','Cryptology').
career('Computer Graphics','Program Analysis Graphics').
career('Program Analysis','Program Analysis Graphics').

pre_req('Machine Learning', 'Linear Algebra').
pre_req('Machine Learning', 'Probability and Statistics').
pre_req('Machine Learning', 'Introduction to Programming').
pre_req('Machine Learning', 'Maths-3').
pre_req('Artificial Intelligence', 'Data Structures and Algorithms').
pre_req('Computer Networks', 'Introduction to Programming').
pre_req('Computer Networks', 'Analysis and Design of Algorithms').
pre_req('Computer Networks', 'Operating Systems').
pre_req('Real Analysis-2', 'Real Analysis-1').
pre_req('Scientific Computing', 'Linear Algebra').
pre_req('Applied Cryptography', 'Discrete Mathematics').
pre_req('Natural Language Processing', 'Probability and Statistics').
pre_req('Natural Language Processing', 'Analysis and Design of Algorithms').
pre_req('Natural Language Processing', 'Introduction to Programming').
pre_req('Natural Language Processing', 'Linear Algebra').
pre_req('Data Mining', 'Database Management').
pre_req('Data Mining', 'Introduction to Programming').
pre_req('Data Mining', 'Linear Algebra').
pre_req('Data Mining', 'Probability and Statistics').
pre_req('Computer Graphics', 'Introduction to Programming').
pre_req('Program Analysis', 'Advanced Programming').
pre_req('Program Analysis', 'Data Structures and Algorithms').
pre_req('Mining Large Networks', 'Probability and Statistics').
pre_req('Mining Large Networks', 'Analysis and Design of Algorithms').
pre_req('Mining Large Networks', 'Introduction to Programming').

pre_req_of('Machine Learning',8).
pre_req_of('Artificial Intelligence',3).
pre_req_of('Natural Language Processing',0).
pre_req_of('Data Mining',0).
pre_req_of('Computer Networks',5).
pre_req_of('Fundamentals of Computer Security',1).
pre_req_of('Introduction to Blockchain and Cryptography',0).
pre_req_of('Applied Cryptography',0).
pre_req_of('Theory of Modern Cryptography',0).
pre_req_of('Computer Graphics',0).
pre_req_of('Program Analysis',0).
pre_req_of('Mining Large Networks',0).

project('Machine Learning').
project('Natural Language Processing').
project('Data Mining').
project('Fundamentals of Computer Security').
project('Introduction to Blockchain and Cryptography').
project('Applied Cryptography').
project('Theory of Modern Cryptography').
project('Computer Graphics').
project('Mining Large Networks').

same_marks(X,Y):- (decent_marks(X), decent_marks(Y)); (not(decent_marks(X)), not(decent_marks(Y))).
same_career(X,Y):- career(X,C1), career(Y,C2), ((career_choice(C1), career_choice(C2)); (not(career_choice(C1)), not(career_choice(C2)))).
same_Prereq(X,Y):- pre_req_of(X,P1), pre_req_of(Y,P2), P1==P2.
same_project(X,Y):- (project(X),project(Y));(not(project(X)),not(project(Y))).

greater(X,Y):- decent_marks(X), not(decent_marks(Y)).
greater(X,Y):- same_marks(X,Y), career(X,C1), career(Y,C2), career_choice(C1), not(career_choice(C2)).
greater(X,Y):- same_marks(X,Y), same_career(X,Y), pre_req_of(X,P1), pre_req_of(Y,P2), P1>P2.
greater(X,Y):- same_marks(X,Y), same_career(X,Y), same_Prereq(X,Y), project(X), not(project(Y)).

higher(<,X,Y):- greater(X,Y).
higher(>,X,Y):- not(greater(X,Y)).
higher(=,X,Y):- same_marks(X,Y), same_career(X,Y), same_Prereq(X,Y), same_project(X,Y).
