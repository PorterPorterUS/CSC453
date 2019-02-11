# Beta Testing: Part 2

* Name: Lisa Jin (ljin14)
* Group: 6

## Requirements
### `init`
  * OK

### `add`
  * OK
  
### `delete`
  * ERR: Adding and then deleting a file before commit should result in no change. Command sequence: `mkdir baz && cd baz && lhs init && echo "test" > f2.txt && lhs add f2.txt && lhs delete f2.txt`. Below is the output of `lhs log` after these commands are run.
  ```bash
  0: -1 -1 0b524c059c25692af64eec61eb37999268800798
  manifest nodeid: 
  User: ljin14@cycle2.cs.rochester.edu
  changed files: 
  f2.txt
  description: commit
  ```
### `clone`
  * OK

### `stat`
  * ERR: Executing on a repository with no tracked files causes the following error message.
  ```bash
  Traceback (most recent call last):
          4: from /u/ljin14/Documents/453/g4_dvcs/group_four/DVCS_lhs/lhs:71:in `<main>'
          3: from /u/ljin14/Documents/453/g4_dvcs/group_four/DVCS_lhs/repository.rb:173:in `diffdir'
          2: from /u/ljin14/Documents/453/g4_dvcs/group_four/DVCS_lhs/repository.rb:64:in `open'
          1: from /u/ljin14/Documents/453/g4_dvcs/group_four/DVCS_lhs/repository.rb:64:in `open'
  /u/ljin14/Documents/453/g4_dvcs/group_four/DVCS_lhs/repository.rb:64:in `initialize': No such file or directory @ rb_sysopen -
  /home/vax9/u18/ljin14/Documents/453/g4_dvcs/group_four/DVCS_lhs/foo/.hg/dircache (Errno::ENOENT)
  ```
  * ERR: After merging one repo into another, the same error as the one above appears. Below are the commands that were run.
  ```bash
  mkdir foo && cd foo && lhs init && echo "test" > f1.txt && lhs add && lhs commit
  cd ..
  mkdir bar && cd bar && lhs init && echo "test2" > f1.txt && lhs add && lhs commit
  lhs merge ../foo
  lhs stat
  ```

### `heads`
  * OK

### `diff`
  * ERR: After merging one repo into another (see second bullet of `stat` section above), the below error appears.
  ```bash
  Traceback (most recent call last):
          4: from /u/ljin14/Documents/453/g4_dvcs/group_four/DVCS_lhs/lhs:78:in `<main>'
          3: from /u/ljin14/Documents/453/g4_dvcs/group_four/DVCS_lhs/repository.rb:266:in `diff'
          2: from /u/ljin14/Documents/453/g4_dvcs/group_four/DVCS_lhs/changelog.rb:42:in `changeset'
          1: from /u/ljin14/Documents/453/g4_dvcs/group_four/DVCS_lhs/revlog.rb:170:in `revision'
  /u/ljin14/Documents/453/g4_dvcs/group_four/DVCS_lhs/revlog.rb:72:in `base': undefined method `[]' for nil:NilClass (NoMethodError)
  ```

### `checkout`
  * ERR: Directory does not revert to previous commit. I ran the following in an initialized repo and `f3.txt` was still in the working directory afterwards.
  ```bash
  echo "test" > f2.txt
  lhs add f2.txt && lhs commit
  echo "test2" > f3.txt
  lhs add f3.txt && lhs commit
  lhs checkout <f2_add_rev>
  ```

### `cat`
  * ERR: The following error appears after trying to display file contents of previous commit whewe the file was added.
  ```bash
  Traceback (most recent call last):
        3: from /u/ljin14/Documents/453/g4_dvcs/group_four/DVCS_lhs/lhs:74:in `<main>'
        2: from /u/ljin14/Documents/453/g4_dvcs/group_four/DVCS_lhs/repository.rb:288:in `cat'
        1: from /u/ljin14/Documents/453/g4_dvcs/group_four/DVCS_lhs/revlog.rb:170:in `revision'
  /u/ljin14/Documents/453/g4_dvcs/group_four/DVCS_lhs/revlog.rb:72:in `base': no implicit conversion from nil to integer (TypeError)
  ```

### `commit`
  * OK

### `log`
  * OK

### `merge`
  * OK
