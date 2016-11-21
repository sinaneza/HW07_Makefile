all: hw07_automation_report.html

clean:
	rm -f Carbon_Emission.text Continent_Emission.text Continent_Portions.text Continent_Participation.text Emission_vs_Pop.text country_whole_data.text Sectors_Participation_1950.png Sectors_Participation_1966.png Sectors_Participation_1982.png Sectors_Participation_1997.png Sectors_Participation_2013.png Continents_Participation.png Continents_Ranking.png emission_sectors_vs_years.png Linear_Fitting.png Jpn_Linear_Fitting.png

Carbon_Emission.text: 
	Rscript 01_emission.R
	rm Continent_Emission.text

Continent_Emission.text:
	Rscript 01_emission.R

Continent_Portions.text: Carbon_Emission.text Continent_Emission.text
	Rscript 02_emission.R
	
Continent_Participation.text: Carbon_Emission.text Continent_Emission.text
	Rscript 02_emission.R

Emission_vs_Pop.text: Carbon_Emission.text Continent_Emission.text
	Rscript 02_emission.R

country_whole_data.text: Carbon_Emission.text Continent_Emission.text
	Rscript 02_emission.R
	

Sectors_Participation_1950.png: Continent_Portions.text Continent_Participation.text
	Rscript 03_aggregate_plot_continent.R
	rm Rplots.pdf

Sectors_Participation_1966.png: Continent_Portions.text Continent_Participation.text
	Rscript 03_aggregate_plot_continent.R
	rm Rplots.pdf

Sectors_Participation_1982.png: Continent_Portions.text Continent_Participation.text
	Rscript 03_aggregate_plot_continent.R
	rm Rplots.pdf

Sectors_Participation_1997.png: Continent_Portions.text Continent_Participation.text
	Rscript 03_aggregate_plot_continent.R
	rm Rplots.pdf

Sectors_Participation_2013.png: Continent_Portions.text Continent_Participation.text
	Rscript 03_aggregate_plot_continent.R
	rm Rplots.pdf


Continents_Participation.png: Continent_Portions.text Continent_Participation.text
	Rscript 03_aggregate_plot_continent.R
	rm Rplots.pdf


Continents_Ranking.png:
	Rscript 03_aggregate_plot_continent.R
	rm Rplots.pdf


emission_sectors_vs_years.png: Continent_Emission.text country_whole_data.text
	Rscript 04_aggregate_plot_whole.R
	rm Rplots.pdf

Linear_Fitting.png: Continent_Emission.text country_whole_data.text
	Rscript 04_aggregate_plot_whole.R
	rm Rplots.pdf

Jpn_Linear_Fitting.png: Continent_Emission.text country_whole_data.text
	Rscript 04_aggregate_plot_whole.R
	rm Rplots.pdf emission_sectors_vs_years.png Linear_Fitting.png

hw07_automation_report.html: hw07_automation_report.rmd Continent_Participation.text Continent_Portions.text Emission_vs_Pop.text Sectors_Participation_1950.png Sectors_Participation_1966.png Sectors_Participation_1982.png Sectors_Participation_1997.png Sectors_Participation_2013.png Continents_Participation.png Continents_Ranking.png emission_sectors_vs_years.png Linear_Fitting.png Jpn_Linear_Fitting.png
	Rscript -e 'rmarkdown::render("$<")'





