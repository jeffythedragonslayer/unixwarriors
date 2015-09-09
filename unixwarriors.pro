:- dynamic
        location/1,
        inparty/1,
        hasobject/1,
        drunk/0,
        elevatorworks/0,
        boatworks/0.

location(bar).

path(bar, s, street).
path(street, n, bar).
path(street, w, road).
path(street, e, building).  
path(street, s, townsquare).
path(arcade, n, townsquare).
path(townsquare, s, arcade).
path(townsquare, n, street).
path(townsquare, w, shop).
path(shop, e, townsquare).
path(road, w, cave).
path(road, e, street).
path(road, n, seashore).
path(road, s, meadow).
path(meadow, n, road).
path(seashore, s, road).
path(cave, e, road).
path(building, s, restaurant).
path(building, w, street).
path(building, u, penthouse).
path(penthouse, d, building).
path(restaurant, n, building).
path(manhole, u, street).

warriorat(vivian, island).
warriorat(ed, meadow).
warriorat(mac, arcade).
warriorat(kate, restaurant).

objectat(beer, bar).
objectat(manpages, cave).
objectat(sail, shop).
objectat(potion, shop).
objectat(money, arcade).
objectat(pizza, manhole).

talk :-
        location(L),
        warriorat(W, L),
        joinparty(W).

talk :-
        location(L),
        not(warriorat(_, L)),
        write('There is no one here to talk to.'), nl.

joinparty(W) :-
        location(L),
        warriorat(W, L),
        not(inparty(W)),
        assert(inparty(W)),
        write(W),
        write(' joined your party!'), nl.

win_game :-
        write('you win!'), nl.

look :-
        location(Place),
        describe(Place),
        noticepeople(Place),
        noticeobject(Place),
        nl.

noticepeople(L) :-
        location(L),
        warriorat(W, L),
        not(inparty(W)),
        write(W),
        write(' is here.'), nl, !.

noticepeople(_).

noticeobject(L) :-
        location(L),
        objectat(O, L),
        not(hasobject(O)),
        write('You notice a '),
        write(O),
        write('.'), nl.

noticeobject(_).

take(sail) :-
        location(shop),
        not(hasobject(sail)),
        not(hasobject(money)),
        write('You need money to buy that.'), nl.

take(sail) :-
        location(shop),
        not(hasobject(sail)),
        hasobject(money),
        retract(hasobject(money)),
        assert(hasobject(sail)),
        write('You buy the sail.'), nl.

take(O) :-
        location(L),
        objectat(O, L),
        not(hasobject(O)), 
        assert(hasobject(O)),
        write('You take the '), write(O), write('.'), nl.

take(_) :-
        write('You can''t take that.').

describe(island) :-
        write('You are on an island surrounded by water everywhere.'), nl,
        write('You see the C-shore to the south.'), nl.

describe(bar) :-
        write('You are in a bar.  A piano is in the corner.  The exit is to the south'), nl.

describe(manhole) :-
        write('You are in underground in the dark sewers.'), nl,
        write('Broken pipes surround you.'), nl,
        write('You see a ladder to the surface.'), nl.

describe(street) :-
        write('You are in a busy street.  There is a bar to the north,'), nl,
        write('a dirt road to the west, and a building to the east.'), nl,
        write('Across the street to the south is town square.'), nl.

describe(townsquare) :-
        write('You are in a bustling town square.  A street is to the north.'), nl,
        write('A brightly lit shop is to the west.  A noisy arcade is to the south.'), nl.

describe(road) :-
        write('You are on a quiet dirt road.  There is a busy street to the east.'), nl,
        write('There is a dark cave to the west.'), nl.

describe(cave) :-
        write('You are in a dark, damp cave.  The exit is to the east.'), nl.

describe(building) :-
        write('You are in a building.  The street is to the west.'), nl,
        write('A restaurant is to the south.  An elevator is going up').

describe(restaurant) :-
        write('You are at the restaurant.  The building is to the north.'), nl.

describe(penthouse) :-
        write('You reached the penthouse of the apartment.'), nl,
        write('An elevator is going down.'), nl,
        write('Slashbang is inside'), nl.

describe(seashore) :-
        write('You are at the C-shore.  It is decorated by colorful shells.'), nl,
        write('There is a small island to the north'), nl,
        write('There is a dirt road to the south.  You see a broken down boat.'), nl.

describe(arcade) :-
        write('You are at the arcade.  The exit is to the north'), nl.

describe(meadow) :-
        write('You are in a meadow.  There is a dirt road to the north.'), nl.

describe(shop) :-
        write('You are in the shop.  The exit is east.'), nl.


use(manpages) :-
        location(building),
        hasobject(manpages), 
        inparty(kate),
        not(elevatorworks),
        assert(elevatorworks),
        write('With the ancient knowledge in the manpages, Kate edits the elevator.'), nl,
        write('A light indicating the current floor turns on.'), nl.

use(sail) :-
        location(seashore),
        hasobject(sail), 
        inparty(ed),
        not(boatworks),
        assert(boatworks),
        retract(hasobject(sail)),
        write('Ed repairs the boat with the sail.'), nl.

use(boat) :-
        location(seashore),
        boatworks,
        retract(location(seashore)),
        assert(location(island)),
        write('You climb aboard the boat and sail to the island.'), nl.

use(boat) :-
        location(island),
        boatworks,
        retract(location(island)),
        assert(location(seashore)),
        write('You climb aboard the boat and sail to the C-shore.'), nl.

use(manpages) :-
        write('You can''t use that here.'), nl.


attack(slashbang) :-
        inparty(vivian),
        inparty(kate),
        inparty(ed),
        inparty(mac),
        write('The Unix Warriors combine their strength,'), nl,
        write('Mac casts a sudo spell and gains root access to nearby electronic devices.'), nl,
        write('Slashbang notices his phone is not responding, and tries to run.'), nl,
        write('Vivian mutters a suspend spell and he trips in his esacpe.'), nl,
        write('You apprehend the infamous hacker.'), nl,
        write('Kate logs into Deep Purple and deactivates the malcious programs'),
        write('subjugating the city.'), nl,
        write('YOU WIN!!!!'), nl.

attack(slashbang) :-
        write('After attacking Slashbang outnumbered, he mutters'), nl,
        write('the name of an obscure shell script into his cell phone.'), nl,
        write('The incantation summons a muscular demon into the room,'), nl,
        write('which punches you out the window.'), nl,
        write('You are now back at the bar.'), nl, 
        retract(location(penthouse)),
        assert(location(bar)),
        nl.

attack(_) :-
        write('You can''t attack that.'), nl.  

n :- not(drunk), go(n).
n :-
        drunk,
        location(street),
        not(hasobject(pizza)),
        retract(location(street)),
        assert(location(manhole)),
        write('You fall and stumble down a manhole cover.'), nl,
        look.
n :- drunk, go(s).

s :- not(drunk), go(s).
s :-
        drunk,
        location(street),
        not(hasobject(pizza)),
        retract(location(street)),
        assert(location(manhole)),
        write('You fall and stumble down a manhole cover.'), nl,
        look.
s :- drunk, go(n).

e :- not(drunk), go(e).
e :-
        drunk,
        location(street),
        not(hasobject(pizza)),
        retract(location(street)),
        assert(location(manhole)),
        write('You fall and stumble down a manhole cover.'), nl,
        look.
e :- drunk, go(w).

w :- not(drunk), go(w).
w :-
        drunk,
        location(street),
        not(hasobject(pizza)),
        retract(location(street)),
        assert(location(manhole)),
        write('You fall and stumble down a manhole cover.'), nl,
        look.
w :- drunk, go(e).

u :- not(drunk), go(u).
u :-
        drunk,
        location(street),
        not(hasobject(pizza)),
        retract(location(street)),
        assert(location(manhole)),
        write('You fall and stumble down a manhole cover.'), nl,
        look.
u :- drunk, go(d).

d :- not(drunk), go(d).
d :-
        drunk,
        location(street),
        not(hasobject(pizza)),
        retract(location(street)),
        assert(location(manhole)),
        write('You fall and stumble down a manhole cover.'), nl,
        look.
d :- drunk, go(u).  

go(n) :-
        location(seashore),
        write('The waves crash and pull you back to shore.'), nl.

go(u) :-
        location(building),
        not(elevatorworks),
        write('Unfortunately the elevator is broken.  You need a magic incantation to fix it.'), nl.

go(Direction) :-
        location(Here),
        path(Here, Direction, There),
        retract(location(Here)),
        assert(location(There)),
        look.

go(_) :- 
        write('You can''t go that way.'), nl.

drink(beer) :-
        hasobject(beer),
        retract(hasobject(beer)),
        assert(drunk),
        write('You are now drunk.'), nl.

drink(potion) :-
        hasobject(potion),
        retract(hasobject(potion)),
        retract(drunk),
        write('You drink the potion and sober up.'), nl.

instructions :-
        nl,
        write('Enter commands in prolog syntax.'), nl,
        write('Available commands:'), nl,
        write('start.'), nl,
        write('n. s. e. w.'), nl,
        write('attack(X).'), nl,
        write('look.'), nl,
        write('read(X).'), nl,
        write('talk.'), nl,
        write('drink(X).'), nl,
        write('give(X).'), nl,
        write('take(X)'), nl,
        write('instructions.'), nl.

start :-
        write('Welcome to Quantum Copenhagen!'), nl,
        write('It is world''s most advanced city, both technologically and culturally.'), nl,
        write('Full of hackers, engineers, musicians, artists, and writers'), nl,
        write('living harmoniously together.  At least it was, until'), nl,
        write('recently a black sudoer who goes by the handle /! (otherwise known as Slashbang),'), nl,
        write('gained control of the city''s supercomputer Deep Purple and'), nl,
        write('and is using its quantum computing abilities to summon demons'), nl,
        write('which run have run amok in the city to do his nefarious bidding.'), nl,
        write('Your assignment is to assemble the four other top level sudoers in the city,'), nl,
        write('known as the Unix Warriors,'), nl,
        write('and using the secret magic stored in a scared book called the Man Pages'), nl,
        write('and defeat the evil hacker Slashbang'), nl,
        instructions,
        look.

%game :-
%        repeat,
%        write('> '),
%        read(X),
%        call(X),
%        game.
