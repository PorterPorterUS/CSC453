#Bug report of DVCS group 4

- Under a empty repo without adding or committing anything, `lhs stat` and `lhs heads` will fail.

  - Test case:

    ```shell
    mkdir g4_test
    lhs init
    lhs stat
    ```

    Error message:

    ```shell
    /Users/tianqiyang/Documents/csc453/CSC453_group_four_test/group_four/DVCS_lhs/repository.rb:64:in `initialize': No such file or directory @ rb_sysopen - /Users/tianqiyang/Documents/csc453/g4_test/.hg/dircache (Errno::ENOENT)
    ```

  - Test case:

    ```shell
    mkdir g4_test
    lhs init
    lhs heads
    ```

    Error message:

    ```shell
    /Users/tianqiyang/Documents/csc453/CSC453_group_four_test/group_four/DVCS_lhs/changelog.rb:30:in `extract': undefined method `[]' for nil:NilClass (NoMethodError)
    ```

- `lhs commit`  fails after `lhs add .` . And all commit fails after this.

  - Test case

    ```shell
    lhs add .
    lhs commit
    ```

    Error message

    ```shell
    /Users/tianqiyang/Documents/csc453/CSC453_group_four_test/group_four/DVCS_lhs/repository.rb:100:in `read': No such file or directory @ rb_sysopen - c.txt (Errno::ENOENT)
    ```

