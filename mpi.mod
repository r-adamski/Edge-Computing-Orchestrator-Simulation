param m, integer, > 0;        /* ilosc serwerow */
param n, integer, > 0;        /* ilosc userow */

set I := 1..m;    /* set serwerow */
set J := 1..n;    /* set userow – każdy user korzysta z jednej instancji tej samej apki */ 


param a, integer >= 0;      /* ile zasobow zabiera vmka/user - 1 apka wiec zawsze tyle samo */
param b{i in I}, >= 0;        /* zasoby serwera i */
param c, integer >= 0;           /* koszt operacji alokacji vmki do serwera - 1 apka wiec zawsze to samo */
param cc, integer >= 0;           /* koszt transmisji - odleglosc usera od serwera * ta wartosc  */

param e{i in I, j in J};  /* odległość użytkownika j od serwera i w chwili T0 */
param ee{i in I, j in J};  /* odległość użytkownika  j od serwera i w chwili T1 */
param eee{i in I, j in J}; /* odległość użytkownika j serwera i w chwili T2 */

/* szukane */

var x{i in I, j in J}, binary;      /* xi,j] = 1 oznacza że user j korzysta z serwera i */


/* ograniczenia */

s.t. one{j in J}: sum{i in I} x[i,j] = 1;       /* user j musi byc przypisany dokladnie do jednego serwera */

s.t. lim{i in I}: sum{j in J} a * x[i,j] <= b[i];      /* ilosc zasosobow zabieranych przez wszystkie instancje apki nie moze przekroczyc zasosob serwera */



/* funkcja celu */


minimize obj: sum{i in I, j in J} x[i,j] * (c + cc * e[i, j] + cc * ee[i, j] + cc * eee[i, j]); /* znalezienie 'najtanszego' przyporzadkowania userow do serwerow */



/* print rozwiazania */

solve;

printf "\n";
printf "Wynik symulacji - tablica x \n";

printf{i in I, j in J}: "Serwer %d - user %d : %d\n", i, j, x[i,j];


/* dane wejsciowe */

data;

param m := 10;
param n := 20;

param a := 20;

param b :=
      1 100
      2 200
      3 100
      4 40
      5 20
      6 60
      7 40
      8 60
      9 40
      10 40;

param c := 40;
param cc := 10;

param e :  1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 :=
      1 74 50 53 90 16 90 70 45 56 95 91 28 38 77 110 75 117 93 57 71
      2 64 36 39 80 14 76 60 34 46 81 77 19 28 66 96 63 103 83 49 57
      3 56 24 26 72 23 62 50 25 40 67 64 19 22 56 82 53 89 73 44 43
      4 51 15 16 66 35 48 44 22 38 53 51 28 25 47 68 44 75 65 44 29
      5 50 16 14 62 49 34 42 27 41 39 40 39 34 42 54 38 61 59 48 17
      6 52 26 23 62 62 20 44 37 48 25 30 52 45 42 40 37 47 56 55 9
      7 58 39 35 65 76 8 50 49 58 11 25 66 58 45 26 42 33 57 65 17
      8 67 52 49 70 90 10 60 62 69 6 27 79 71 53 15 50 20 61 76 29
      9 77 66 62 78 104 23 70 76 81 18 36 93 85 63 11 60 9 68 88 43
      10 88 80 76 88 118 37 82 89 94 32 47 107 98 74 20 72 13 77 100 57 ;


param ee :  1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 :=
      1 75 50 51 90 15 88 71 43 56 95 90 27 36 75 109 73 117 94 55 69
      2 64 36 38 80 13 76 58 34 44 82 77 19 27 66 95 63 103 82 50 58
      3 56 22 26 73 24 60 49 26 39 65 62 18 20 55 83 53 87 71 42 42
      4 51 13 14 66 34 46 43 21 36 54 50 28 24 46 66 44 76 63 44 27
      5 48 15 13 61 48 33 42 28 39 39 41 38 34 43 54 36 61 58 46 18
      6 51 27 23 62 63 18 43 36 47 24 28 51 45 42 38 38 46 57 55 10
      7 59 37 35 63 74 7 51 50 59 11 23 66 57 45 24 42 31 55 63 16
      8 68 52 48 70 90 8 60 62 67 5 25 80 69 54 16 51 20 62 74 30
      9 75 66 60 78 105 23 69 76 81 16 34 93 86 61 11 59 10 69 89 41
      10 88 78 74 89 116 35 81 87 93 33 45 107 96 74 21 70 13 78 100 55 ;


param eee :  1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 :=
      1 77 49 52 88 13 91 68 46 57 95 87 24 37 75 105 74 119 90 57 72
      2 62 39 37 78 10 73 59 36 42 85 73 19 23 66 93 63 106 78 48 54
      3 56 19 28 71 26 58 51 27 37 63 58 21 22 57 86 50 87 71 42 43
      4 48 16 14 66 35 43 39 23 36 56 51 28 26 42 69 41 72 62 44 24
      5 48 17 16 62 46 31 44 27 39 41 42 34 30 39 51 36 64 60 47 18
      6 53 24 20 64 60 18 45 36 43 25 29 47 46 43 38 39 49 60 58 13
      7 56 33 38 64 77 8 54 46 59 9 25 67 54 41 27 39 28 57 59 18
      8 71 50 45 71 90 5 59 64 69 3 24 76 70 55 12 50 17 64 76 26
      9 73 68 58 78 103 19 65 78 84 14 34 89 87 57 7 61 10 72 92 42
      10 90 80 70 87 115 38 83 88 95 35 46 107 97 70 23 70 16 81 100 58 ;


end;
