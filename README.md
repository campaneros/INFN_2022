# Prerequisite
You need to install docker first. Please checkout detailed instructions for Linux/Mac/Windows [here](https://docs.docker.com/install/) before going further with the instructions.

# Install
To install the relevant helper scripts to run the docker images just clone the repository on your system.

```
git clone https://github.com/campaneros/INFN_2022.git
```

# Usage and files sharing
A folder will be shared between your system and the docker processes in order to provide inputs and save the outputs.

The folder to be mounted inside the docker is defined at the startup: repositories and data files should be placed inside that folder to make them visible inside the docker.

The folder is available inside the docker in the /data path. N.B.: only files saved in the /data directory inside the docker are visibile outside of the docker and are persisted when the docker is stopped. Any other file created outside /data are not saved when the docker is stopped.

An helper script run.sh has been created to help with the download and startup of the programs inside the docker image.

To open a session follow the instructions:

```
# Define the folder on your file system to be used for file sharing
export WORKSPACE=/home/user/path/to/your/workspace/of/preference
mkdir $WORKSPACE

# Install (if not already done) the helper script repository
git clone https://github.com/campaneros/INFN_2022.git
cd INFN_2022

# run.sh is a script to setup and run the docker enviroment
./run.sh $WORKSPACE 
```

Some options are available in the run.sh script to start directly python/root:

```
# Open a bash session
./run.sh $WORKSPACE 

# Open a python session
./run.sh $WORKSPACE python

# Open a ROOT session
./run.sh $WORKSPACE root
```

It is also possible to just start the docker in the background and then open and run several terminal on the same running docker environment:

```
# Open a session in background
./run.sh $WORKSPACE start

# Now to open a terminal just run
docker exec -ti infn bash

# or to open a specific program
docker exec -ti infn python

# or to open a specific program
docker exec -ti infn "python /data/your-script.py"
```

To stop the docker process and all the programs inside just execute:

```
docker stop infn
docker rmr infn

#or use the helper program
./run.sh $WORKSPACE clean
```

# Start a jupyter notebook
To start the jupyter notebook interface inside the docker just run:

```
./run.sh $WORKSPACE jupyter

# Then get the URL with the correct tocken from 
docker logs infn_jupyter
```

The docker image will be running in background with a jupyter notebook session open. To close it, run:

```
docker stop infn_jupyter
```
