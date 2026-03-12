import pandas as pd

customers = pd.read_csv("raw_data/customers.csv")
products = pd.read_csv("raw_data/products.csv")
cities = pd.read_csv("raw_data/cities.csv")
sales = pd.read_csv("raw_data/sales_transactions.csv")

# standardize column names
for df in [customers, products, cities, sales]:
    df.columns = df.columns.str.strip().str.lower().str.replace(" ", "_")

# convert dates
customers["join_date"] = pd.to_datetime(customers["join_date"], errors="coerce").dt.date
sales["order_date"] = pd.to_datetime(sales["order_date"], errors="coerce").dt.date

# remove duplicate primary keys
customers = customers.drop_duplicates(subset=["customer_id"])
products = products.drop_duplicates(subset=["product_id"])
cities = cities.drop_duplicates(subset=["city_id"])
sales = sales.drop_duplicates(subset=["transaction_id"])

# fill missing discounts with 0
sales["discount"] = sales["discount"].fillna(0)

# save cleaned files
customers.to_csv("customers_clean.csv", index=False)
products.to_csv("products_clean.csv", index=False)
cities.to_csv("cities_clean.csv", index=False)
sales.to_csv("sales_transactions_clean.csv", index=False)

print("Clean files exported.")