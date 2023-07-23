use database practice

-- comma is used after * as bcoz there would be one more coloumn named submission_type

select *,
case
when submitted_via in ('Email','Postal Mail','Referral') then 'Outbound'
when submitted_via in ('Phone','Web') then 'Inbound'
when submitted_via = 'Fax' then 'Electronics'
else submitted_via
end as submission_type
from RJ_Consumer_Complaints

--below code can be used
select *,
case when product_name like '%loan%' or product_name ='Consumer Loan' then 'Loan'
     when product_name in ('Bank account or service','Mortgage','Debt Collection', 'Credit Reporting', 'Money transfers') then 'Service'
     else 'Other'
     end as Finance_type
     
from RJ_Consumer_Complaints

--optimized
 SELECT *,
 CASE 
 WHEN LOWER(PRODUCT_NAME) LIKE '%loan%' THEN 'Loan'
 WHEN UPPER(PRODUCT_NAME) IN('BANK ACCOUNT OR SERVICE','MORTGAGE','DEBT CLLECTION','CREDIT CARD','CREDIT REPORTING','MONEY TRANSFERS') THEN 'Service'
ELSE 'Other'
       END AS FINANCE_TYPE
FROM RJ_CONSUMER_COMPLAINTS;


select sub_product,
case 
when sub_product ='I do not know' or sub_product is NULL then 'NA'
when lower(sub_product) like '%card%' then 'Card'
when sub_product like '%loan' then 'Loan'
when sub_product like '%mortgage%' then 'Mortgage'
when sub_product like '%account' then 'Account'
else sub_product
end as sub_product_type
from RJ_Consumer_Complaints

select COMPANY_RESPONSE_TO_CONSUMER ,
case when COMPANY_RESPONSE_TO_CONSUMER = 'Closed with monetary relief' then 'Monetary relief provided'
     when COMPANY_RESPONSE_TO_CONSUMER in ('Closed', 'Closed with non-monetary relief') then 'Non monetary relief provided'
     when COMPANY_RESPONSE_TO_CONSUMER = 'Closed with explanation' then 'Explanation'
     else  COMPANY_RESPONSE_TO_CONSUMER 
     end as RESPONSE_TO_CONSUMER_TYPE
from RJ_Consumer_Complaints
   
select distinct COMPANY_RESPONSE_TO_CONSUMER from RJ_Consumer_Complaints

create or replace view CJ_Company_Response_to_consumer as
select Date_received, product_name, sub_product, issue, Company, State_name, Zip_Code, Submitted_via,
case
      when submitted_via in ('Email','Postal Mail','Referral') then 'Outbound'
      when submitted_via in ('Phone','Web') then 'Inbound'
      when submitted_via = 'Fax' then 'Electronics'
      else submitted_via
           end as submission_type,
           
case 
      when product_name like '%loan%' or product_name ='Consumer Loan' then 'Loan'
      when product_name in ('Bank account or service','Mortgage','Debt Collection', 'Credit Reporting', 'Money transfers') then 'Service'
      else 'Other'
           end as Finance_type,
case 
       when sub_product ='I do not know' or sub_product is NULL then 'NA'
       when lower(sub_product) like '%card%' then 'Card'
       when sub_product like '%loan' then 'Loan'
       when sub_product like '%mortgage%' then 'Mortgage'
       when sub_product like '%account' then 'Account'
            else sub_product
            end as sub_product_type,

case 
      when COMPANY_RESPONSE_TO_CONSUMER = 'Closed with monetary relief' then 'Monetary relief provided'
      when COMPANY_RESPONSE_TO_CONSUMER in ('Closed', 'Closed with non-monetary relief') then 'Non monetary relief provided'
      when COMPANY_RESPONSE_TO_CONSUMER = 'Closed with explanation' then 'Explanation'
      else COMPANY_RESPONSE_TO_CONSUMER 
           end as RESPONSE_TO_CONSUMER_TYPE
from RJ_Consumer_Complaints
   
   
 select * from CJ_Company_Response_to_consumer
           
           
      