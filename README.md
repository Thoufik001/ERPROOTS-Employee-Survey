# ERPROOTS Employee Satisfaction Survey

A production-ready web application for collecting anonymous employee satisfaction feedback.

## 🚀 Quick Start

### 1. Supabase Setup
1. Go to [Supabase](https://supabase.com) and create a new project.
2. Go to the **SQL Editor** in the Supabase dashboard.
3. Copy the contents of `supabase/schema.sql` and run it to create the database table and security policies.
4. Go to **Project Settings > API**.
5. Copy the `Project URL` and `anon` public key.

### 2. Configure Application
1. Open `index.html` in a text editor.
2. Find the Supabase configuration section (around line 380):
   ```javascript
   const supabaseUrl = 'YOUR_SUPABASE_URL';
   const supabaseKey = 'YOUR_SUPABASE_ANON_KEY';
   ```
3. Replace the placeholders with your actual Supabase URL and Key.
4. Save the file.

### 3. Deploy to Netlify
1. Go to [Netlify](https://netlify.com) and sign up/login.
2. Click **Add new site** > **Deploy manually**.
3. Drag and drop the `EmployeeSurvey` folder (containing `index.html`) into the upload area.
4. Your site is now live! Netlify will provide a URL (e.g., `https://random-name.netlify.app`).

## 📊 Admin Guide

### Viewing Responses
1. Log in to your Supabase dashboard.
2. Go to the **Table Editor**.
3. Select the `survey_responses` table.
4. You can view, filter, and sort all anonymous submissions here.

### Exporting Data
1. In the Table Editor, click the **Export** button (top right).
2. Select **CSV** to download the data for analysis in Excel or Google Sheets.

## 🛠 Tech Stack
- **Frontend**: HTML5, CSS3 (Vanilla), JavaScript (ES6+)
- **Backend**: Supabase (PostgreSQL)
- **Hosting**: Netlify (Static)

## 🔒 Security
- **Row Level Security (RLS)**: Enabled.
- **Anonymous Inserts**: Public users can only INSERT data.
- **Admin Access**: Only authenticated project admins can SELECT/VIEW data.
