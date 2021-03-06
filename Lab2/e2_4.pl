% Exercise 2.4

% union(S1, S2, Res).
% Res is the result you get if you take the union of the sets S1 and S2.
union([], [], []) . 
union([S1|T1], [], [S1|Res]) :-
	union(T1, [], Res).
union([], [S2|T2], [S2|Res]) :-
	union([], T2, Res).
union([S1|T1], T2, Res) :-
	member(S1, T2),
	union(T1, T2, Res).
union([S1|T1], [S2|T2], [S1|Res]) :-
	nonmember(S1, [S2|T2]),
	S1 @=< S2,
	union(T1, [S2|T2],  Res).
union([S1|T1], [S2|T2], [S2|Res]) :-
	nonmember(S1, [S2|T2]),
	S2 @=< S1,
	union([S1|T1], T2,  Res).

% intersection(S1, S2, Res)
% Res is the intersection of the sets S1 and S2.
intersection(S1, S2, Res) :-
	qsort(S1, S1Sorted),
	inters(S1Sorted, S2, Res).
inters([], _, []).
inters([H1|S1],  S2, [H1|Res]) :-
	once(member(H1, S2)),
	inters(S1, S2, Res).
inters([H1|S1], S2, Res) :-
	nonmember(H1, S2),
	inters(S1, S2, Res).

% split(L, Pivot, L1, L2).
% L is splitted into L1 and L2.
% L1 contains all elements that is less than Pivot.
% L2 contains all elements that is higher than Pivot.
split([], _, [], []).
split([X1 | L], Pivot, [X1 | L1], L2) :-
	X1 @< Pivot,
	split(L, Pivot, L1, L2).
split([X1 | L], Pivot, L1, [X1 | L2]) :-
	X1 @>= Pivot,
	split(L, Pivot, L1, L2).

% qsort(L, LS).
% LS is the sorted list of L.
qsort([], []).
qsort([N | L], LS) :-
	split(L, N, Less, More),
	qsort(Less, L1),
	qsort(More, L2),
	append(L1,  [N | L2], LS).

% sublist(List, Sublist).
% Sublist is a sublist of List.
sublist([], []).
sublist([H1|T1], [H1|T2]) :-
	sublist(T1, T2).
sublist([_|T1], S2) :-
	sublist(T1, S2).

% powerset(S, Res).
% Res is the powerset of the set S.
powerset(S, Res) :-
	qsort(S, Sorted),
	findall(X, sublist(Sorted, X), Res).

/* Example queries for the program are listed below.

| ?- union([a,b,c], [a,b,c,d,e], Res).
Res = [a,b,c,d,e] ? ;
no
| ?- union([a,b,c,d,e,f,g,h,i,j], [a,b,c,d,e], Res).
Res = [a,b,c,d,e,f,g,h,i,j] ? ;
no
| ?- union([a,b,c,d,e,f,g,h,i,j], [b,c,d,e], Res).
Res = [a,b,c,d,e,f,g,h,i,j] ? ;
no
| ?- union([b,c,d,e,f,g,h,i,j], [b,c,d,e], Res).
Res = [b,c,d,e,f,g,h,i,j] ? ;
no
| ?- union([b,c,d,e], [b,c,d,e], Res).
Res = [b,c,d,e] ? ;
no
| ?- intersection([b,c,a], [b,a,c,d,e,f,g,h], Res).
Res = [a,b,c] ? ;
no
| ?- intersection([b,c,a], [b], Res).
Res = [b] ? ;
no
| ?- intersection([b,c,a], [a,f,g,h,a,b,c,i], Res).
Res = [a,b,c] ? ;
no
| ?- intersection([a,b,c,e,h], [a,b,c,d,e,f,g,h], Res).
Res = [a,b,c,e,h] ? ;
no
| ?- intersection([a], [a,b,c,d,e,f,g,h], Res).
Res = [a] ? ;
no
| ?- intersection([], [a,b,c,d,e,f,g,h], Res).
Res = [] ? ;
no
| ?- intersection([b,c,a], [a,f,g,h,a,b,c,i,c,c,c,c,c,c,c], Res).
Res = [a,b,c] ? ;
no
| ?- powerset([b,a,c], Res).
Res = [[a,b,c],[a,b],[a,c],[a],[b,c],[b],[c],[]] ? ;
no
| ?- powerset([b,a], Res).
Res = [[a,b],[a],[b],[]] ? ;
no
| ?- powerset([a,a], Res).
Res = [[a,a],[a],[a],[]] ? ;
no
| ?- powerset([a,b,c], Res).
Res = [[a,b,c],[a,b],[a,c],[a],[b,c],[b],[c],[]] ? ;
no

*/




