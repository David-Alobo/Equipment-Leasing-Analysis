WITH contract
/*cleaning the contract_table since I got the wrong datatype for engagement_date, created_at, updated_at, and,
I could not cast them as date because the date format is wrong*/
     AS (SELECT *,
                Cast(Concat(RIGHT(engagement_date, 4), '-',
                     Substring(engagement_date, 4, 2),
                     '-',
                          LEFT(engagement_date, 2)) AS DATE) engagement_date_2,
                Cast(Concat(RIGHT(created_at, 4), '-',
                     Substring(created_at, 4, 2),
                     '-',
                     LEFT(
                          created_at, 2)) AS DATE)           created_at_2,
                Cast(Concat(RIGHT(updated_at, 4), '-',
                     Substring(updated_at, 4, 2),
                     '-',
                     LEFT(
                          updated_at, 2)) AS DATE)           updated_at_2
         FROM   contract_table),
     contract_table
     /*the cleaned contract table with the correct datatype*/
     AS (SELECT contract_id,
                customer_id,
                equipment_id,
                engagement_date_2 engagement_date,
                created_at_2      created_at,
                updated_at_2      updated_at
         FROM   contract),
     equipment_type
     /*checking if the equipment leased is new or refurbished for each contract*/
     AS (SELECT *,
                First_value(engagement_date)
                  OVER (
                    partition BY equipment_id
                    ORDER BY engagement_date ) first_deployment_date,
                CASE
                  WHEN engagement_date = First_value(engagement_date)
                                           OVER (
                                             partition BY equipment_id
                                             ORDER BY engagement_date ) THEN
                  'New'
                  ELSE 'Refurbished'
                END                            equipment_status
         FROM   contract_table),
     ag_table
     AS (SELECT yr_month,
                Count(*) contracts
         FROM   (SELECT *,
                        First_value(engagement_date)
                          OVER (
                            partition BY equipment_id
                            ORDER BY engagement_date )
                        first_deployment_date,
                        CASE
                          WHEN engagement_date = First_value(engagement_date)
                                                   OVER (
                                                     partition BY equipment_id
                                                     ORDER BY engagement_date )
                        THEN
                          'New'
                          ELSE 'Refurbished'
                        END
                        equipment_status,
                        Extract(year_month FROM engagement_date) yr_month
                 FROM   contract_table) at
         GROUP  BY yr_month),
     new_equipment
     /*the analysis of equipment leased when new by month*/
     AS (SELECT yr_month,
                Count(*) new_equipment
         FROM   (SELECT *,
                        First_value(engagement_date)
                          OVER (
                            partition BY equipment_id
                            ORDER BY engagement_date )
                        first_deployment_date,
                        CASE
                          WHEN engagement_date = First_value(engagement_date)
                                                   OVER (
                                                     partition BY equipment_id
                                                     ORDER BY engagement_date )
                        THEN
                          'New'
                          ELSE 'Refurbished'
                        END
                        equipment_status,
                        Extract(year_month FROM engagement_date) yr_month
                 FROM   contract_table) at
         WHERE  equipment_status = 'new'
         GROUP  BY yr_month),
     refurbished_equipment
     /*the analysis of equipment leased when refurbished by month*/
     AS (SELECT yr_month,
                Count(*) refurbished_equipment
         FROM   (SELECT *,
                        First_value(engagement_date)
                          OVER (
                            partition BY equipment_id
                            ORDER BY engagement_date )
                        first_deployment_date,
                        CASE
                          WHEN engagement_date = First_value(engagement_date)
                                                   OVER (
                                                     partition BY equipment_id
                                                     ORDER BY engagement_date )
                        THEN
                          'New'
                          ELSE 'Refurbished'
                        END
                        equipment_status,
                        Extract(year_month FROM engagement_date) yr_month
                 FROM   contract_table) at
         WHERE  equipment_status = 'refurbished'
         GROUP  BY yr_month)
SELECT ag.yr_month,
       ag.contracts,
       Ifnull(refurbished_equipment, 0) refurbished_equipment,
       Ifnull(new_equipment, 0)         new_equipment
FROM   ag_table ag
       LEFT JOIN new_equipment ne
              ON ag.yr_month = ne.yr_month
       LEFT JOIN refurbished_equipment re
              ON ag.yr_month = re.yr_month 