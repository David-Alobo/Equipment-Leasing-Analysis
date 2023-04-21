# Equipment-Leasing-Analysis
The number of contracts for both new and used equipment for an equipment leasing company, MEL, was analyzed in this project with SQL.

Monstrous Equipment Leasing Ltd (MEL) is a heavy equipment leasing company in Nigeria founded in December, 2022 with 20 employees. MEL offers clients brand-new equipment, but when the equipment is retrieved from clients after the end of each contract or default from clients, the equipment is refurbished and issued to client as new equipment.

Knowing the total number of contracts, new and used equipment leased on a monthly basis with respect to the engagement date is a huge challenge for MEL.

A table, contract_table, was provided and below is the meta data:

 | Title | Description       |
 |---|---|
 | contract_id     | contract_id of contracts created. More than one equipment can't have same contract_id |
 | customer_id     | customer_id of the client the equipment was leased to |
 | engagement_date | deployment date of the equipment or contract active date  |
 | created_at | contract creation date  |
 | updated_at | contract updated date  |
 
 Below is the output of the analysis:
 
<img width="338" alt="final output" src="https://user-images.githubusercontent.com/88712885/233604376-7f57e0a5-8056-4134-9854-6879f4cd7971.png">

### Tools

mySQL Workbench
