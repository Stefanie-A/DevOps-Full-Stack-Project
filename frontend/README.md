# 🧾 Receipt Tracker
[🌐 View Live Project](https://smart-receipt-store.netlify.app)

Receipt Tracker is a Nuxt.js application that allows users to upload receipts, which are then scanned by an AI-powered backend. The relevant details—such as store name, date, total amount, and items—are extracted and securely stored for future reference and analytics.

## 🚀 Features

- 📤 Upload receipt images (JPG, PNG, PDF)
- 🧠 AI-powered OCR and data extraction
- 📦 Store and organize receipts by date, vendor, or category
- 🔍 Search and filter receipts
- 🔐 Secure storage of user data
- 📊 Future plans: Spending insights, category breakdowns, export to CSV/PDF

## 🛠 Tech Stack

- **Frontend**: Nuxt.js (Vue 3, Composition API, Tailwind CSS)
- **Backend**: (Nest js) AI receipt scanning service (e.g., custom Python service or third-party like AWS Textract / Google Vision API)
- **Storage**: Cloudinary 
- **Database**: Supabase 

## 📦 Project Setup

```bash
# Install dependencies
npm install

# Run in development mode
npm run dev

# Build for production
npm run build

# Preview the production build
npm run preview
