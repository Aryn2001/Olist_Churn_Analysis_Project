
# Olist E-Commerce — Customer Churn Analysis

## Business Problem
Olist's platform had a 97% customer churn rate. 
This project investigates the root cause and 
provides business recommendations.

## Tools Used
- MySQL (Data Cleaning + Analysis)

## Dataset
- Source: Kaggle — Olist Brazilian E-Commerce
- Records: ~99,000 orders (2016-2018)
- Tables: customers, orders, order_items, 
          payments, reviews

## Key Findings
1. 97% customers placed only 1 order (churned)
2. 94% orders were delivered early — 
   delivery is NOT the problem
3. 79% customers gave 4-5 star reviews — 
   quality is NOT the problem
4. Root cause: No loyalty or engagement program

## Business Recommendations
1. Launch loyalty program for 45,835 mid-value customers
2. Re-marketing campaign for 1-star review customers
3. Use early delivery as a retention tool

## Files
- olist_queries.sql — All SQL queries used
- Churn_Analysis.pdf — Full analysis report

## Dataset Link
[https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
