#!/usr/bin/env bash
rm *.txt
rm -r .hg
echo "hello foo" > foo.txt
echo "hello bar" > bar.txt
# test create
./lhs init

# test add
./lhs add foo.txt bar.txt

# test commit
./lhs commit

# update file and commit
echo "world" >> foo.txt
./lhs add foo.txt
./lhs commit

# test cat
./lhs cat foo.txt 0

# test cat
./lhs cat foo.txt 1

# test diff
./lhs diff 0 1 foo.txt

# test heads
./lhs heads


# test delete
./lhs delete foo.txt
./lhs commit

# test log
./lhs log



echo "new" >> foo.txt
# test stat
./lhs stat

# test merge
./lhs merge ../other

# test checkout
./lhs checkout 0

# test clone
./lhs clone ../clone
./lhs clone ../clone

# # test checkout
# ./lhs checkout 0