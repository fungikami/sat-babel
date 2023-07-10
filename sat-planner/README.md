# sat-planner

This is a translation of a scheduling problem written in Ruby.

## Problem

The problem is to schedule a set of tasks, each of which has a duration and a set of prerequisites. The tasks must be scheduled in such a way that no task is started before all its prerequisites have been completed. The goal is to find a schedule that minimizes the total time required to complete all tasks.

## Solution

The solution is a SAT encoding of the problem. The encoding is written in Ruby and uses the DIMACS CNF format for the output. The encoding is based on the one described in the paper [Scheduling as satisfiability](https://www.cs.cmu.edu/~emc/15-820A/reading/jair-sat.pdf) by Carla P. Gomes, Bart Selman, and Henry Kautz.

## Usage

The program is written in Ruby and requires Ruby 3.2.2 or later. It is run from the command line as follows:

```
./bin/sat-planner input-file output-file
```

The input file is a text file that describes the problem. The output file is a text file that contains the SAT encoding of the problem in DIMACS CNF format.

## Input file format

A JSON file is used to describe the problem. The file contains a single object with the following fields:

```json
{
  "tournament_name": String. Name of the tournament,
  "start_date": String. Start date of the tournament in ISO 8601 format,
  "end_date": String. End date of the tournament in ISO 8601 format,
  "start_time": String. Time from which games can start each day, in ISO 8601 format,
  "end_time": String. Time at which games must end each day, in ISO 8601 format,
  "participants": [String]. List of participants in the tournament
}
```