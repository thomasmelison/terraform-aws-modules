import os

# Define and print each environment variable individually
print("VALOR DO OBJ KEY :", os.getenv("OBJECT_KEY", "Not Set"))
print("VALOR DO BUCKET NAME :", os.getenv("BUCKET_NAME", "Not Set"))
print("var1 valor :", os.getenv("var1", "Not Set"))
