# Spread Calculator

This is a tool for calculating yield spread between a corporate bond and government bond benchmarks.

It takes a spreadsheet of corporate and government bonds in csv format and outputs the resulting yields in csv.

The two types of yields calculated are: **spread to benchmark** and **spread to curve**.

## How to use

```
ruby script/process.rb [file.csv]
```

e.g.
```
~/spread_calculator» ruby lib/process.rb resources/sample_input.csv
Writing ./spread_to_benchmark.csv
Writing ./spread_to_curve.csv
```

## CSV format

The input CSV has to have the following columns:

```
bond,type,term,yield
```

There will be 2 CSVs outputted spread_to_benchmark.csv and spread_to_curve.csv

spread_to_benchmark.csv:

```
bond,spread_to_benchmark
```

spread_to_curve.csv:
```
bond,spread_to_curve
```

## Tradeoffs

Space/time tradeoffs:

- Both Spread calculator objects are designed to hold bonds in memory. This will of course become untenable if there are millions of bonds passed in the file. A possible future approach: assuming a sorted list, only one government bond at a time needs to be processed in order to find a benchmark rate.

Design:
- In the interests of making the code as maintainable (and readable) as possible, an object oriented approach is chosen. This allows the code to be easily maintained and updated and also allows an easy refactor to a more functional approach when necessary (see above).

Libraries:
- At this stage of design, no libraries were deemed necessary other than standard ruby libraries like 'csv'. There are many flavours of linear interpolation available, but as with the other tradeoffs, in the interests of maintainability and traceability - a simpler approach was chosen.

