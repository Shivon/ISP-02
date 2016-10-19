% Boer = giant = m
% Bestla = giantess = f
% Grid = giantess = f

male(boer).
male(odin).
male(vili).
male(ve).
male(vidar).
male(thor).
male(magni).
male(modi).
male(balder).
male(hoed).
male(hermodur).
male(bragi).
male(tyr).
male(forseti).

female(bestla).
female(frigg).
female(joerd).
female(grid).
female(nanna).
female(sif).
female(idun).

% spouse/2
% spouse(X,Y), X is married to Y
spouse(boer, bestla).
spouse(odin, frigg).
spouse(odin, joerd).
spouse(odin, grid).
spouse(thor, sif).
spouse(balder, nanna).
spouse(bragi, idun).

spouse(bestla, boer).
spouse(frigg, odin).
spouse(joerd, odin).
spouse(grid, odin).
spouse(sif, thor).
spouse(nanna, balder).
spouse(idun, bragi).

% parent/2
% parent(X, Y), X is parent of Y
parent(boer, odin).
parent(boer, vili).
parent(boer, ve).
parent(bestla, odin).
parent(bestla, vili).
parent(bestla, ve).

parent(odin, balder).
parent(odin, hoed).
parent(odin, hermodur).
parent(odin, bragi).
parent(odin, tyr).
parent(odin, thor).
parent(odin, vidar).
parent(frigg, balder).
parent(frigg, hoed).
parent(frigg, hermodur).
parent(frigg, bragi).
parent(frigg, tyr).
parent(joerd, thor).
parent(grid, vidar).

parent(balder, forseti).
parent(nanna, forseti).
parent(thor, magni).
parent(thor, modi).
parent(sif, magni).
parent(sif, modi).

% father/2
% father(X, Y), X is father of Y
father(X, Y) :- parent(X, Y), male(X).

% mother/2
% mother(X, Y), X is mother of Y
mother(X, Y) :- parent(X, Y), female(X).

% sibling/2
sibling(X, Y) :- mother(M, X), mother(M, Y), father(F, X), father(F, Y), X \= Y.

% brother/2
% brother(X, Y), X is brother of Y
brother(X, Y) :- male(X), sibling(X, Y).

% sister/2
% sister(X, Y), X is sister of Y
sister(X, Y) :- female(X), sibling(X, Y).

% half_brother/2
% half_brother(X, Y), X is half_brother of Y
half_brother(X, Y) :- male(X), mother(M, X), mother(M, Y), father(F1, X), father(F2, Y), F1 \= F2, X \= Y;
                      male(X), father(F, X), father(F, Y), mother(M1, X), mother(M2, Y), M1 \= M2, X \= Y.

% nephew/2
% nephew(X, Y), X is nephew of Y
nephew(X, Y) :- male(X), parent(P, X), sibling(P, Y).

% niece/2
% niece(X, Y), X is niece of Y
niece(X, Y) :- female(X), parent(P, X), sibling(P, Y).

% granduncle/2
% granduncle(X, Y), X is granduncle of Y
granduncle(X, Y) :- male(X), parent(P, Y), (nephew(P, X) ; niece(P, X)).

% childless/1
% the request cannot be bundled within "not(parent(X, _Y))", when you want to request all childless family members, too
% reason: with childless(X), parent(X, _Y) would give back tupel of two names and Prolog needs to handle them separately to go on
childless(X) :- male(X), not(father(X, _Y));
                female(X), not(mother(X, _Y)).

% uncle/2
% uncle(X, Y), X is uncle of Y
uncle(X, Y) :- male(X), parent(P, Y), sibling(P, X).

% not_married/2
% not_married(X, Y), X is not married to Y
not_married(X, Y) :- (male(X), female(Y); female(X), male(Y)), \+ spouse(X,Y).
