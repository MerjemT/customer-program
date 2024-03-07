
customer(dave).
customer(mike).
customer(miley).
customer(claire).

product(towel, 20).
product(shampoo, 50).
product(soap, 30).
product(toothbrush, 20).
:-dynamic stock/2.
stock(towel, 100).
stock(shampoo, 100).
stock(soap, 100).
stock(toothbrush, 100).

stock_report :-
    stock(Product, Quantity),
    write(Product),tab(2), write(Quantity), nl, fail.

should_reorder(Product) :-
    stock(Product, Quantity),
    product(Product, Critical_level),
    Quantity =< Critical_level,
    write('You have to reorder '), write(Product), nl.

should_reorder(Product) :-
    stock(Product, Quantity),
    product(Product, Critical_level),
    Quantity > Critical_level,
    write('Stock status for '), write(Product), write(' is good now, no need to reorder'), nl.

reorder(Product, Quantity) :-
    retract(stock(Product, OQuantity)),NewQuantity is OQuantity + Quantity,
    assert(stock(Product, NewQuantity)),write(Product), write(' has been ordered and there are '), write(NewQuantity), write(' '), write(Product), write(' in stock.'), nl.

order :-
    write('Customer name: '),read(Customer),
    write('Product name: '),read(Product),
    write('Quantity: '),read(Quantity),
    ( stock(Product, SQuantity),
      SQuantity >= Quantity ->
        retract(stock(Product, OSQuantity)),
        NSQuantity is OSQuantity - Quantity,
        assert(stock(Product, NSQuantity)),
        write(Customer), write(' has ordered '), write(Quantity), write(' '), write(Product), write('s.'), nl,
        should_reorder(Product)
    ; write('Not enough items of '), write(Product), write(' in stock.'), nl ).

