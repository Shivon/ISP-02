:- consult('family_tree.pl').
:- consult('readsentence.pl').
:- consult('answer_dcg.pl').

run(Sentence) :- repeat, read_sentence(Sentence), check_grammar(Sem, Sentence, []),  answer(Sem), fail.

%run :- repeat, write('> '), read(Sentence), read_sentence(Sentence), check_grammar(Sem, Sentence, []), answer(Sem), fail.
%ist X der bruder von Y
check_grammar(SemS) --> verbal_phrase(SemV,N), noun_phrase(SemNP,N), punctuation, {((SemNP = [_,SemV,_], SemS =.. SemNP); (X = [SemV,SemNP,_], SemS =.. X) )}.
%wer sind die kinder von X
check_grammar(SemS) --> verbal_phrase(N), noun_phrase(SemNP,N), punctuation, {SemS =.. SemNP}.
%ist X maennlich?
check_grammar(SemS) --> verbal_phrase(N), noun_phrase(SemNP,N), adjective_phrase(SemAdj,N), punctuation, { SemAdj = [_,SemNP], SemS =.. SemAdj}.

% lex(meaning, part of speech, word, mode)
% pn = personal_name
% adj = adjective
% v = verb
% n = noun
% art = article
% pre = preposition
% pun = punctuation
%
% noun phrase
%   * pn
%   * art, n
%   * art, n, prepositional phrase
noun_phrase(SemN,N) --> personal_name(SemN,N).
noun_phrase(SemN,N) --> personal_pronoun, noun(SemN,N,_).
noun_phrase([SemN,_,SemP],N) --> article(N,Gender), noun(SemN,N,Gender), prepositional_phrase(SemP,N).

personal_name(SemN,N) --> [X], { lex(SemN, pn, X, N,_) }.
article(N,Gender) --> [X], {  lex(_, art, X, N,Gender)}.
noun(SemN,N,Gender) --> [X], { lex(SemN, n, X, N,Gender)}.


% prepositional phrase
%   * pre, noun phrase
%   * pre, <part of noun phrase like mentioned above>
prepositional_phrase(SemN,N) --> preposition, noun_phrase(SemN,N).

preposition --> [X], { lex(_,pre,X,_,_)}.

% verbal phrase
%   * verb
%   * verb, noun phrase
verbal_phrase(SemV,N) --> verb(N), noun_phrase(SemV,N); noun_phrase(SemV, N), verb(N).
verbal_phrase(N) --> verb(N).
verbal_phrase(N) --> personal_pronoun, verb(N).

personal_pronoun --> [X], {lex(_,pro,X,_,_)}.
verb(N) --> [X], { lex(_, v, X, N,_) }.

% adjective_phrase
adjective_phrase([SemAdj,_],N) --> adjective(SemAdj,N).
adjective_phrase([SemAdj,_],N) --> article(N,_), adjective(SemAdj,N).

adjective(SemAdj,N) --> [X], { lex(SemAdj, adj, X, N,_) }.

punctuation --> [X], { lex(_, pun, X, _,_) }.

lex(boer, pn, boer, _, _).
lex(odin, pn, odin, _, _).
lex(vili, pn, vili, _, _).
lex(ve, pn, ve, _, _).
lex(vidar, pn, vidar, _, _).
lex(thor, pn, thor, _, _).
lex(magni, pn, magni, _, _).
lex(modi, pn, modi, _, _).
lex(balder, pn, balder, _, _).
lex(hoed, pn, hoed, _, _).
lex(hermodur, pn, hermodur, _, _).
lex(bragi, pn, bragi, _, _).
lex(tyr, pn, tyr, _, _).
lex(forseti, pn, forseti, _, _).
lex(bestla, pn, bestla, _, _).
lex(frigg, pn, frigg, _, _).
lex(joerd, pn, joerd, _, _).
lex(grid, pn, grid, _, _).
lex(nanna, pn, nanna, _, _).
lex(sif, pn, sif, _, _).
lex(idun, pn, idun, _, _).

%Beziehungen
lex(uncle, n, onkel, sg, m).
lex(uncle, n, onkel, pl, m).
lex(mother, n, mutter, sg, f).
lex(mother, n, muetter, pl,f).
lex(father, n, vater, sg, m).
lex(father, n, vaeter, pl, m).
lex(parent, n, elternteil, sg, m).
lex(parent, n, elternteile, pl, m).
lex(sibling, n, geschwister, pl, f).
lex(brother, n, brueder, pl, m).
lex(brother, n, bruder, sg, m).
lex(sister, n, schwestern, pl, f).
lex(sister, n, schwester, sg, f).
lex(nephew, n, neffen, pl, m).
lex(nephew, n, neffe, sg, m).
lex(niece, n, nichten, pl, f).
lex(niece, n, nichte, sg, f).
lex(granduncle, n, grossonkel, pl, m).
lex(granduncle, n, grossonkel, sg, m).
lex(child, n, kinder, pl, w).
lex(child, n, kind, sg, w).

%Adjektive
lex(male, adj, mann, sg,m).
lex(male, adj, maennlich, sg,m).
lex(female, adj, weiblich, sg,f).
lex(female, adj, frau, sg, f).
lex(spouse, adj, verheiratet, sg,_).
lex(childless, adj, kinderlos, sg,_).

lex(_, pre, von, _,_).
lex(_, v, ist, sg,_).
lex(_, v, sind, pl,_).

lex(_, pro, wer, _,_).
lex(_, pro, wessen, _,_).

lex(_, pun, ?, _,_).

lex(_, art, der, sg,m).
lex(_, art, die, sg,f).
lex(_, art, das, sg,_).
lex(_, art, die, pl, _).
lex(_, art, ein, sg, m).
lex(_, art, eine, sg, f).
