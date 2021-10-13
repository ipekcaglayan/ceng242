person(joseph, 27, reading).
person(jessica, 32, crafting).
person(michael, 22, reading).
person(william, 33, reading).
person(elizabeth, 30, television).
person(jennifer, 38, crafting).
person(patricia, 33, bird_watching).
person(charles, 39, bird_watching).
person(david, 31, bird_watching).
person(mary, 25, crafting).
person(barbara, 25, reading).
person(richard, 32, travelling).
person(james, 22, fishing).
person(susan, 32, reading).
person(karen, 40, bird_watching).
person(sarah, 25, crafting).
person(linda, 21, reading).
person(john, 28, reading).
person(thomas, 23, bird_watching).
person(robert, 22, television).


sum_age([], 0).
sum_age([H|T], TotalAge) :- person(H,X,_), sum_age(T,Z), TotalAge is X+Z.



max_age_of_hobby([],_,0).
max_age_of_hobby([P|T], Hobby,MaxAge) :- helper([P|T], Hobby,0, Result), MaxAge is Result.
helper([],_,Age,Age).
helper([P|T], Hobby,Age,MaxAge) :-
        person(P,A,H),
        Hobby \= H,
        helper(T, Hobby,Age, MaxAge).
helper([P|T], Hobby,Age,MaxAge) :-
        person(P,A,Hobby),
        A > Age,
        helper(T, Hobby,A,MaxAge).
helper([P|T], Hobby,Age, MaxAge) :-
        person(P,A,Hobby),
       	A =< Age,
        max_age_of_hobby(T, Hobby,Age, MaxAge).


append([],List2,List2).
append([H|T1],List2,[H|T3]) :- append(T1,List2,T3).

person_in_range([],_,_,[]).
person_in_range([P|T],Min,Max,Res) :-
	person(P,Age,_), 
	person_in_range(T,Min,Max,Z),
	Age >= Min,
	Age =< Max,
	append([P], Z,List), Res is List.
person_in_range([P|T],Min,Max,Res) :-
        person(P,Age,_),
        person_in_range(T,Min,Max,Z),
        Age < Min;
        Age > Max,
        Res is Z.






