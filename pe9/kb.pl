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

% word(Atom)
word(acaba).
word(adana).
word(alaca).
word(araba).
word(eleme).
word(fiili).
word(ikili).
word(kekik).
word(ninni).
word(sosis).
word(afacan).
word(ajanda).
word(akbaba).
word(akraba).
word(ananas).
word(badana).
word(binici).
word(birisi).
word(deneme).
word(derece).
word(duyuru).
word(ezbere).
word(ikinci).
word(kabaca).
word(kamara).
word(kasaba).
word(keklik).
word(lahana).
word(matbaa).
word(muamma).
word(nerede).
word(otonom).
word(salata).
word(sessiz).
word(tabaka).
word(uyumlu).
word(yarasa).
word(yasama).
word(abla).
word(ada).
word(ala).
word(ama).
word(arka).
word(ayak).
word(baba).
word(daha).
word(dede).
word(dere).
word(deve).
word(evet).
word(gece).
word(imam).
word(inci).
word(kek).
word(kutu).
word(kuyu).
word(kuzu).
word(masa).
word(maya).
word(ses).
word(sis).
word(tat).
word(tava).
word(ufuk).
word(ulu).
word(uyku).
word(vana).


helper([H|T],A,R) :- atom_concat(A,H,R);helper(T,H,R).
biagram(W,R) :- atom_chars(W,[H|T]), helper(T,H,R). 

append([],List2,List2).
append([H|T1],List2,[H|T3]) :- append(T1,List2,T3).

check(Hobby,[],Current,Result):- append([hobby(Hobby,1)],Current,Result).

check(Hobby,[hobby(X,C) | T],Current,Result):- 
	Hobby \=X,
	append(Current,[hobby(X,C)],Result1),
       	check(Hobby, T,Result1,Result).
check(Hobby, [hobby(Hobby,C)|T],Current,Result) :-
	Z is C+1,
	append(Current,[hobby(Hobby,Z)], Result1),
	append(T,Result1,Result).

after_first([],Current,Current).
after_first([P|T],Current,ResultList):-
	person(P,_,Hobby),
	check(Hobby,Current,[],Result),
	after_first(T,Result,ResultList).
num_hobbies([],[]).
num_hobbies([P|T],ResultList):- 
	person(P,_,Hobby), 	
	check(Hobby,[],[],Result),
	after_first(T,Result,ResultList).
len([], 0).
len([_|T], N) :- len(T, Z), N is Z+1.

match(A1,A2,B1,B2):-
        A1\=A2, B1\=B2.
match(A1,A2,B1,B2):-
        not(A1\=A2), not(B1\=B2).

two_word([],_,[],_).
two_word([H1|T1],[],[H2|T2],[]):-
        two_word(T1,T1,T2,T2).

two_word([H1|T1],[C1|CT1],[H2|T2],[C2|CT2]):-
        match(H1,C1,H2,C2),
        two_word([H1|T1],CT1,[H2|T2],CT2).

compare(W1,W2):-
        atom_chars(W1,L1),
        atom_chars(W2,L2),
        two_word(L1,L1,L2,L2).

sentence_match([],[]).
sentence_match([X|T3],[W|T4]):-
        atom_chars(X,[H1|T1]),
        word(W),
        atom_chars(W,[H2|T2]),
        len(T1,N1),
        len(T2,N2),
        not(N1\=N2),compare(X,W),sentence_match(T3,T4).
