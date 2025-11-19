# ERPROOTS Employee Satisfaction Survey - Project Specification

**Version:** 1.0  
**Date:** November 19, 2025  
**Tech Stack:** HTML/CSS/JS + Supabase + Netlify  
**Purpose:** Anonymous employee feedback collection web app

---

## Overview

Build a production-ready, anonymous employee satisfaction survey web application with 3 pages/views:
1. **Survey Form** - Employees fill 41 questions across 9 sections
2. **Thank You Page** - Post-submission confirmation
3. **Admin Dashboard** - Password-protected response viewing, CSV export, and deletion

---

## Technical Stack

- **Frontend:** Vanilla HTML5, CSS3, JavaScript (ES6+)
- **Backend:** Supabase (PostgreSQL + REST API)
- **Hosting:** Netlify (static hosting, drag-and-drop deployment)
- **Security:** Simple password authentication for admin, Row Level Security on Supabase

---

## Core Features

### User Flow (Employees)
1. Access public survey URL
2. Fill out 41 questions (ratings, yes/no, text, multi-select)
3. Conditional questions show/hide based on answers (Q8, Q15, Q17)
4. Submit anonymously to Supabase
5. See "Thank You" confirmation page

### Admin Flow
1. Navigate to `/admin` or admin login page
2. Enter hardcoded password (stored in code or env variable)
3. View all survey responses in table format
4. Export all data to CSV
5. Delete individual responses or clear all responses
6. Logout

---

## Survey Structure (41 Questions, 9 Sections)

### Section A: General Work Satisfaction (4 questions)
- Q1: Satisfaction with role (Rating 1-5) + optional comment
- Q2: Work valued and recognized (Yes/No) + optional comment
- Q3: Team communication (Yes/No) + optional comment
- Q4: Skills utilized (Yes/No) + optional comment

### Section B: Documentation Quality (5 questions)
- Q5: Clear Scope/Requirements (Yes/No) + comment
- Q6: FS/TS provided (Yes/No) + comment
- Q7: Docs updated regularly (Yes/No) + comment
- Q8: Documentation challenges? (Yes/No)
  - **If Yes:** Multi-select challenges (Lack of time, No template, Incomplete requirements, Not required for small tasks, Other)
  - **If "Other" selected:** Text input for specification
- Q10: Documentation improvements (Open text)

### Section C: Change Request Management (7 questions)
- Q11: CRs properly prioritized (Yes/No) + comment
- Q12: Frequent changes (Yes/No) + comment
- Q13: Sufficient time for CRs (Yes/No) + comment
- Q14: Clear communication on CRs (Yes/No) + comment
- Q15: Unplanned changes? (Yes/No)
  - **If Yes:** Frequency (Always/Often/Sometimes/Rarely/Never) + comment
- Q17: Challenges with CRs? (Yes/No)
  - **If Yes:** Multi-select (Lack of clarity, Frequent changes, Unrealistic timelines, Too many reworks, Other)
  - **If "Other" selected:** Text input

### Section D: Resource Allocation & Workload (4 questions)
- Q19: Fair work distribution (Yes/No) + comment
- Q20: Same people get most tasks (Yes/No) + comment
- Q21: Workload manageable (Yes/No) + comment
- Q22: Utilization (Properly/Over/Under utilized)

### Section E: Skill Growth & Training (3 questions)
- Q23: Adequate training (Yes/No) + comment
- Q24: Cross-training opportunities (Yes/No) + comment
- Q25: Certifications encouraged (Yes/No) + comment

### Section F: Leadership & Support (4 questions)
- Q26: Comfortable approaching lead/manager (Yes/No) + comment
- Q27: Leadership listens to feedback (Yes/No) + comment
- Q28: PM/Lead understands challenges (Yes/No) + comment
- Q29: Timely feedback on work (Yes/No) + comment

### Section G: Work Culture & Team Collaboration (4 questions)
- Q30: Teamwork encouraged (Yes/No) + comment
- Q31: Conflicts resolved fairly (Yes/No) + comment
- Q32: Ideas respected (Yes/No) + comment
- Q33: Team morale (Very High/High/Neutral/Low/Very Low)

### Section H: Tools & Infrastructure (3 questions)
- Q34: Necessary tools available (Yes/No) + comment
- Q35: Tools used effectively (Yes/No) + comment
- Q36: Tool/process improvements (Open text)

### Section I: Open-Ended Feedback (5 questions)
- Q37: Biggest challenges in project (Open text)
- Q38: Process improvements needed (Open text)
- Q39: Biggest bottleneck + how to fix (Open text)
- Q40: Changes to reduce rework (Open text)
- Q41: Anything holding you back (Open text)

---

## Conditional Logic Requirements

### Q8 Conditional Display
- When Q8 = "Yes" → Show multi-select checkbox group for challenges
- If "Other" checkbox selected → Show text input field
- When Q8 = "No" → Hide all conditional fields

### Q15 Conditional Display
- When Q15 = "Yes" → Show radio group for frequency + comment field
- When Q15 = "No" → Hide conditional fields

### Q17 Conditional Display
- When Q17 = "Yes" → Show multi-select checkbox group for challenges
- If "Other" checkbox selected → Show text input field
- When Q17 = "No" → Hide all conditional fields

---

## Database Schema (Supabase)

### Table: `survey_responses`

```sql
CREATE TABLE survey_responses (
  id BIGSERIAL PRIMARY KEY,
  submitted_at TIMESTAMPTZ DEFAULT NOW(),
  q1 TEXT,
  q1_comment TEXT,
  q2 TEXT,
  q2_comment TEXT,
  q3 TEXT,
  q3_comment TEXT,
  q4 TEXT,
  q4_comment TEXT,
  q5 TEXT,
  q5_comment TEXT,
  q6 TEXT,
  q6_comment TEXT,
  q7 TEXT,
  q7_comment TEXT,
  q8 TEXT,
  q8_challenges TEXT,
  q8_other TEXT,
  q10 TEXT,
  q11 TEXT,
  q11_comment TEXT,
  q12 TEXT,
  q12_comment TEXT,
  q13 TEXT,
  q13_comment TEXT,
  q14 TEXT,
  q14_comment TEXT,
  q15 TEXT,
  q15_frequency TEXT,
  q15_comment TEXT,
  q17 TEXT,
  q17_challenges TEXT,
  q17_other TEXT,
  q19 TEXT,
  q19_comment TEXT,
  q20 TEXT,
  q20_comment TEXT,
  q21 TEXT,
  q21_comment TEXT,
  q22 TEXT,
  q23 TEXT,
  q23_comment TEXT,
  q24 TEXT,
  q24_comment TEXT,
  q25 TEXT,
  q25_comment TEXT,
  q26 TEXT,
  q26_comment TEXT,
  q27 TEXT,
  q27_comment TEXT,
  q28 TEXT,
  q28_comment TEXT,
  q29 TEXT,
  q29_comment TEXT,
  q30 TEXT,
  q30_comment TEXT,
  q31 TEXT,
  q31_comment TEXT,
  q32 TEXT,
  q32_comment TEXT,
  q33 TEXT,
  q34 TEXT,
  q34_comment TEXT,
  q35 TEXT,
  q35_comment TEXT,
  q36 TEXT,
  q37 TEXT,
  q38 TEXT,
  q39 TEXT,
  q40 TEXT,
  q41 TEXT
);

-- Enable Row Level Security
ALTER TABLE survey_responses ENABLE ROW LEVEL SECURITY;

-- Allow public inserts (anonymous employee submissions)
CREATE POLICY "Allow public insert" ON survey_responses
FOR INSERT TO anon
WITH CHECK (true);

-- Allow authenticated users to read (admin access)
CREATE POLICY "Allow authenticated select" ON survey_responses
FOR SELECT TO authenticated
USING (true);

-- Index for faster date queries
CREATE INDEX idx_submitted_at ON survey_responses(submitted_at);
```

---

## Page Structure & Functionality

### Page 1: Survey Form (`/` or `index.html`)

**Features:**
- Single-page form with all 9 sections
- Progress indicator (optional)
- Mobile-responsive design
- Real-time validation (required fields)
- Conditional question display (Q8, Q15, Q17)
- Submit button (disabled during submission)
- Client-side data sanitization

**Validation Rules:**
- All primary questions (Q1-Q41) required except open-ended text fields
- Comment fields always optional
- Max length: 2000 chars for text areas, 500 for text inputs
- No HTML/script injection

**Submit Flow:**
1. Validate all required fields
2. Convert checkbox arrays to comma-separated strings
3. Send data to Supabase via REST API
4. Show loading state ("Submitting...")
5. On success: Hide form, show thank you page
6. On error: Alert user with retry option

### Page 2: Thank You Page

**Display After Successful Submission:**
- Checkmark icon or success visual
- "Thank You!" heading
- Confirmation message: "Your feedback has been submitted anonymously. Thank you for your time!"
- No back button or form reset (prevent duplicate submissions)

**Implementation:**
- Can be same HTML file with conditional display (hide form, show thank you div)
- OR separate `thankyou.html` page (redirect after submit)

### Page 3: Admin Dashboard (`/admin` or `admin.html`)

**Authentication:**
- Simple password input field
- Hardcoded password check (e.g., `ADMIN_PASSWORD = "erproots2025"` or env variable)
- No session management needed (check password on load)
- Store auth state in sessionStorage or simple flag

**Dashboard Features:**

1. **Response Table:**
   - Display all survey responses in table format
   - Columns: ID, Submitted At, Q1, Q2, ... Q41 (scrollable)
   - Sortable by date (newest first by default)
   - Paginated (optional, if many responses)

2. **Export to CSV:**
   - Button: "Export All to CSV"
   - Generate CSV file with all responses
   - Download automatically
   - Include headers (question numbers/labels)

3. **Delete Functions:**
   - "Delete" button per row (delete individual response)
   - "Clear All Responses" button (delete all, with confirmation prompt)
   - Use Supabase DELETE API calls

4. **Logout:**
   - "Logout" button to clear auth state and return to login

**Data Loading:**
- Fetch all responses from Supabase on page load
- Use Supabase authenticated client (admin credentials)
- Display in table with basic styling

---

## Security Requirements

### Employee Survey (Public Access)
- No authentication required
- No PII collected (completely anonymous)
- Use Supabase anon/public key for inserts only
- HTTPS-only (enforced by Netlify)
- XSS prevention: Sanitize all text inputs before submission

### Admin Dashboard (Protected)
- Password-protected access
- Hardcoded password in environment variable or code constant
- Admin uses Supabase authenticated client (service role key or authenticated anon key)
- No public access to admin routes
- Simple check: if password incorrect, don't load dashboard

**Supabase Security Policies:**
- Public (anon) role: INSERT only on survey_responses
- Authenticated role: SELECT, DELETE on survey_responses
- No UPDATE permissions for anyone (data integrity)

---

## UI/UX Requirements

### Design System
- **Colors:** Light mode primary (cream #FCFCF9, teal #21808D), Dark mode support optional
- **Typography:** System fonts (sans-serif), 14px base, 24px section headings
- **Spacing:** 8px base unit, 24px section padding
- **Components:** Rounded buttons (8px), card sections (12px radius), focus states visible

### Responsive Breakpoints
- Mobile: 320px - 640px (single column, large touch targets)
- Tablet: 641px - 1024px (single column, optimized spacing)
- Desktop: 1025px+ (max-width 800px container, centered)

### Accessibility
- WCAG 2.1 Level AA compliance
- Keyboard navigation (tab order, focus indicators)
- ARIA labels where needed
- Screen reader friendly
- Color contrast: 4.5:1 minimum

---

## File Structure

```
project-root/
├── index.html              # Survey form page
├── thankyou.html           # Thank you page (or embedded in index.html)
├── admin.html              # Admin dashboard page
├── README.md               # Setup and deployment instructions
├── supabase/
│   └── schema.sql          # Database table creation script
└── .env.example            # Environment variables template
```

**OR Single-Page App (SPA) Approach:**
```
project-root/
├── index.html              # All 3 pages in one file (show/hide divs)
├── README.md
├── supabase/
│   └── schema.sql
└── .env.example
```

---

## Configuration Variables

**Required Environment Variables:**
```
SUPABASE_URL=https://xxxxx.supabase.co
SUPABASE_ANON_KEY=eyJhbGc...    # For employee survey submissions
ADMIN_PASSWORD=erproots2025     # For admin login
```

**Where to Set:**
- In `index.html` / `admin.html` directly (for simplicity)
- OR in `.env` file if using build tool
- OR as Netlify environment variables (advanced)

---

## Deployment Instructions

### Step 1: Supabase Setup (5 minutes)
1. Create Supabase account at https://supabase.com
2. Create new project (region: Singapore/Mumbai)
3. Run `supabase/schema.sql` in SQL Editor
4. Copy Project URL and Anon Key from Settings → API
5. Verify table created in Table Editor

### Step 2: Code Configuration (2 minutes)
1. Open `index.html` and `admin.html` in editor
2. Replace `YOUR_SUPABASE_URL` with actual URL
3. Replace `YOUR_SUPABASE_ANON_KEY` with actual key
4. Set `ADMIN_PASSWORD` constant
5. Save files

### Step 3: Netlify Deployment (3 minutes)
1. Create Netlify account at https://netlify.com
2. Click "Add new site" → "Deploy manually"
3. Drag and drop project folder
4. Wait 30 seconds for deployment
5. Get public URL: `https://random-name.netlify.app`
6. (Optional) Rename site: Site Settings → Change site name → `erproots-survey`

### Step 4: Testing (5 minutes)
1. Open deployed survey URL
2. Fill test submission → Verify in Supabase
3. Access `/admin` → Test password login
4. Verify responses display in admin dashboard
5. Test CSV export and delete functions
6. Test on mobile device

---

## Admin Guide

### Accessing Responses
1. Navigate to `https://your-site.netlify.app/admin`
2. Enter admin password
3. View all responses in table
4. Click "Export CSV" to download data
5. Delete individual responses or clear all

### Exporting Data
- Click "Export to CSV" button
- File downloads automatically
- Open in Excel/Google Sheets for analysis

### Sharing Survey Link
- Copy survey URL: `https://erproots-survey.netlify.app`
- Share via email, Slack, Teams, or QR code
- No login required for employees

---

## Validation & Error Handling

### Form Validation
- Client-side validation before submit
- Required fields highlighted if empty
- Inline error messages below fields
- Submit button disabled until all required fields filled

### Error Messages
- Network error: "Could not connect. Please check your internet and try again."
- Submission error: "Failed to submit. Please retry or contact support."
- Admin login error: "Incorrect password. Please try again."

### Loading States
- Submit button shows "Submitting..." during API call
- Admin dashboard shows "Loading responses..." while fetching data
- Disable buttons during async operations

---

## Testing Checklist

### Functional Testing
- [ ] All 41 questions display correctly
- [ ] Required field validation works
- [ ] Optional fields can be skipped
- [ ] Conditional logic (Q8, Q15, Q17) works correctly
- [ ] Form submits to Supabase successfully
- [ ] Data appears in Supabase table with correct columns
- [ ] Thank you page displays after submission
- [ ] Admin login password check works
- [ ] Admin dashboard displays all responses
- [ ] CSV export generates correct file
- [ ] Delete individual response works
- [ ] Clear all responses works (with confirmation)

### Browser Testing
- [ ] Chrome (desktop + mobile)
- [ ] Safari (desktop + iOS)
- [ ] Firefox
- [ ] Edge

### Responsive Testing
- [ ] Mobile (320px width)
- [ ] Tablet (768px width)
- [ ] Desktop (1920px width)

### Security Testing
- [ ] Admin page inaccessible without password
- [ ] Supabase RLS policies prevent unauthorized access
- [ ] No XSS vulnerabilities
- [ ] HTTPS enforced on Netlify

---

## Performance Requirements

- Page load time: <2 seconds on 4G
- Form submission: <3 seconds
- Admin dashboard load: <2 seconds
- CSV export generation: <5 seconds (for 500 responses)
- Support 100 concurrent users

---

## Future Enhancements (Out of Scope for MVP)

- User authentication (track individual response rates)
- Email notifications on new submissions
- Built-in analytics dashboard with charts
- Multi-language support (Tamil, Hindi)
- Automated reminder emails
- Response editing capability
- Advanced filtering in admin dashboard
- Integration with Slack/Teams for alerts

---

## Support & Maintenance

**For Technical Issues:**
- Check Supabase dashboard for database errors
- Verify Netlify deployment logs
- Check browser console for JavaScript errors

**For Content Updates:**
- Edit question text in HTML
- Add new columns to Supabase table if adding questions
- Re-deploy to Netlify (drag-and-drop updated folder)

---

## Deliverables Checklist

- [ ] `index.html` - Survey form with all 41 questions
- [ ] `thankyou.html` OR embedded thank you view
- [ ] `admin.html` - Admin dashboard with password protection
- [ ] `supabase/schema.sql` - Database table creation script
- [ ] `README.md` - Setup and deployment guide
- [ ] `.env.example` - Environment variables template
- [ ] All conditional logic implemented (Q8, Q15, Q17)
- [ ] Form validation and error handling
- [ ] CSV export functionality
- [ ] Delete response functionality
- [ ] Mobile-responsive design
- [ ] Dark mode support (optional)
- [ ] Accessibility compliance (WCAG AA)

---

**END OF PROJECT SPECIFICATION**

*This document contains all requirements for building the ERPROOTS Employee Satisfaction Survey web application. Follow this spec exactly when developing. All questions, database columns, and features are defined above.*
