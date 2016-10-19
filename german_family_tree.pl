% Boer = giant = m
% Bestla = giantess = f
% Grid = giantess = f

maennlich(boer).
maennlich(odin).
maennlich(vili).
maennlich(ve).
maennlich(vidar).
maennlich(thor).
maennlich(magni).
maennlich(modi).
maennlich(balder).
maennlich(hoed).
maennlich(hermodur).
maennlich(bragi).
maennlich(tyr).
maennlich(forseti).

weiblich(bestla).
weiblich(frigg).
weiblich(joerd).
weiblich(grid).
weiblich(nanna).
weiblich(sif).
weiblich(idun).

% verheiratet/2
% verheiratet(X,Y), X is married to Y
verheiratet(boer, bestla).
verheiratet(odin, frigg).
verheiratet(odin, joerd).
verheiratet(odin, grid).
verheiratet(thor, sif).
verheiratet(balder, nanna).
verheiratet(bragi, idun).

verheiratet(bestla, boer).
verheiratet(frigg, odin).
verheiratet(joerd, odin).
verheiratet(grid, odin).
verheiratet(sif, thor).
verheiratet(nanna, balder).
verheiratet(idun, bragi).

% elternteil/2
% elternteil(X, Y), X is parent of Y
elternteil(boer, odin).
elternteil(boer, vili).
elternteil(boer, ve).
elternteil(bestla, odin).
elternteil(bestla, vili).
elternteil(bestla, ve).

elternteil(odin, balder).
elternteil(odin, hoed).
elternteil(odin, hermodur).
elternteil(odin, bragi).
elternteil(odin, tyr).
elternteil(odin, thor).
elternteil(odin, vidar).
elternteil(frigg, balder).
elternteil(frigg, hoed).
elternteil(frigg, hermodur).
elternteil(frigg, bragi).
elternteil(frigg, tyr).
elternteil(joerd, thor).
elternteil(grid, vidar).

elternteil(balder, forseti).
elternteil(nanna, forseti).
elternteil(thor, magni).
elternteil(thor, modi).
elternteil(sif, magni).
elternteil(sif, modi).

% vater/2
% vater(X, Y), X is father of Y
vater(X, Y) :- elternteil(X, Y), maennlich(X).

% mutter/2
% mutter(X, Y), X is mother of Y
mutter(X, Y) :- elternteil(X, Y), weiblich(X).

% geschwister/2
geschwister(X, Y) :- mutter(M, X), mutter(M, Y), vater(F, X), vater(F, Y), X \= Y.

% bruder/2
% bruder(X, Y), X is brother of Y
bruder(X, Y) :- maennlich(X), geschwister(X, Y).

% schwester/2
% schwester(X, Y), X is sister of Y
schwester(X, Y) :- weiblich(X), geschwister(X, Y).

% halb_bruder/2
% halb_bruder(X, Y), X is half_bruder of Y
halb_bruder(X, Y) :- maennlich(X), mutter(M, X), mutter(M, Y), vater(F1, X), vater(F2, Y), F1 \= F2, X \= Y;
                     maennlich(X), vater(F, X), vater(F, Y), mutter(M1, X), mutter(M2, Y), M1 \= M2, X \= Y.

% neffe/2
% neffe(X, Y), X is nephew of Y
neffe(X, Y) :- maennlich(X), elternteil(P, X), geschwister(P, Y).

% nichte/2
% nichte(X, Y), X is niece of Y
nichte(X, Y) :- weiblich(X), elternteil(P, X), geschwister(P, Y).

% grossonkel/2
% grossonkel(X, Y), X is granduncle of Y
grossonkel(X, Y) :- maennlich(X), elternteil(P, Y), (neffe(P, X) ; nichte(P, X)).

% kinderlos/1
% the request cannot be bundled within "not(elternteil(X, _Y))", when you want to request all childless family members, too
% reason: with childless(X), elternteil(X, _Y) would give back tupel of two names and Prolog needs to handle them separately to go on
kinderlos(X) :- maennlich(X), not(vater(X, _Y));
                weiblich(X), not(mutter(X, _Y)).

% onkel/2
% onkel(X, Y), X is uncle of Y
onkel(X, Y) :- maennlich(X), elternteil(P, Y), geschwister(P, X).

% nicht_verheiratet/2
% nicht_verheiratet(X, Y), X is not married to Y
nicht_verheiratet(X, Y) :- (maennlich(X), weiblich(Y); weiblich(X), maennlich(Y)), \+ verheiratet(X,Y).
