# SLURM-pyenv-handson

We use the job scheduler called SLURM in Gatsby cluster computer. This is a hands-on tutorial of how to submit jobs written in python to SLURM.

## Set up a virtual environment with pyenv 

Although Python is pre-installed in the system, the version is old and it is not recommended to install 3rd-party libraries to the system Python. Instead, I recommend using [pyenv](https://github.com/pyenv/pyenv) and [pyenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv) to create Python environment.

Run following
```[bash]
source install_pyenv.sh
```
and pyenv and pyenv-virtualenv will be installed. If they are installed successfully, you can install any version of Python by executing

```[bash]
pyenv install 3.8.3
```

The version `3.8.3` above can be changed to any other versions, or you can install [anaconda](https://www.anaconda.com/) if you want. (Run `pyenv install --list` for the list of installable versions.) After installing a Python, I recommend to set it as a default python version. This can be done by
```[bash]
pyenv global 3.8.3
```

## Create a virtual environment using pyenv-virtualenv

I recommend using virtualenv, which enables us to separate all dependencies from project to project. In order to create an empty environment, execute

```[bash]
pyenv virtualenv 3.8.3 hands-on
pyenv local hands-on
```
which creates empty virtualenv called `hands-on` and activate it whenever you enter the directory. Then, you can install dependencies by
```[bash]
pip install -r requirements.txt
```

## Submit multi-cpu jobs





## Reference
- More Detailed Introduction to SLURM: (https://github.com/jamenendez11/Gatsby-Cluster-Tutorial)  
- pyenv github page (https://github.com/pyenv/pyenv)
- pyenv-virtualenv github page (https://github.com/pyenv/pyenv-virtualenv)