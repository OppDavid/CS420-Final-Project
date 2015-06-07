tests: 
	minigrace utilsTest.grace 
	minigrace zipTest.grace
	minigrace equivalancesTest.grace
	minigrace logicTest.grace

clean:
	rm -fR *.c *.gcn *.gct logic logicTest utils utilsTest zip zipTest 
