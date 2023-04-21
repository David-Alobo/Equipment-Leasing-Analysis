# Equipment-Leasing-Analysis
This is an analysis of the number of contracts with new and refurbished equipment for an Equipment Leasing Company, MEL.

Monstrous Equipment Leasing Ltd (MEL) is a heavy equipment leasing company in Nigeria founded in December, 2022 with 20 employees. MEL offers clients brand-new equipment, but when the equipment is retrieved from clients after the end of each contract or default from clients, the equipment is refurbished and issued to client as new equipment.

Knowing the total number of contracts, new and used equipment leased on a monthly basis with respect to the engagement date is a huge challenge for them.

A table, contract_table, was provided and below is the meta data:

 | Title |-- | Description       |
 | contract_id     | | contract_id of contracts created. More than one equipment can't have same contract_id |
 | customer_id     | | customer_id of the client the equipment was leased to |
 | engagement_date | | deployment date of the equipment or contract active date  |
 | created_at | | contract creation date  |
 | updated_at | | contract updated date  |
 
 Below is the output of the analysis:
 
 <img width="327" alt="final output" src="https://user-images.githubusercontent.com/88712885/233595969-5f81af24-422f-4c24-9565-6dc6a383065e.png">

Tools

mySQL Workbench
