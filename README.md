# Azure-perftest-IO-Fio
This script can be used to test Input Output performance of a disk 

To install FIO: 
```
yum install libaio* gcc wget make
wget http://brick.kernel.dk/snaps/fio-2.0.14.tar.gz
tar -xvf fio-2.0.14.tar.gz
cd fio-2.0.14
 ./configure
 make
 make install
 ```
 
 To run the test: 
```
./fio-script.sh <select a name for your test>
 ```

The test generates a CSV file. You can copy/pase the data from CSV into the result sheet in FIO-Template excel file available in this repo. Then you can use the Pivot tables to draft charts and graphs. 

