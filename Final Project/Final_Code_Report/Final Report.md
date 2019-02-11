# Debug report of Group 4

## Bugs reported by Group 3

- **Bug 1**:  `lhs init`  failed. (if the repo already exists, this command will fail.)

  **Diagnose**: The problem exists in repository.initialize(). When the .hg directory has existed, we still make a .hg directory.

  **Solution: ** We check whether .hg has existed in the repository folder. If .hg has already existed, we will output an error:

  "[Error]! The repository has already existed in this directory!"

  The code is modified as follows:

  ```ruby
  if File.exist? @path
     puts "[Error]! The repository already exists in this directory!"
     exit
  end
  ```

- **Bug 2**:` lhs add Test2.txt`   failed. (If the file does not exist, this command will fail.)

  **Diagnose**: Any nonexistent file cannot be added.

  **Solution: ** We check whether the file has existed in the repository folder. If the file does not exist, we will output an error:

  "[Error!] Added file does not exist!"

  The code is modified as follows:

  ```ruby
  if !File.file?(f)
      puts "[Error!] Added file does not exist!"
      exit
  end
  ```



## Bugs reported by Group 5

- **Bug 1**: 

- ```bash
  mkdir g4_test
  lhs init
  lhs stat
  ```

  Error message:        

  ```shell
  /Users/tianqiyang/Documents/csc453/CSC453_group_four_test/group_four/DVCS_lhs/repository.rb:64:in `initialize': No such file or directory @ rb_sysopen - /Users/tianqiyang/Documents/csc453/g4_test/.hg/dircache (Errno::ENOENT)
  ```

  **Diagnose**: "stat" operation will open .hg/dircache file. However, such file is created only after commit. So at the time when the repository is just initialized, such file has not been created.

  **Solution**: We check if the dircache file exists in .hg folder. If not, we will report error:

  "Please firstly add file into stage then execute stat operation."

  And the code is modified as follows:

  ```ruby
  if !File.file?(self.join("dircache"))
      puts "Please firstly add file into stage then excute stat operation."
      return
  end
  ```

- **Bug 2**: 

  ```shell
  mkdir g4_test
  lhs init
  lhs heads
  ```

  Error message:  

  ```shell
  /Users/tianqiyang/Documents/csc453/CSC453_group_four_test/group_four/DVCS_lhs/changelog.rb:30:in `extract': undefined method `[]' for nil:NilClass (NoMethodError)
  ```

  **Diagnose**:  We need to commit and then we can call heads.

  **Solution**: We check current revision id, and when revision id is less then 0, we will report an error:

  "Please firstly add file into stage then execute heads operation."

  The code is modified as follows:

  ```ruby
  i = repo.changelog.tip
  if i < 0
      puts "Please firstly add file into stage then execute heads operation."
      return
  end
  ```

- **Bug 3**: ` lhs commit` fails after `lhs add`. 

  **Diagnose**: The "add" operation only supports file name as input, and the input can be one file name or multiple file names. However, `.` is an regular expression to match all files in the current directory, which is not supported by our system.

  **Solution**: We check if the file names provided are valid. If not, we will report an error:

  "[Error!] Added file does not exist!"

  The code is modified as follows:

  ```ruby
  args.each do |f|
      if !File.file?(f)
          puts "[Error!] Added file does not exist!"
          exit
      end
  end
  ```



## Bugs reported by Group 6

- **Bug 1**: 

  ```shell
  lhs init
  lhs add f2.txt
  lhs delete f2.txt
  lhs commit
  lhs log
  ```

  The `log` is expected to show no change, but in practice `log` shows one change as follows:

  ```shell
  0: -1 -1 0b524c059c25692af64eec61eb37999268800798
  manifest nodeid:
  User: ljin14@cycle2.cs.rochester.edu
  changed files:
  f2.txt
  description: commit
  ```

  **Diagnose**: Although add and then delete a file seem to have no change, in our system we record operation history of all files, and we regard a file as modified as long as the user enforces an operation on the file, regardless of whether the file has really been changed or not.

  **Solution**: We keep our code the same as before.

- **Bug 2**: 

  ```shell
  lhs init
  lhs stat
  ```

  Error message

  ```shell
  Traceback (most recent call last):
      4: from /u/ljin14/Documents/453/g4_dvcs/group_four/DVCS_lhs/lhs:71:in `<main>'
      3: from /u/ljin14/Documents/453/g4_dvcs/group_four/DVCS_lhs/repository.rb:173:in `diffdir'
      2: from /u/ljin14/Documents/453/g4_dvcs/group_four/DVCS_lhs/repository.rb:64:in `open'
      1: from /u/ljin14/Documents/453/g4_dvcs/group_four/DVCS_lhs/repository.rb:64:in `open'
  /u/ljin14/Documents/453/g4_dvcs/group_four/DVCS_lhs/repository.rb:64:in `initialize': No such file or directory @ rb_sysopen -
  /home/vax9/u18/ljin14/Documents/453/g4_dvcs/group_four/DVCS_lhs/foo/.hg/dircache (Errno::ENOENT)
  ```

  **Diagnose & Solution** : This bug has been fixed in the bug 1 reported by Group 5.

- **Bug 3**: After merging one repository into another,  `diff` , `stat` and `cat` will raise an error.

  **Diagnose**: The code for merge has two bugs:

  - The scope of a variable is falsely comprehended.
  - The syntax of sending a function as an argument of another function.

  **Solution**: Further debug the code for merge.

- **Bug 4**: 

  \### `checkout` ###

  ERR: Directory does not revert to previous commit. I ran the following in an initialized repo and `f3.txt` was still in the working directory afterwards.

  ```shell
  echo "test" > f2.txt
  lhs add f2.txt && lhs commit
  echo "test2" > f3.txt
  lhs add f3.txt && lhs commit
  lhs checkout <f2_add_rev>
  ```

  **Diagnose**: The checkout function in our system does not support roll back of working directory.

  **Solution**: We remain our code the same.
