#include <iostream>
#include "../person.h"
#include "../corporation.h"
#include "../villa.h"
#include "../apartment.h"
#include "../office.h"

using namespace std;

int main()
{
    Person per = Person("Ahmet", 300, 35);
    Corporation corp = Corporation("ACME", 5000, "cankaya");

    Villa est1 = Villa("Villa 1", 150, &per, 2, false);
    Apartment est2 = Apartment("Apartment 1", 200, &corp, 7, true);
    Office est3 = Office("Office 1", 500, &corp, false, true);

    per.list_properties();
    corp.list_properties();

    cout << "-----------------------------------\n";

    per.buy(&est2, &corp);
    corp.sell(&est3, &per);

    cout << "-----------------------------------\n";

    per.list_properties();
    corp.list_properties();

    return 0;
}