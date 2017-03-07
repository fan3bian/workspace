#/bin/bash
cd ~ # cd home directory of current user
mkdir shell_zhang
cd shell_zhang

for (( i = 0; i < 10; i++ )); do
	#statements
	touch test_$i.txt
done