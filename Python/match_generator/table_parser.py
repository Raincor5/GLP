from pandas.io.html import read_html
from selenium import webdriver


base_url = 'https://understat.com/league'
leagues = ['La_liga','EPL','Bundesliga','Serie_A','Ligue_1','RFPL']
seasons = ['2018','2019','2020','2021']

url = base_url+'/'+leagues[0]+'/'+seasons[3]


driver = webdriver.Chrome("E:/chromedriver.exe")
driver.get(url)

table = driver.find_element_by_xpath('/html/body/div[1]/div[3]/div[3]/div/div[2]/div/table')
table_html = table.get_attribute('innerHTML')

df = read_html(table_html)[0]
print(df)

driver.close()