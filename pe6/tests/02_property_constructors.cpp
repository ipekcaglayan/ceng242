#include <iostream>
#include "../person.h"
#include "../corporation.h"
#include "../villa.h"
#include "../apartment.h"
#include "../office.h"

using namespace std;

int main()
{

    Villa est1 = Villa("Villa 1", 150, NULL, 2, false);
    Apartment est2 = Apartment("Apartment 1", 200, NULL, 7, true);
    Office est3 = Office("Office 1", 500, NULL, false, false);

    cout << "est1: " << est1.get_name() << "\n";
    cout << "est2: " << est2.get_name() << "\n";
    cout << "est3: " << est3.get_name() << "\n";

    return 0;
}
