-- Proposed Rangers Farm Manager Work Plan Schedules migration.
-- Review role names and test in the intended Supabase project before running.
create table if not exists public.work_plan_tasks (
 id uuid primary key default gen_random_uuid(),
 workspace_id uuid not null references public.farm_workspaces(id) on delete cascade,
 user_id uuid not null references auth.users(id) on delete restrict,
 title text not null,
 description text,
 enterprise_id uuid references public.enterprises(id) on delete set null,
 start_date date,
 due_date date,
 assigned_to text,
 priority text not null default 'normal' check (priority in ('low','normal','high','critical')),
 status text not null default 'planned' check (status in ('planned','in_progress','completed','on_hold')),
 expected_cost numeric(12,2) check (expected_cost is null or expected_cost >= 0),
 risk_description text,
 risk_likelihood integer check (risk_likelihood is null or risk_likelihood between 1 and 5),
 risk_impact integer check (risk_impact is null or risk_impact between 1 and 5),
 mitigation text,
 created_at timestamptz not null default now(),
 updated_at timestamptz not null default now()
);
alter table public.work_plan_tasks enable row level security;
drop policy if exists "Workspace members can view work plan tasks" on public.work_plan_tasks;
create policy "Workspace members can view work plan tasks" on public.work_plan_tasks for select to authenticated using (exists (select 1 from public.farm_workspace_members m where m.workspace_id=work_plan_tasks.workspace_id and m.user_id=auth.uid()));
drop policy if exists "Managers can create work plan tasks" on public.work_plan_tasks;
create policy "Managers can create work plan tasks" on public.work_plan_tasks for insert to authenticated with check (user_id=auth.uid() and exists (select 1 from public.farm_workspace_members m where m.workspace_id=work_plan_tasks.workspace_id and m.user_id=auth.uid() and m.role in ('owner','manager')));
drop policy if exists "Managers can update work plan tasks" on public.work_plan_tasks;
create policy "Managers can update work plan tasks" on public.work_plan_tasks for update to authenticated using (exists (select 1 from public.farm_workspace_members m where m.workspace_id=work_plan_tasks.workspace_id and m.user_id=auth.uid() and m.role in ('owner','manager'))) with check (exists (select 1 from public.farm_workspace_members m where m.workspace_id=work_plan_tasks.workspace_id and m.user_id=auth.uid() and m.role in ('owner','manager')));
drop policy if exists "Managers can delete work plan tasks" on public.work_plan_tasks;
create policy "Managers can delete work plan tasks" on public.work_plan_tasks for delete to authenticated using (exists (select 1 from public.farm_workspace_members m where m.workspace_id=work_plan_tasks.workspace_id and m.user_id=auth.uid() and m.role in ('owner','manager')));
