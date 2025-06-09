import zipfile
import os

while True:
    zip_path = input("Enter path to zip file (e.g. '../Week 4.zip'): ")

    # Check if file exists
    if not os.path.isfile(zip_path):
        print("File not found. Please try again.\n")
        continue

    # Check if it's a valid ZIP file
    try:
        with zipfile.ZipFile(zip_path, 'r') as zip_file:
            file_list = zip_file.namelist()
            print("The file list is:", file_list)
            break  # Exit loop if successful
    except zipfile.BadZipFile:
        print("Not a valid ZIP file. Please enter a valid zip file path.\n")
