from pathlib import Path 

file_path = Path.home()
targetFile = input('Enter file name: ')
textFiles = list(file_path.rglob(targetFile))

if textFiles:
    file_to_open = textFiles[0]
    with file_to_open.open('r', encoding='utf-8') as f:
        content = f.read()
    print(content)
else:
    print("File not found.")