happy(john).
plays_guitar(sarah).

listens_to_music(john) :-
	happy(john),
	plays_quitar(john).


listens_to_music(sarah) :- happy(sarah).
listens_to_music(sarah) :- plays_guitar(sarah).

		
