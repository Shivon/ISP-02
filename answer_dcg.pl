:- consult('family_tree.pl').

answer(Sem) :- (call(Sem), go(Sem) ; go_fail(Sem)), false.

go(Sem) :- call(Sem), Sem =.. Sem_As_List, split_list(Sem,Sem_As_List, ''), nl,!.
go_fail(Sem) :- not(call(Sem)), Sem =.. Sem_As_List, split_list(Sem,Sem_As_List, 'nicht '), nl,!.

split_list(Sem,Sem_As_List,NOT) :- Sem_As_List = [Rule|A], A = [AtomX|B], B = [AtomY|_], create_answer(Sem,Rule,AtomX,AtomY,NOT).
split_list(Sem,Sem_As_List,NOT) :- Sem_As_List = [Rule|A], A = [AtomX|_], create_answer(Sem,Rule,AtomX,NOT).

create_answer(Sem,Rule,AtomX,AtomY,NOT) :-
              nonvar(AtomX), nonvar(AtomY), lex(Rule,Rule_Translation,Gender), write(AtomX), write(' ist '), art(Art, Gender), write(NOT), write(Art), write(Rule_Translation), write(' von '), write(AtomY);
              not(call(Sem)), nonvar(AtomX), lex(Rule,Rule_Translation,Gender), lex(keine, Translation, Gender), write(AtomX), write(' hat '), write(Translation), write(Rule_Translation);
              not(call(Sem)), nonvar(AtomY), lex(Rule,Rule_Translation,Gender), lex(keine, Translation, Gender), write(AtomY), write(' hat '), write(Translation),  write(Rule_Translation).

create_answer(_,Rule,AtomX,NOT) :- lex(Rule,Rule_Translation,_), write(AtomX), write(' ist '), write(NOT), write(Rule_Translation).


lex(uncle, onkel, m).
lex(mother, mutter, w).
lex(father, vater, m).
lex(parent, elternteil, m).
lex(sibling,  geschwister, w).
lex(brother,  bruder, m).
lex(sister, schwester, w).
lex(nephew, neffe, m).
lex(niece,  nichte, w).
lex(granduncle,  grossonkel, m).
lex(child, kind, n).
lex(child,  kinder, w).

%Adjektive
lex(male,maennlich,_).
lex(female, weiblich,_).
lex(married,verheiratet,_).
lex(childless, kinderlos,_).

lex(keine, 'keine ', w).
lex(keine, 'keinen ', m).

art('die ', w).
art('der ', m).
art('das ', n).
