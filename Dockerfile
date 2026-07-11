# Use official Playwright image
FROM mcr.microsoft.com/playwright:v1.60.0-noble

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy project files
COPY . .

# Install Playwright browsers (optional if using Playwright image)
RUN npx playwright install --with-deps

# Run tests
CMD ["npx", "playwright", "test"]