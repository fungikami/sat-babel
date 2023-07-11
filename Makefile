all: sat-planner/bin/glucose sat-planner/bin/glucose-syrup

sat-planner/bin/glucose: glucose/simp/Makefile
	cd glucose/simp && make glucose
	cd ../..
	mv glucose/simp/glucose sat-planner/bin/glucose

sat-planner/bin/glucose-syrup: glucose/parallel/Makefile
	cd glucose/parallel && make glucose-syrup
	cd ../..
	mv glucose/parallel/glucose-syrup sat-planner/bin/glucose-syrup

clean:
	rm -rf sat-planner/bin/glucose sat-planner/bin/glucose-syrup