-- Run once in the Supabase SQL editor.
-- A permanent record of every category rename and when it happened.
-- The app works without it (renames still apply everywhere) — this is
-- just the paper trail.
create table if not exists category_renames (
  id       bigserial primary key,
  old_name text not null,
  new_name text not null,
  at       timestamptz not null default now()
);

alter table category_renames enable row level security;
drop policy if exists "open" on category_renames;
create policy "open" on category_renames for all using (true) with check (true);
