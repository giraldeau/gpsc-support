## Setup Python environment on the GPSC

These instructions applies to the ubuntu-18.04 image with the NRC profile loaded.

### Selecting the interpreter

There are multiple versions of Python available on the GPSC. 

 * Python from the Anaconda available with SSM is based on old Python 2.7 and therefore will not be used.
 * Python installed on the system: /usr/bin/python3 (version 3.6.9)
 * Python available as a module: module load python/3.7.4

We are using the default python3 in your PATH for the rest of the instructions. 

### Creating the environment

We create an empty Python environment in which the packages will be downloaded and installed. This environment is created in the home (or work) directory.

```
$ virtualenv -p python3 ~/work/pyenv-1
Already using interpreter /usr/bin/python3
Using base prefix '/usr'
New python executable in /home/frg001/work/pyenv-1/bin/python3
Also creating executable in /home/frg001/work/pyenv-1/bin/python
Installing setuptools, pkg_resources, pip, wheel...done.
```

This has to be done only once. The `virtualenv` command copies the python executable and the base libraries in the directory provided. The result is an independent python installation. To activate this environment, we source the following script:

```
source ~/work/pyenv-1/bin/activate
```

Activating the environment add the python installation in the PATH, meaning that the script has to be sourced for each new shell.

To quit the environment, simply execute `deactivate`.

### Installing packages using pip

Most Python packages are available from the official [Python Package Index](https://pypi.org/) using the `pip` command. It downloads the package and installs it inside the currently active environment's directory. Here is an example to install some popular scientific packages.


```
pip install numpy scipy sympy matplotlib pandas seaborn
```


Some large package (such as wxPython) require a large space to build. By default, `/tmp` is used and it is too small. Therefore, you should set the TMPDIR and create it before the installation.

```
mkdir $HOME/tmp
export TMPDIR=$HOME/tmp
pip install wxPython
```

### Saving the environment

To recreate the environment later, we now save all installed packages into a `requirements.txt` file. The name is only a convention, you can use any file name. 

If we start with an empty environment, or another person wants to get the same environment as you, this file can be used to recreate it easily. It is recommended to commit this file in a repository (i.e. git) for later use.

```
pip freeze > requirements.txt
```

Warning: there is actually a bug with the Ubuntu 18.04 Python. It will output the package `pkg-resources=0.0.0`, which does not exists. Delete this line, otherwise pip will fail to install this non-existent package.

To install all packages listed in the file, use the following command. Once the commands return, the environment is ready.

```
# setup TMPDIR if installing large packages
mkdir $HOME/tmp
export TMPDIR=$HOME/tmp

pip install -r requirements.txt
```

That's it! This was the main steps to setup Python environment on the GPSC. You can have a look at the `go.sh` script and adapt to your needs.
