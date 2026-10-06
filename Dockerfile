FROM node:22-bookworm

# Install C++ compiler and OpenMP support
RUN apt-get update && \
    apt-get install -y g++ bash && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy project
COPY . .

# Build sequential and OpenMP programs
RUN mkdir -p build && \
    g++ -O2 -std=c++17 src/sequential.cpp -o build/sequential && \
    g++ -O2 -std=c++17 -fopenmp src/openmp.cpp -o build/openmp

# Render provides PORT automatically
ENV NODE_ENV=production

EXPOSE 5050

CMD ["node", "backend/server.js"]