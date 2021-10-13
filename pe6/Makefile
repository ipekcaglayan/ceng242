main:
	g++ -ansi -pedantic main.cpp owner.cpp person.cpp corporation.cpp villa.cpp apartment.cpp office.cpp property.cpp -o m
test:
	g++ -ansi -pedantic $(test) owner.cpp person.cpp corporation.cpp villa.cpp apartment.cpp office.cpp property.cpp -o tst
run_main:
	./m
run_test:
	./tst
run_test_to_file:
	g++ -ansi -pedantic ./tests/$(test).cpp owner.cpp person.cpp corporation.cpp villa.cpp apartment.cpp office.cpp property.cpp -o tst
	./tst > ./outs/$(test).out
clean:
	rm -rf ./tst ./m
