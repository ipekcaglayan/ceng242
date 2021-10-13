orbits(mercury, sun).
orbits(earth, sun).
orbits(moon, earth).
orbits(europa, jupiter).

planet(B) :- orbits(B,sun).

satellite(B) :- orbits(B,P), planet(P).


