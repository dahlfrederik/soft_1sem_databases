# DATABASE HANDIN HBase

### Exercise description

### Readme 

1. Go to the official HBase docker github following this [link](https://github.com/big-data-europe/docker-hbase) and clone the repository. We named the folder `docker-hbase`. Make sure that you have a docker installation. 
2. Go to the cloned folder and open the `docker-compose-distributed-local.yml` file in your favorite texteditor. In the file scroll down to the hbase-master block and change the ports to: 
	`- 16010:9090`
Make sure that you save your changes. 
3. In the cloned folder go to the folder claled hmaster and open the file called: `Dockerfile` in your texteditor. Make sure your expose part looks like this. `EXPOSE 9090 16000 16010`. Save it and close the texteditor. 
4. Open a CLI window in the main folder `docker-hbase` and run the following docker command: 
`docker-compose -f docker-compose-distributed-local.yml up -d`
5. Open a CLI window using the docker UI in the hbase-master docker environment. 
From here run the command: `hbase thrift start`. 
6. Download the dataset from [MyPyramid Raw Food](https://catalog.data.gov/dataset/mypyramid-food-raw-data) and place in a folder called `myfoodapediadata`. 
7. In this jupyter file make sure that the path to the `Food_Display_Table.xlsx` file is correct. 
8. Run the program and watch the magic happen. You have now inserted a lot of data. 





