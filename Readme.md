Readme
================

-   First the code *01\_emission.R* should be run
    -   Raw data is downloaded from a website sited in code
    -   Since the raw data had some lines after the column names line,it was unreadable by R;hence, I had to fix it manually
    -   Raw downleded data are specified by the word **Raw** at the end of their name
    -   In this *Rscript* I have made raw data suitable for data analysis
    -   It has two outputs: *Carbon\_Emission.text* and *Continent\_Emission.text*
-   Second the code *02\_emission.R* should be run
    -   All the outputs of first code are used as inputs
    -   Some data anlysis is done in this stage
    -   It has four outputs named *Continent\_Portions.text*, *Continent\_Participation.text*, *Emission\_vs\_Pop.text*, and *country\_whole\_data.text*.
-   Third code named *03\_aggregate\_plot\_continent* is used to aggregate plots for continents
    -   Inputs in this stage are *Continent\_Portions.text* and *Continent\_Participation.text*
    -   It has 7 plots as output.
-   Fourrth stage named *04\_aggregate\_plot\_whole* is used to draw plots related to the whole dataset.
    -   It has two inputs which are some outputs of second stage named *Continent\_Emission.text* and *country\_whole\_data.text*.
    -   It has 3 plots as output
-   All of these stages are automated using a make file and finally a report is rendered.
    -   Report uses all plots and some text files as input.
