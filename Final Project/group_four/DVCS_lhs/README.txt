lhs DVSC v1.0

Copyright: 2018 Fall, Fengxiang Lan, Jing Shi, Hao Huang

Environment: Mac OS 10.13; Ruby 2.5; Sublime & RubyMine

The goals of our DVCS are: 
	1. initialize/create a repository for the specific directory
	2. support the user by adding, deleting, commiting a file or a list of files
	3. support the commands like stat, log, which used to check and show the history
	4. user can check the content of specified file under specified version by using cat
	5. user can merge one repository into current repository
	6. user can clone the repository of one directory into other directory
	7. user also can check the difference between two different visions of the specific file

List of Important Files:
1. Revlog.rb: this is the basic of the whole system, which used to store the information of each revision, which include the content of files, finished times, relationship with other revisions and so on.
2. Manifest.rb: this is used to store information about history
3. Changelog.rb: this is used to store information about history
4. Filelog.rb: this is used to store information about history
5. Repository.rb: this is the top-level module of whole system, which used to provide the interface to users.
6. lhs: this is the enter of our DVCS, it can accpect the command from user, handle this command, and return the final result.


Sample usage:
1. You should down load the .zip of our DVCS
2. Unzip it and remember it location


Third-party libraries:
1. sudo gem install test-unit-full
2. sudo gem install diff-lcs


==========================================================================================================================================================================================
Please follow the following commands:


mkdir foo   								 * used to create a directory, *** BUT not in the source code folder ***
cd foo									     * go into foo

alias lhs="The full path of the location of DVCS" 

// like alias lhs="<dir>/group_four/DVCS_lhs/lhs"
// by this command you can use lhs in the future operation, it will be easy for you
// if you want to use this one, you can change the full path as it in your own position

lhs help									 * this will help you learn how to use our DVCS

lhs init                                     * create a repository in current directory

echo hello > Test1.txt					     * create a file and add "hello" into it

lhs add Test1.txt							 * add Test1.txt into current changeset
lhs commit   								 * commit files


echo world >> Test2.txt 
lhs add Test2.txt							 * add Test2.txt into current changeset
lhs commit   								 * commit files

lhs diff 0 1 Test1.txt 				         * show the difference of Test1.txt under two visions
// you should first enter the valid revision number then is the file you want to check

echo User >> Test1.txt
lhs cat Test1.txt 1							 * show the content of Text1.txt under revision 1
// You will see "hello" not "hellouser", because the revision 1 did not make any change for Text1.txt
// You should first enter the file name and then is the valid revision number

lhs delete Test1.txt						 * delete Test1.txt from current changeset
lhs commit 									 * commit files

lhs add Test1.txt						 	 * add Test1.txt from current changeset
lhs commit 									 * commit files

lhs cat Test1.txt 1							 * * show the content of Text1.txt under revision 1
// / You will see "hello", because the revision 1 store the old content of Text1.txt
lhs cat Test1.txt 3							 * * show the content of Text1.txt under revision 3
// / You will see "hellouser", because the revision 3 store the newest content of Text1.txt

lhs heads									 * show the changeset who don't have children

lhs log										 * show all the history information

lhs stat									 * show status of files

// prepare new directory
cd ..
mkdir new
cd foo

lhs clone "<dir>/new"  * clone the current repository to the given path, you should make sure this directory exists and 
											 * it does not have repository

lhs clone "<dir>/new"  * it already have a repository so will show the alert message

// prepare other directory
cd ..
mkdir other
cd other
lhs init
echo ruby >> t1.txt
lhs add t1.txt
lhs commit

cd ..
cd foo
lhs merge "<dir>/other"  * merge the given repository into current repository 
											   * show Begin merge changeset
													  Begin merge manifest
													  Begin resolve manifests
													  Committing merge changeset

lhs stat 									   * you will find "foo" already have the revision information from "other"


lhs checkout 0								   * check out to revision 0


CAUTIONS:
1. MAKE SURE YOU ENTER THE RIGHT FILE NAME.
2. MAKE SURE YOUR COMPUTER HAD ALREADY INSTALL THE RUBY.
3. WHEN YOU ENTER THE VISION NUMBER, MAKE SURE IT EXITS
4. WHEN YOU ENTER THE VISION NUMBER AND FILENAME, MAKE SURE UNDER THIS VISION NUMBER, YOU DID SOME OPERATION OF THIS FILE
5. MAKE SURE YOU ENTER THE RIGHT DIRECTORY NAME








