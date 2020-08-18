import pytest
import pytest_html
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from selenium.webdriver.remote.remote_connection import RemoteConnection

command_executor = RemoteConnection("http://localhost:4444/wd/hub", resolve_ip=False)
driver = webdriver.Remote(
    command_executor,
    desired_capabilities=DesiredCapabilities.FIREFOX
)

print(driver)

driver.implicitly_wait(30)
driver.set_window_position(0, 0)
driver.set_window_size(1920, 1080)
driver.get("http://localhost:5000")

#@pytest.fixture
def test_title_contents():
    print(driver)
    assert "<%= p('buzz.title') %>" in driver.title

def test_class_contents():
    content = driver.find_element_by_class_name("buzz")
    paragraph = content.find_element_by_class_name("buzz")
    
    assert paragraph.text != ""

#driver.quit()
