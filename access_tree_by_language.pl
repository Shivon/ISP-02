:- consult('family_tree.pl').
:- consult('readsentence.pl').

run(Sentence) :- read_sentence(Sentence), check_grammar(Sentence, []).

check_grammar --> verbal_phrase, noun_phrase, punctuation.

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
noun_phrase --> personal_name.
noun_phrase --> personal_name, adjective.

personal_name --> [X], { lex(_, pn, X, sg) }.
adjective --> [X], { lex(_, adj, X, sg) }.

% prepositional phrase
%   * pre, noun phrase
%   * pre, <part of noun phrase like mentioned above>


% verbal phrase
%   * verb
%   * verb, noun phrase
verbal_phrase --> verb.
verbal_phrase --> verb, noun_phrase.

verb --> [X], { lex(_, v, X, _) }.

punctuation --> [X], { lex(_, pun, X, _) }.

lex(boer, pn, boer, sg).
lex(odin, pn, odin, sg).
lex(vili, pn, vili, sg).
lex(ve, pn, ve, sg).
lex(vidar, pn, vidar, sg).
lex(thor, pn, thor, sg).
lex(magni, pn, magni, sg).
lex(modi, pn, modi, sg).
lex(balder, pn, balder, sg).
lex(hoed, pn, hoed, sg).
lex(hermodur, pn, hermodur, sg).
lex(bragi, pn, bragi, sg).
lex(tyr, pn, tyr, sg).
lex(forseti, pn, forseti, sg).
lex(bestla, pn, bestla, sg).
lex(frigg, pn, frigg, sg).
lex(joerd, pn, joerd, sg).
lex(grid, pn, grid, sg).
lex(nanna, pn, nanna, sg).
lex(sif, pn, sif, sg).
lex(idun, pn, idun, sg).

lex(male, adj, mann, sg).
lex(male, adj, maennlich, sg).

lex(_, v, ist, _).
lex(_, pun, ?, _).
