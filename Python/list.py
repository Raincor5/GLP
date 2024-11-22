f = open('Table.csv')
fString = f.read()

fList = []
for line in fString.split('\n'):
    fList.append(line.split(','))

print(fList)

