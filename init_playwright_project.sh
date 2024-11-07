#!/bin/bash

# Step 1: Create and activate a virtual environment
echo "Creating virtual environment..."
python3 -m venv venv
source venv/bin/activate

# Step 2: Install Playwright and other dependencies
echo "Installing Playwright and generating requirements.txt..."
pip install --upgrade pip
pip install pytest playwright

# Step 3: Install Playwright browsers
echo "Installing Playwright browsers..."
python -m playwright install

# Step 4: Freeze dependencies to requirements.txt
pip freeze > requirements.txt
echo "Generated requirements.txt with the installed dependencies."

# Step 5: Set up project structure
echo "Setting up project folders..."
mkdir -p sites tests

# Step 6: Create a sample Playwright test file
echo "Creating a sample Playwright test file..."
cat <<EOL > tests/test_example.py
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
EOL

echo "Project initialization complete! Virtual environment, requirements.txt, and basic structure have been set up."

echo "To start, activate your virtual environment with:"
echo "source venv/bin/activate"
