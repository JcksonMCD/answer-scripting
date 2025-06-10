from pathlib import Path 
import json

filePath = Path.cwd()
print(filePath)

rootDir = filePath.anchor
rootPath = Path(rootDir)

targetFile = input('Enter file name: ')
textFiles = list(rootPath.rglob(targetFile))

if textFiles:
    file_to_open = textFiles[0]
    with file_to_open.open('r', encoding='utf-8') as f:
        content = f.read()

    data = json.loads(content)

    add = sum(data.get("Add", []))
    minus = data.get("Minus", [])
    minusTotal = minus[0]
    
    for num in minus[1:]:
            minusTotal -= num

    multiply = 1
    for num in data.get("Times", []):
            multiply *= num

    print(f"Addition Results: {add}")
    print(f"Subtraction Results: {minusTotal}")
    print(f"Results of times: {multiply}")

else:
    print("File not found.")

