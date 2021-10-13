#include <iostream>
#include <string>
#include <vector>
#include "owner.h"

using namespace std;

Owner::Owner()
{
}

Owner::Owner(const string &name, float balance)
{
    this->name = name;
    this->balance = balance;
}

void Owner::print_info()
{
}

string &Owner::get_name()
{
    return name;
}

void Owner::add_property(Property *property)
{
    properties.push_back(property);
}

void Owner::buy(Property *property, Owner *seller)
{
    float value = property->valuate();

    cout << "[BUY] Property: " << property->get_name() << " Value: " << value << "$ " << seller->get_name() << "--->" << name << endl;

    if(balance < value){
        cout << "[ERROR] Unaffordable  property" << endl;
        return;
    }
    
    bool found = false;

    for(int i=0; i< seller->properties.size(); i++){
        if(property == seller->properties[i]){
            found = true;
            seller->properties[i] = NULL;
            break;
        }
    }

    if (!found)
    {
        cout << "[ERROR] Transaction  on  unowned  property" << endl;
        return;
    }
    
    balance -= value;
    seller->balance += value;
    this->add_property(property);
    property->set_owner(this);

}

void Owner::sell(Property *property, Owner *owner)
{
    float value = property->valuate();
    cout << "[SELL] Property: " << property->get_name() << " Value: " << value << "$ " << name << "--->" << owner->get_name() << endl;

    if(owner->balance < value){
        cout << "[ERROR] Unaffordable  property" << endl;
        return;
    }
    
    bool found = false;

    for(int i=0; i< properties.size(); i++){
        if(property == properties[i]){
            found = true;
            properties[i]=NULL;
            break;
        }
    }

    if (!found)
    {
        cout << "[ERROR] Transaction  on  unowned  property" << endl;
        return;
    }

    balance += value;
    owner->balance -= value;
    owner->add_property(property);
    property->set_owner(owner);
}

void Owner::list_properties()
{
    cout << "Properties of " << name << ":" << endl;
    cout << "Balance: " << balance << "$" << endl;

    for(int i=0; i< properties.size(); i++){
        cout << i+1 << ". " << properties[i]->get_name() << endl;
    }
}