import os

# Step 1: Ask for filename
target_filename = input("Enter the name of the file to search for (e.g. 'Yorkshire Tea.txt'): ")
input_dir = os.path.join(os.getcwd(), 'Input')  # Script is in Task1

found_path = None

# Search through 'Input/' recursively for the target file
for root, dirs, files in os.walk(input_dir):
    if target_filename in files:
        found_path = os.path.join(root, target_filename)
        break

if found_path:
    print(f"File found at: {found_path}")
else:
    print("File not found.")
