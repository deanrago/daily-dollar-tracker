-- Run once in the Supabase SQL editor.

-- Who logged it. 'D' or 'K', set by whichever phone the entry came from.
-- Tracking only — it never changes the grid, the envelope or the targets.
alter table entries add column if not exists who text;

-- A week that runs at its own daily rate. Any week without a row here uses
-- the standing goal in `settings`, so past weeks stay exactly as they were.
create table if not exists week_budgets (
  week_start date primary key,
  goal       numeric not null
);

alter table week_budgets enable row level security;
drop policy if exists "open" on week_budgets;
create policy "open" on week_budgets for all using (true) with check (true);
