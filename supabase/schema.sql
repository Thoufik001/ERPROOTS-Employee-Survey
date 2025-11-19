-- Create survey_responses table
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

-- Allow anyone to insert responses (anonymous submissions)
CREATE POLICY "Allow public insert" ON survey_responses
FOR INSERT TO anon
WITH CHECK (true);

-- Only authenticated users (admins) can view responses
CREATE POLICY "Allow authenticated select" ON survey_responses
FOR SELECT TO authenticated
USING (true);

-- Create index for faster date-based queries
CREATE INDEX idx_submitted_at ON survey_responses(submitted_at);
