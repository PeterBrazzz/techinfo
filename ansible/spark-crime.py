from pyspark.sql import SparkSession

# Create a Spark session
spark = SparkSession.builder \
    .appName("Crime_Cities") \
    .getOrCreate()

# Load the product data from the mounted CSV file
# path = "/examples/src/main/python/prod_table.csv"
# # df = spark.read.csv("prod_table.csv", header=True, inferSchema=True)
# df = spark.read.options(delimiter=",", header=True).csv(path)
csv_file_path = "/home/azureuser/Crime_Data_from_2020_to_Present.csv"
df = spark.read.csv(csv_file_path, header=True, inferSchema=True)

def unique(list1):

    # initialize a null list
    unique_list = []

    # traverse for all elements
    for x in list1:
        # check if exists in unique_list or not
        if x not in unique_list:
            unique_list.append(x)
    # print list
    for x in unique_list:
        print(f"\n{x}"),


location = df.select("AREA NAME")
uniq_location=unique(location)

# Print the result
print(f"crime was here: \n{uniq_location}")

# Stop the Spark session
spark.stop()
