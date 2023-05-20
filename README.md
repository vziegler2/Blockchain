Bold and uppercase -> input variables  
Italics -> function name  

## SimpleStorage.sol (Basics)
1. *store* saves a **NUMBER**  
2. *retrieve* returns the saved number  
3. *addPerson* adds a **NAME** and **NUMBER** to the array and mapping  

## StorageFactory.sol (Import)
1. *createSimpleStorageContract* saves a new instance of SimpleStorage in an array  
2. *sfStore* saves a **NUMBER** in the instance at the **INDEX**-position of the array  
3. *sfGet* returns the saved number in the instance at the **INDEX**-position of the array  

## ExtraStorage.sol (Inheritance)
1. *store* saves a **NUMBER** and adds 5

## FundMe.sol (Github NPM-Package)
1. *fund* checks, if the fund amount is big enough and saves sender and amount

## PriceConverter.sol (Library)
1. *getPrice* returns the current ETH/USD price
2. *getConversionRate* returns the value of **ETH** in USD