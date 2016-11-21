hw07 automation: Carbon Emission
================
Sina Nezafatkhah
November 18, 2016

Portion of Each Sector in Carbon Emission
-----------------------------------------

Firstly, portion of participation in each sector is extracted from raw data. Sectors participating in carbon emission are solid fuel, gas fuel, and liquid fuel consumption. Moreover, cement production and gas flaring are included in partipating sectors.

The following tables show percentage of each sector for different continents in different years.

``` r
library(tidyverse)
```

    ## Loading tidyverse: ggplot2
    ## Loading tidyverse: tibble
    ## Loading tidyverse: tidyr
    ## Loading tidyverse: readr
    ## Loading tidyverse: purrr
    ## Loading tidyverse: dplyr

    ## Conflicts with tidy packages ----------------------------------------------

    ## filter(): dplyr, stats
    ## lag():    dplyr, stats

``` r
library(readr)
Continent_Portions <- dget("Continent_Portions.text") %>% 
  rename(Gas = Gas_Percent,
         Liquid = Liquid_Percent,
         Solid = Solid_Percent,
         Cement = Cement_Percent,
         Flaring = Flaring_Percent)

Continent_Portions %>% 
  filter(year %in% c(1950,1966, 1982, 1997, 2013), 
         continent == "Africa") %>% 
  knitr:: kable()
```

|  year|   Total| continent |         Gas|    Liquid|     Solid|    Cement|   Flaring|
|-----:|-------:|:----------|-----------:|---------:|---------:|---------:|---------:|
|  1950|   25912| Africa    |   0.0038592|  25.16595|  72.68061|  2.168879|  0.000000|
|  1966|   60416| Africa    |   1.0659428|  37.95849|  55.94379|  2.684719|  2.345405|
|  1982|  156665| Africa    |   4.1783423|  41.18342|  43.59238|  3.214502|  7.830722|
|  1997|  220295| Africa    |  11.8264146|  36.72212|  44.50214|  4.029143|  2.919267|
|  2013|  345667| Africa    |  18.0156046|  37.63825|  33.63989|  6.449270|  4.255830|

``` r
Continent_Portions %>% 
  filter(year %in% c(1950,1966, 1982, 1997, 2013), 
         continent == "Americas") %>% 
  knitr:: kable()
```

|  year|    Total| continent |       Gas|    Liquid|     Solid|     Cement|    Flaring|
|-----:|--------:|:----------|---------:|---------:|---------:|----------:|----------:|
|  1950|   778475| Americas  |  11.48720|  36.89585|  48.17599|  0.8600148|  2.5812004|
|  1966|  1145405| Americas  |  22.15112|  46.11216|  28.89746|  1.2004487|  1.6389836|
|  1982|  1532010| Americas  |  20.35196|  49.49243|  28.07756|  1.2565192|  0.8214698|
|  1997|  1940268| Americas  |  21.97846|  45.19484|  30.62804|  1.4697454|  0.7287138|
|  2013|  2053579| Americas  |  27.24994|  44.95868|  25.08557|  1.7840073|  0.9216592|

``` r
Continent_Portions %>% 
  filter(year %in% c(1950,1966, 1982, 1997, 2013), 
         continent == "Asia") %>% 
  knitr:: kable()
```

|  year|    Total| continent |         Gas|    Liquid|     Solid|    Cement|    Flaring|
|-----:|--------:|:----------|-----------:|---------:|---------:|---------:|----------:|
|  1950|    51008| Asia      |   0.8234003|  16.90323|  80.84614|  1.421346|  0.0000000|
|  1966|   284834| Asia      |   2.3617265|  22.95232|  65.94016|  2.001868|  6.7425237|
|  1982|   836554| Asia      |   4.2112045|  33.03887|  55.48285|  3.571915|  3.6952785|
|  1997|  1997660| Asia      |  10.4521290|  30.54188|  52.41473|  5.885186|  0.7058258|
|  2013|  4713822| Asia      |  11.2736544|  21.18877|  57.68164|  9.340446|  0.5155477|

``` r
Continent_Portions %>% 
  filter(year %in% c(1950,1966, 1982, 1997, 2013), 
         continent == "Europe") %>% 
  knitr:: kable()
```

|  year|    Total| continent |        Gas|    Liquid|     Solid|    Cement|    Flaring|
|-----:|--------:|:----------|----------:|---------:|---------:|---------:|----------:|
|  1950|   509817| Europe    |   1.127856|  14.39870|  83.08001|  1.392853|  0.0000000|
|  1966|  1156584| Europe    |   8.430948|  36.36070|  52.69250|  2.510669|  0.0051877|
|  1982|  1798515| Europe    |  17.763321|  42.08989|  37.14103|  2.545044|  0.4607134|
|  1997|  1766751| Europe    |  29.257830|  35.40969|  32.75040|  2.296985|  0.2850996|
|  2013|  1778648| Europe    |  34.679993|  31.20623|  30.84854|  2.674784|  0.5903923|

``` r
Continent_Portions %>% 
  filter(year %in% c(1950,1966, 1982, 1997, 2013), 
         continent == "Oceania") %>% 
  knitr:: kable()
```

|  year|   Total| continent |         Gas|    Liquid|     Solid|    Cement|    Flaring|
|-----:|-------:|:----------|-----------:|---------:|---------:|---------:|----------:|
|  1950|   45382| Oceania   |   0.0815301|  10.41162|  87.70878|  1.798070|  0.0000000|
|  1966|  151959| Oceania   |   0.6659691|  50.82884|  44.65678|  3.847090|  0.0000000|
|  1982|  315712| Oceania   |   6.5819481|  57.62277|  32.01557|  3.762923|  0.0167875|
|  1997|  421004| Oceania   |  11.9122384|  50.91139|  33.91440|  3.216359|  0.0456053|
|  2013|  455052| Oceania   |  19.2314285|  39.93983|  38.77645|  2.009441|  0.0424127|

In the following figures, bar plot related to portion of carbon emission caused by each sector is depicted for each continent. It can be concoluded from the graphs that in the middle parts of previous century, solid fuels were the dominant cause of carbon emission, while gas and liquid fuels were in minority. This habit has been changed and participation percentage of liquid and gas fuels have been increased by time. Moreover, during recent years liquid and gas fuels were dominant reason of carbon emission

![*Fig. 1*](Sectors_Participation_1950.png)

![*Fig. 2*](Sectors_Participation_1966.png)

![*Fig. 3*](Sectors_Participation_1982.png)

![*Fig. 4*](Sectors_Participation_1997.png)

![*Fig. 5*](Sectors_Participation_2013.png)

Participation of Each Continent in Carbon Emission
--------------------------------------------------

After analyzing the consiquenses of different sectors in different continents and different years, now we are ready to do analysis on the participation of each continent in carbon emission.

The tables below show participation percentage of each continent in years 1950, 1966, 1982, 2013. This amount is shown visually in bar charts for aforementioned years.

``` r
Continent_Participation <- dget("Continent_Participation.text")

Continent_Participation %>% 
  filter(year %in% c(1950,1966, 1982, 1997, 2013), 
         continent == "Africa") %>% 
  knitr:: kable()
```

| continent |  year|  Participation|
|:----------|-----:|--------------:|
| Africa    |  1950|       1.836957|
| Africa    |  1966|       2.158333|
| Africa    |  1982|       3.376797|
| Africa    |  1997|       3.471411|
| Africa    |  2013|       3.698252|

``` r
Continent_Participation %>% 
  filter(year %in% c(1950, 1966, 1982, 1997, 2013),
         continent == "Americas") %>% 
  knitr:: kable()
```

| continent |  year|  Participation|
|:----------|-----:|--------------:|
| Americas  |  1950|       55.18774|
| Americas  |  1966|       40.91904|
| Americas  |  1982|       33.02133|
| Americas  |  1997|       30.57477|
| Americas  |  2013|       21.97101|

``` r
Continent_Participation %>% 
  filter(year %in% c(1950, 1966, 1982, 1997, 2013),
         continent == "Asia") %>% 
  knitr:: kable()
```

| continent |  year|  Participation|
|:----------|-----:|--------------:|
| Asia      |  1950|       3.616065|
| Asia      |  1966|      10.175557|
| Asia      |  1982|      18.031295|
| Asia      |  1997|      31.479151|
| Asia      |  2013|      50.432642|

``` r
Continent_Participation %>% 
  filter(year %in% c(1950, 1966, 1982, 1997, 2013),
         continent == "Europe") %>% 
  knitr:: kable()
```

| continent |  year|  Participation|
|:----------|-----:|--------------:|
| Europe    |  1950|       36.14201|
| Europe    |  1966|       41.31841|
| Europe    |  1982|       38.76564|
| Europe    |  1997|       27.84048|
| Europe    |  2013|       19.02955|

``` r
Continent_Participation %>% 
  filter(year %in% c(1950, 1966, 1982, 1997, 2013),
         continent == "Oceania") %>% 
  knitr:: kable()
```

| continent |  year|  Participation|
|:----------|-----:|--------------:|
| Oceania   |  1950|       3.217226|
| Oceania   |  1966|       5.428662|
| Oceania   |  1982|       6.804936|
| Oceania   |  1997|       6.634186|
| Oceania   |  2013|       4.868549|

![*Fig. 6*](Continents_Participation.png)

It can be seen that in the middle years of previous century, Americas and Europe were leading continents in carbon emission, but they have given their position to Asia during recent years.

Then, it is useful to rank continents according to their average carbon emission since 1950. The figure below shows this ranking

![*Fig. 7*](Continents_Ranking.png)

It is seen that Americas and Europe were leading continents according to their average contribution in carbon emission (35%) followed by Asia (21%). Oceania and Africa were in minority in comparison to their counterparts in this sense (less than 10%)

Changes in Behaviour of Emission for each sector
------------------------------------------------

Now we are ready to analyze the amount of emission for each sector. The graph below compares carbon emission of each sector since 1950.

![*Fig. 8*](emission_sectors_vs_years.png)

It can be seen that gas flaring and cement production were in minority compared to their counterparts. Emission caused by gas flaring remained unchanged to some extent during the interval between 1950 to 2013, while participation of cement industry has incresed steadily since 1980.

Moreover, we can see that emission caused by gas fuel, liquid fuel, and solid fuel had an increasing trend in this time interval. Additionally, this trend was more intensive for liquid and solid fuel. It is interesting to know that increasing trend of carbon emission caused by solid fuels was more abrupt from 2000.

Relationship between population and carbon emission
---------------------------------------------------

It was interesting for me to know whether it is correct to say more populated countries emit more carbon to atmosphere; hence, to analyze this, the dot plot comparing population with carbon emission in 1990 is depicted as below. It should be noticed that the red line refers to linear model estimating the behaviour of carbon emission against population.

![*Fig. 9*](Linear_Fitting.png)

According to the graph, it can be concoluded that the foregoing assumption is true to some extent.

In addition, the multipliers of linear model, fitting population against emission for each country, is extracted using *lm()* function. These multipliers can be detected in the following table for first 10 participant countries in carbon emission.

``` r
dget("Emission_vs_Pop.text") %>% 
  head(10) %>% 
  knitr:: kable()
```

| country                           |  Resid\_Lin\_Fit\_normal|   intercept|       slope|
|:----------------------------------|------------------------:|-----------:|-----------:|
| russian federation                |               178085.234|    339076.0|    794.8831|
| united states of america          |               413711.226|    354283.6|   3786.3319|
| japan                             |                78673.374|   -937245.6|  10022.7113|
| federal republic of germany       |                 9742.027|   -676324.4|  14186.1269|
| ukraine                           |                67107.390|   -311711.0|   8486.0141|
| united kingdom                    |                25295.698|    347650.4|  -3413.4557|
| former german democratic republic |                10706.926|    132255.1|  -2567.0367|
| china (mainland)                  |              2242224.860|  -5106683.3|   5171.2535|
| kazakhstan                        |                35766.350|   -219677.3|  17176.7999|
| republic of korea                 |                43748.036|   -431178.5|  11871.9354|

The following figure shows Japan's emission against different populations it had. This figure measures the accuracy of linear modelling; moreover, it shows that in Japan carbon emission increased by population growth.

![*Fig. 10*](Jpn_Linear_Fitting.png)
