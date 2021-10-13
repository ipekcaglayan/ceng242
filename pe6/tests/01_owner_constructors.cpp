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

    per.print_info();
    corp.print_info();

    return 0;
}
