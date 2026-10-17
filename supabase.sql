-- Run this once in Supabase → SQL Editor → New query.
create table if not exists public.game_rooms (
  id uuid primary key,
  fen text not null,
  moves jsonb not null default '[]'::jsonb,
  updated_by text,
  updated_at timestamptz not null default now()
);

alter table public.game_rooms enable row level security;

create policy "Anyone with a room link can read its game"
on public.game_rooms for select using (true);
create policy "Anyone can create a private game room"
on public.game_rooms for insert with check (true);
create policy "Anyone with a room link can update its game"
on public.game_rooms for update using (true) with check (true);

alter publication supabase_realtime add table public.game_rooms;
