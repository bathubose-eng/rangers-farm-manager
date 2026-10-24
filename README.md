# Rangers Farm Manager

A responsive Next.js web app for Rangers Farm, using the existing Supabase workspace database and row-level security. Includes email/password sign-in, workspace switching, transactions, enterprise records, People/Planet/Profit sustainability assessments, monthly reporting, CSV export, and print-to-PDF.

## Important: this app is not deployed yet
This source package must be connected to the correct Supabase project and deployed to a host such as Vercel. Do not run the old standalone `farm_transactions` schema from earlier versions. This build expects the existing workspace tables and policies in your Rangers Farm Manager project.

## Configure
1. Copy `.env.example` to `.env.local`.
2. Set `NEXT_PUBLIC_SUPABASE_URL` to the Supabase Project URL.
3. Set `NEXT_PUBLIC_SUPABASE_ANON_KEY` to the project's publishable/anon key.
4. Never put a service-role key in a browser app or in these variables.
5. Install Node.js 20+ and run `npm install`, then `npm run dev`.

## Deploy with Vercel
1. Create/sign in to your Vercel account and import this project from a private GitHub repository, or use Vercel's supported CLI deployment workflow.
2. Add `NEXT_PUBLIC_SUPABASE_URL` and `NEXT_PUBLIC_SUPABASE_ANON_KEY` as environment variables for Production (and Preview if desired).
3. Deploy the project.
4. In Supabase Authentication URL Configuration, set Site URL to the deployed HTTPS URL and add the deployed URL to Redirect URLs.
5. Test sign-in, workspace access, adding a transaction, enterprise creation, assessments, CSV export, and role permissions before inviting team members.

## Existing database assumptions
The signed-in user must be a member of a row in `farm_workspace_members`. The app reads `farm_workspaces`, `enterprises`, `transactions`, and `sustainability_assessments` using the existing workspace RLS policies. The current code allows transaction deletes through the database policies only where permitted; if a staff member sees a delete error, that is expected enforcement by RLS. Only owners/managers are shown enterprise/assessment creation controls.

## Financial notes
Monthly net result = recorded income minus recorded costs. CSV can be opened in Excel/Google Sheets. Use Print / Save as PDF for a printable report. These are management summaries, not statutory accounts or an external sustainability certification.
