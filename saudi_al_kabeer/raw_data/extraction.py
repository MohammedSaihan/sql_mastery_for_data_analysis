import pandas as pd
import numpy as np
import random
from faker import Faker

fake = Faker()

# --------------------
# SETTINGS
# --------------------

NUM_CUSTOMERS = 20000
NUM_PRODUCTS = 100
NUM_TRANSACTIONS = 500000
NUM_CITIES = 10

# --------------------
# CITIES TABLE
# --------------------

cities = ["Jeddah","Riyadh","Dammam","Mecca","Medina","Khobar","Tabuk","Taif","Abha","Hail"]

city_df = pd.DataFrame({
    "city_id": range(1, NUM_CITIES+1),
    "city_name": cities,
    "country": "Saudi Arabia",
    "region": ["West","Central","East","West","West","East","North","West","South","North"]
})

# --------------------
# PRODUCTS TABLE
# --------------------

categories = ["Electronics","Clothing","Home","Sports","Beauty"]

products = []

for i in range(1, NUM_PRODUCTS+1):
    category = random.choice(categories)
    
    cost = random.randint(20,500)
    price = cost * random.uniform(1.2,1.8)
    
    products.append([
        i,
        f"Product_{i}",
        category,
        f"Brand_{random.randint(1,20)}",
        round(cost,2),
        round(price,2)
    ])

product_df = pd.DataFrame(products,columns=[
    "product_id","product_name","category","brand","cost_price","selling_price"
])

# --------------------
# CUSTOMERS TABLE
# --------------------

customers = []

for i in range(1, NUM_CUSTOMERS+1):
    
    age = random.randint(18,65)
    
    if age <=25:
        group="18-25"
    elif age <=35:
        group="26-35"
    elif age <=45:
        group="36-45"
    elif age <=55:
        group="46-55"
    else:
        group="56+"
        
    customers.append([
        i,
        fake.name(),
        random.choice(["Male","Female"]),
        age,
        group,
        fake.date_between(start_date="-3y",end_date="today")
    ])

customer_df = pd.DataFrame(customers,columns=[
    "customer_id","customer_name","gender","age","age_group","join_date"
])

# --------------------
# SALES TRANSACTIONS
# --------------------

transactions = []

for i in range(1,NUM_TRANSACTIONS+1):
    
    product = random.randint(1,NUM_PRODUCTS)
    quantity = random.randint(1,5)
    
    price = product_df.loc[product_df.product_id==product,"selling_price"].values[0]
    
    discount = random.choice([0,0,0,0.05,0.1,0.15])
    
    total = quantity * price * (1-discount)
    
    transactions.append([
        i,
        random.randint(100000,999999),
        fake.date_between(start_date="-2y",end_date="today"),
        random.randint(1,NUM_CUSTOMERS),
        product,
        random.randint(1,NUM_CITIES),
        quantity,
        round(price,2),
        discount,
        round(total,2)
    ])

sales_df = pd.DataFrame(transactions,columns=[
    "transaction_id","invoice_id","order_date","customer_id","product_id",
    "city_id","quantity","unit_price","discount","total_amount"
])

# --------------------
# SAVE FILES
# --------------------

customer_df.to_csv("customers.csv",index=False)
product_df.to_csv("products.csv",index=False)
city_df.to_csv("cities.csv",index=False)
sales_df.to_csv("sales_transactions.csv",index=False)

print("Dataset generated successfully")