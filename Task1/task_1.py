import os
import shutil

# Step 1: Ask for filename
target_filename = input("Enter the name of the file to search for (e.g. 'Yorkshire Tea.txt'): ")
input_dir = os.path.join(os.getcwd(), 'Input')  # Scripts are in Input - only folder it should search through

found_path = None

# Search through 'Input/' recursively for the target file or break
for root, dirs, files in os.walk(input_dir):
    if target_filename in files:
        found_path = os.path.join(root, target_filename)
        break

if found_path:
    print(f"File found at: {found_path}")

    # Step 2: Read and print the contents of the file
    try:
        with open(found_path, 'r') as file:
            content = file.read()
            print(f"\nContents of '{target_filename}'\n{content}\n")
    except Exception as e:
        print(f"Failed to read the file: {e}")

    # Step 3: Copy file to the Output folder
    output_dir = os.path.join(os.getcwd(), 'Output')
    os.makedirs(output_dir, exist_ok=True)

    destination_path = os.path.join(output_dir, target_filename)

    try:
        shutil.copy2(found_path, destination_path)
        print(f"File copied to: {destination_path}")
    except Exception as e:
        print(f"Failed to copy file: {e}")

    # Step 4: Delete original file
    try:
        os.remove(found_path)
        print(f"Original file deleted from: {found_path}")
    except Exception as e:
        print(f"Failed to delete original file: {e}")

# If no file can be found end the script
else:
    print("File not found.")
