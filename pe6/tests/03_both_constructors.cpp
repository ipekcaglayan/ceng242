#include <iostream>
#include "../person.h"
#include "../corporation.h"
#include "../villa.h"
#include "../apartment.h"

using namespace std;

int main()
{
    Person per = Person("Ahmet", 5000, 35);
    Corporation corp = Corporation("ACME", 5000, "cankaya");

    Villa est1 = Villa("Villa 1", 150, &per, 2, false);
    Apartment est2 = Apartment("Apartment 1", 200, NULL, 7, true);

    per.print_info();
    corp.print_info();
    est1.print_info();
    est2.print_info();

    return 0;
}
