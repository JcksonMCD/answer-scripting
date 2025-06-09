import zipfile
import os
import tempfile

while True:
    zip_path = input("Enter path to zip file (e.g. '../Week 4.zip'): ")

    # Step 1: Check if file exists
    if not os.path.isfile(zip_path):
        print("File not found. Please try again.\n")
        continue
    
    try:
        with zipfile.ZipFile(zip_path, 'r') as zip_file:
            # Step 2: Ask for file to search
            target_filename = input("Enter the name of the file to search for (e.g. 'data.txt'): ")

            # Step 3: Extract ZIP to temp folder
            with tempfile.TemporaryDirectory() as temp_dir:
                zip_file.extractall(temp_dir)

                # Step 4: Search for the file
                found_path = None
                for root, dirs, files in os.walk(temp_dir):
                    if target_filename in files:
                        found_path = os.path.join(root, target_filename)
                        break

                if not found_path:
                    print(f"'{target_filename}' not found in the ZIP. Exiting script now.")
                    break

                # Step 5: Print contents
                with open(found_path, 'r') as f:
                    content = f.read()
                    print(f"\n--- Contents of '{target_filename}' ---\n{content}\n")

            #break  # Exit loop if successful
    except zipfile.BadZipFile:
        print("Not a valid ZIP file. Please enter a valid zip file path.\n")
