% Author: Thomas Haddy 5/2/19

% facts on attr1
attr1(black, red).
attr1(black, blue).
attr1(black, white).
attr1(blue, red).
attr1(white, blue).
attr1(white, red).

% facts on attr2
attr2(electric, X) :- X = four; X = six.
attr2(hybrid, X) :- X = four; X = six.
attr2(four, six).

% facts on attr3
attr3(tesla, X) :- X = skoda; X = alfa; X = bmw.
attr3(bmw, X) :- X = skoda; X = alfa.
attr3(alfa, skoda).

attr4(a, b).
attr4(b, c).
attr4(c, d).

% The choices
carlist([ 
	(red, electric, tesla),
	(black, hybrid, bmw),
	(blue, electric, bmw),
	(red, hybrid, bmw),
	(red, four, alfa),
	(blue, electric, tesla),
	(black, four, alfa),
	(black, electric, skoda)
]).

edge1(A, B) :- attr1(A, B).
edge1(A, B) :- attr1(A, C), edge1(C, B).

edge2(A, B) :- attr2(A, B).
edge2(A, B) :- attr2(A, C), edge2(C, B).

edge3(A, B) :- attr3(A, B).
edge3(A, B) :- attr3(A, C), edge3(C, B).

identicalOrPreferred1(A, B) :- A == B.
identicalOrPreferred1(A, B) :- edge1(A, B).

identicalOrPreferred2(A, B) :- A == B.
identicalOrPreferred2(A, B) :- edge2(A, B).

identicalOrPreferred3(A, B) :- A == B.
identicalOrPreferred3(A, B) :- edge3(A, B).

prefer((A1, A2, A3), (B1, B2, B3)) :- 
	identicalOrPreferred1(A1, B1),
	identicalOrPreferred2(A2, B2),
	identicalOrPreferred3(A3, B3),
		(edge1(A1, B1);
		points1(A2, B2);
		points1(A3, B3)).

level0(Choice, L) :-
	member(Choice, L),
	not(Choice == ChoiceCur),
	prefer(ChoiceCur, Choice).

%carlist(L), weakorder(L, Result).