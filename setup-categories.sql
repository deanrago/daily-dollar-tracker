create table if not exists categories (
  id    bigserial primary key,
  name  text not null unique,
  fixed boolean not null default false,
  sort  int not null default 0
);

alter table categories enable row level security;
drop policy if exists "open" on categories;
create policy "open" on categories for all using (true) with check (true);

insert into categories (name, fixed, sort) values
  ('Gas',                          false,  1),
  ('Campsite',                     false,  2),
  ('Grocery Food or Beverage',     false,  3),
  ('Non-Grocery Food or Beverage', false,  4),
  ('Uber',                         false,  5),
  ('Cleo',                         false,  6),
  ('Therapy',                      true,  10),
  ('Rent',                         true,  11),
  ('Car Insurance',                true,  12),
  ('Health Insurance',             true,  13),
  ('Planet Fitness Membership',    true,  14),
  ('Crunch Membership',            true,  15),
  ('Spotify',                      true,  16),
  ('Netflix',                      true,  17),
  ('HBO',                          true,  18)
on conflict (name) do nothing;

-- entries carry their own copy of the name + committed flag, so re-tagging a
-- category later never rewrites history
alter table entries add column if not exists label text;
alter table entries add column if not exists fixed boolean not null default false;
