import pandas as pd

df = pd.read_csv("../data/ai_ecommerce_business_intelligence_dataset.csv")
df["order_date"] = pd.to_datetime(df["order_date"])

print("Shape:", df.shape)
print("Missing values:\n", df.isna().sum())
print("Duplicate order IDs:", df["order_id"].duplicated().sum())

kpis = {
    "orders": df["order_id"].nunique(),
    "customers": df["customer_id"].nunique(),
    "revenue": df["revenue"].sum(),
    "profit": df["profit"].sum(),
    "aov": df["revenue"].sum() / df["order_id"].nunique(),
    "profit_margin": df["profit"].sum() / df["revenue"].sum(),
}
print("\nKPIs:")
for k, v in kpis.items():
    print(k, ":", v)

category = df.groupby("category").agg(
    revenue=("revenue", "sum"),
    profit=("profit", "sum"),
    orders=("order_id", "nunique")
)
category["profit_margin"] = category["profit"] / category["revenue"]
print("\nCategory performance:\n", category.sort_values("revenue", ascending=False))

channel = df.groupby("sales_channel").agg(
    revenue=("revenue", "sum"),
    profit=("profit", "sum")
)
channel["profit_margin"] = channel["profit"] / channel["revenue"]
print("\nChannel performance:\n", channel.sort_values("revenue", ascending=False))
