all: Carbon_Emission.text Continent_Emission.text Continent_Portions.text Continent_Participation.text Emission_vs_Pop country_whole_data.text Sectors_Participation_1950.jpg Sectors_Participation_1966.jpg Sectors_Participation_1982.jpg Sectors_Participation_1997.jpg Sectors_Participation_2013.jpg Continents_Participation.jpg Continents_Ranking.jpg emission_sectors_vs_years.jpg Linear_Fitting.jpg 

clean:
	rm -f Carbon_Emission.text Continent_Emission.text Continent_Portions.text Continent_Participation.text Emission_vs_Pop.text country_whole_data.text Sectors_Participation_1950.jpg Sectors_Participation_1966.jpg Sectors_Participation_1982.jpg Sectors_Participation_1997.jpg Sectors_Participation_2013.jpg Continents_Participation.jpg Continents_Ranking.jpg emission_sectors_vs_years.jpg Linear_Fitting.jpg

Carbon_Emission.text: 
	Rscript 01_emission.R

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

Sectors_Participation_1950.jpg: Continent_Portions.text Continent_Participation.text
	Rscript 03_aggregate_plot_continent.R
	rm Rplots.pdf

Sectors_Participation_1966.jpg: Continent_Portions.text Continent_Participation.text
	Rscript 03_aggregate_plot_continent.R
	rm Rplots.pdf

Sectors_Participation_1982.jpg: Continent_Portions.text Continent_Participation.text
	Rscript 03_aggregate_plot_continent.R
	rm Rplots.pdf

Sectors_Participation_1997.jpg: Continent_Portions.text Continent_Participation.text
	Rscript 03_aggregate_plot_continent.R
	rm Rplots.pdf

Sectors_Participation_2013.jpg: Continent_Portions.text Continent_Participation.text
	Rscript 03_aggregate_plot_continent.R
	rm Rplots.pdf

Continents_Participation.jpg: Continent_Portions.text Continent_Participation.text
	Rscript 03_aggregate_plot_continent.R
	rm Rplots.pdf

Continents_Ranking.jpg:
	Rscript 03_aggregate_plot_continent.R
	rm Rplots.pdf

emission_sectors_vs_years.jpg: Continent_Emission.text country_whole_data.text
	Rscript 04_aggregate_plot_whole.R
	rm Rplots.pdf

Linear_Fitting.jpg: Continent_Emission.text country_whole_data.text
	Rscript 04_aggregate_plot_whole.R
	rm Rplots.pdf









