# 🚀 Learn Jenkins CI/CD Pipeline with Docker & AWS Deployment

This project demonstrates an end-to-end DevOps workflow where I automated the build, testing, containerization, and cloud deployment of a Node.js application using **Jenkins**, **Docker**, and **AWS EC2**. This project reflects a real-world CI/CD and deployment setup, similar to what DevOps engineers do in production environments.

---

## 📦 Project Overview

The goal of this project was to:
- Fork a Node.js application from GitHub
- Dockerize the application for consistent builds
- Set up a Jenkins pipeline to automate:
  - Building the app with dependencies
  - Testing the application
  - Building a Docker image
  - Pushing the Docker image to Docker Hub
  - Deploying the app to an AWS EC2 instance
- Securely expose the app on port `3000`

---

## 🛠 Tech Stack & Tools Used

- **Node.js 18** (Application runtime)
- **Docker** (Containerization)
- **Jenkins** (CI/CD Pipeline)
- **Docker Hub** (Image Registry)
- **AWS EC2** (Cloud Deployment)
- **GitHub** (Version Control)
- **AWS Security Groups** (Firewall for port access)

---

## ⚙️ Step-by-Step Workflow

### 1. Application Setup
- Forked the `learn-jenkins-app` from GitHub.
- Wrote a production-ready **Dockerfile**:
  ```dockerfile
  FROM node:18-slim
  WORKDIR /app
  COPY package.json .
  RUN npm ci --only=production
  COPY . .
  EXPOSE 3000
  CMD ["npm", "start"]
