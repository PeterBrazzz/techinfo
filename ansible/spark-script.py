from pyspark.sql import SparkSession

# Create a Spark session
spark = SparkSession.builder \
    .appName("AverageProductPrice") \
    .getOrCreate()

# Load the product data from the mounted CSV file
# path = "/examples/src/main/python/prod_table.csv"
# # df = spark.read.csv("prod_table.csv", header=True, inferSchema=True)
# df = spark.read.options(delimiter=",", header=True).csv(path)
csv_file_path = "/home/azureuser/prod_table.csv"
df = spark.read.csv(csv_file_path, header=True, inferSchema=True)

df.show()



# Show the schema of the DataFrame to understand its structure
df.printSchema()

# Select the column containing product prices
prices = df.select("price")

# Calculate the average price
average_price = prices.agg({"price": "avg"}).collect()[0][0]

# Print the result
print(f"The average price of the products is: {average_price}")

# Stop the Spark session
spark.stop()
