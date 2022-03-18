# Databases for developers

### Group members: 
<a href = "https://github.com/dahlfrederik/soft_1sem_databases/graphs/contributors">
  <img src = "https://contrib.rocks/image?repo=dahlfrederik/soft_1sem_databases"/>
</a>

**


Click for a link to their github: 

[@josefmarcc ](https://github.com/josefmarcc)
[@fdinsen](https://github.com/fdinsen)
[@sebastianbentley ](https://github.com/SebastianBentley)
[@dahlfrederik ](https://github.com/dahlfrederik)



### Description
This repository is used for the handins in the course _databases for developers_ during the first semester of the bachelor in Software Development on CPH business in Lyngby. 
The repository contains folders for each handin and will be updated throughout the semester. 

# Folders

## Handin 1 
Contains all material regarding the responses to the first handin in PDF format. The PDF contains graphs and visualizations of our solution. 

## Handin 2
Contains all materials to create a database with a local enviroment to test our solution to the problem given in the exercise description. 

### Setup to run the program
To run the program do the following steps

To follow these steps we assume that you already have created a postgres database using a docker-image (if not, click this [link](https://hub.docker.com/_/postgres)), have a connection to it and that you have a favorite database visualizer tool (we recommend DBeaver). 

**Creating the database:**

1. Open your favorite database visualizer tool 
2. Run the createDBscript.sql filen to generate tabels 
2. Run functions.sql to create the postgresql functions 
3. Run names.sql to create data which will be used to generate test data
4. Run inserting-people-into-tables.sql to generate test data 

**Automated emails**

1. Open the file` sendEmail.py` in your favorite editor and change the username & password to your credentials. Be observant of the port number as well. 
2. Install python3 and relevant packages for this project to your docker enviroment using following commands:

	`apt-get update`
	
	`apt-get install python`
	
	`apt-get install python3-pip`
	
	`apt-get install libpq-dev`
	
	`apt install nano`
	
	`pip3 install psycopg2` 
	
	
3. Move the python script inside your docker. We recomend creating a folder: 

	Can be done using the commandline like this: 
	
	1. Open your docker dashboard and click on the CLI button in your postgressql image
	2. Type the following commands: 
	
		`cd home` will move you to the home directory
		
		`mkdir python` create a folder where you can save the script 
		
		`cd python` will move you to the python directory 
		
		`nano sendEmail.py` will open the nano text editor. Paste the python script inside this editor window. 
		
		`ctr + x` and choose to save the file. 
	
	3. Check that the scripts works by running it: 
	
		`python3 sendEmail.py`
	
4. Create a cronjob to run the script on a daily basis or your prefered timeframe. (See this [link](https://phoenixnap.com/kb/set-up-cron-job-linux )) for inspiration. 
	



** Made with [contributors-img](https://contrib.rocks).
