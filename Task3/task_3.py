from pathlib import Path 
import json

filePath = Path.cwd()
print(filePath)

rootDir = filePath.anchor
rootPath = Path(rootDir)

targetFile = input('Enter file name: ')
#rglob is like bringing a flamethrower to a BBQ so would be best to find a more elegant way to search all for the required file. 
textFiles = list(rootPath.rglob(targetFile))

if textFiles:
    file_to_open = textFiles[0]
    with file_to_open.open('r', encoding='utf-8') as f:
        content = f.read()

    data = json.loads(content)

    addTotal = sum(data.get("Add", []))
    minus = data.get("Minus", [])
    minusTotal = minus[0]
    
    for num in minus[1:]:
            minusTotal -= num

    multiplyTotal = 1

    for num in data.get("Times", []):
        multiplyTotal *= num

    calculated = {'add': addTotal, 'minus': minusTotal, 'multiply': multiplyTotal}

    with open('calculated.json', 'w', encoding='utf-8') as f:
        json.dump(calculated, f, ensure_ascii=False, indent=4)
    
else:
    print("File not found.")

