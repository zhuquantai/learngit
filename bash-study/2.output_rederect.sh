关于输入、输出和错误输出

在字符终端环境中，标准输入/标准输出的概念很好理解。输入即指对一个应用程序 或命令的输入，无论是从键盘输入还是从别的文件输入；输出即指应用程序或命令产生的一些信息；与 Windows 系统下不同的是，Linux 系统下还有一个标准错误输出的概念，这个概念主要是为程序调试和系统维护目的而设置的，错误输出于标准输出分开可以让一些高级的错误信息不干扰正常的输出 信息，从而方便一般用户的使用。

在 Linux 系统中：标准输入(stdin)默认为键盘输入；标准输出(stdout)默认为屏幕输出；标准错误输出(stderr)默认也是输出到屏幕（上面的 std 表示 standard）。在 BASH 中使用这些概念时一般将标准输出表示为 1，将标准错误输出表示为 2。下面我们举例来说明如何使用他们，特别是标准输出和标准错误输出。

输入、输出及标准错误输出主要用于 I/O 的重定向，就是说需要改变他们的默认设置。先看这个例子：

$ ls > ls_result
$ ls -l >> ls_result

上面这两个命令分别将 ls 命令的结果输出重定向到 ls_result 文件中和追加到 ls_result 文件中，而不是输出到屏幕上。">"就是输出（标准输出和标准错误输出）重定向的代表符号，连续两个 ">" 符号，即 ">>" 则表示不清除原来的而追加输出。下面再来看一个稍微复杂的例子：

$ find /home -name lost* 2> err_result

这个命令在 ">" 符号之前多了一个 "2"，"2>" 表示将标准错误输出重定向。由于 /home 目录下有些目录由于权限限制不能访问，因此会产生一些标准错误输出被存放在 err_result 文件中。大家可以设想一下 find /home -name lost* 2>>err_result 命令会产生什么结果？

如果直接执行 find /home -name lost* > all_result ，其结果是只有标准输出被存入 all_result 文件中，要想让标准错误输出和标准输入一样都被存入到文件中，那该怎么办呢？看下面这个例子：

$ find /home -name lost* > all_result 2>& 1

上面这个例子中将首先将标准错误输出也重定向到标准输出中，再将标准输出重定向到 all_result 这个文件中。这样我们就可以将所有的输出都存储到文件中了。为实现上述功能，还有一种简便的写法如下：

$ find /home -name lost* >& all_result



如果那些出错信息并不重要，下面这个命令可以让你避开众多无用出错信息的干扰：

$ find /home -name lost* 2> /dev/null

同学们回去后还可以再试验一下如下几种重定向方式，看看会出什么结果，为什么？

$ find /home -name lost* > all_result 1>& 2 
$ find /home -name lost* 2> all_result 1>& 2
$ find /home -name lost* 2>& 1 > all_result
