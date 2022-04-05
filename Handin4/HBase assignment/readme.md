# DATABASE HANDIN HBase

## Readme 

1. Go to the official HBase docker github following this [link](https://github.com/big-data-europe/docker-hbase) and clone the repository. We named the folder `docker-hbase`. Make sure that you have a docker installation. 
2. Go to the cloned folder and open the `docker-compose-distributed-local.yml` file in your favorite texteditor. In the file scroll down to the hbase-master block and change the ports to: 
	`- 16010:9090`
Make sure that you save your changes. 
3. In the cloned folder go to the folder claled hmaster and open the file called: `Dockerfile` in your texteditor. Make sure your expose part looks like this. `EXPOSE 9090 16010`. Save it and close the texteditor. 
4. Open a CLI window in the main folder `docker-hbase` and run the following docker command: 
`docker-compose -f docker-compose-distributed-local.yml up -d`
5. Open a CLI window using the docker UI in the hbase-master docker environment. 
From here run the command: `hbase thrift start`. 
6. Download the dataset from [MyPyramid Raw Food](https://catalog.data.gov/dataset/mypyramid-food-raw-data) and place in a folder called `myfoodapediadata`. 
7. In this jupyter file make sure that the path to the `Food_Display_Table.xlsx` file is correct. 
8. Run the program and watch the magic happen. You have now inserted a lot of data. 


## Suggested Column Families
This suggestion is made with the assumption that Food_Code is the ID.
- Food-Family currently only contains the name, which one the one hand makes it easier to search through, but on the other might be a waste. Maybe name could be ID instead?
- Factor, Increment and Multiplier are assumed to be used for calculations related to the portions, so we have grouped those with the Portion family.
- Contents are the information related to the ingredients used for the food, and those have been grouped together. At the moment the Contents-Family is a large group, which will cause slowdowns as the family grows, so splitting it up further should be considered. They have been grouped with the assumption that they will be queried together more often than not.
- Nutritions-Family is all the information found on the back of the packet, and is assumed to be requested together.

#### Food-Family
- Display_Name

#### Portion-Family
- Portion_Default
- Portion_Amount
- Portion_Display_Name
- Factor
- Increment
- Multiplier

#### Contents-Family
- Grains
- Whole_Grains
- Vegetables
- Orange_Vegetables
- Drkgreen_Vegetables
- Starchy_Vegetables
- Other_Vegetables
- Fruits
- Milk
- Meats
- Soy
- Drybeans_Peas

#### Nutritions-Family
- Oils
- Solid_Fats
- Added_Sugars
- Alcohol
- Calories
- Saturated_Fats
