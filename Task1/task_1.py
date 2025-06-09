import zipfile

zip_path = input("Enter path to zip file: ")  # e.g. ../Week 4.zip

with zipfile.ZipFile(zip_path, 'r') as zip_file:
    file_list = zip_file.namelist()
    print("The file list are:", file_list)
