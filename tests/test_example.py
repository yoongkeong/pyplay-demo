from playwright.sync_api import sync_playwright
import pytest

@pytest.fixture(scope="session")
def browser():
    with sync_playwright() as p:
        browser = p.chromium.launch()
        yield browser
        browser.close()

def test_example(browser):
    page = browser.new_page()
    page.goto("https://example.com")
    assert page.title() == "Example Domain"
    page.close()
