all:Carbon_Emission.text Continent_Emission.text 

clean:
	rm -f Continent_Emission.text Carbon_Emission.text

Carbon_Emission.text Continent_Emission.text: 
	Rscript 01_emission.R