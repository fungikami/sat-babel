#!/usr/bin/env bash

echo "Installing sat-planner"

echo "Installing dependencies"
make >> /dev/null

# Verifies if the make command was successful
if [ $? -eq 0 ]; then
    echo "Dependencies installed"
else
    echo "Error installing dependencies"
    return 1
fi

echo "Adding sat-planner executables to PATH in this session"

# Verifies if the directory is already in the PATH
if [[ ":$PATH:" == *":$PWD/sat-planner/bin:"* ]]; then
    echo "They're already there"
else
    export PATH=$PWD/sat-planner/bin:$PATH
fi

echo "Done, you're good to go!"