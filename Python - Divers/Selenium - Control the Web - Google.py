from selenium import webdriver
from selenium.webdriver.firefox.firefox_binary import FirefoxBinary
from selenium.webdriver.common.keys import Keys

from os import listdir

for f in listdir('C:\\Program Files\\geckodriver-v0.22.0-win64'):
    print(f)

#binary = FirefoxBinary(executable_path='C:\\Program Files\\geckodriver-v0.22.0-win64\\geckodriver.exe')
driver = webdriver.Firefox(executable_path='C:\\Program Files\\geckodriver-v0.22.0-win64\\geckodriver.exe')

# Open the website
driver.get('https://www.google.com/')


elem = driver.find_element_by_name("q")
elem.clear()
elem.send_keys("pycon")
elem.send_keys(Keys.RETURN)

driver.close

"""
# Equivalent Outcome!
id_box = driver.find_element_by_id('uslst-ib')

# Send id information
id_box.send_keys('crocodile')

# Find password box
pass_box = driver.find_element_by_name('btnK')
# Send password
pass_box.click()
"""


