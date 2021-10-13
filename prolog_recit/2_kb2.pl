plays_guitar(john).
happy(sarah).
listens_to_music(john) :- plays_guitar(john).
listens_to_music(sarah) :- happy(sarah).
listens_to_music(sarah) :- plays_guitar(sarah).

