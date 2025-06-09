import zipfile

with zipfile.ZipFile('../Week 4.zip', 'r') as zip_file:
    file_list = zip_file.namelist()
    print("The file list are:", file_list)
