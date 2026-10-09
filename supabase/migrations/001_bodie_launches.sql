-- Bodie launch index: shared canonical table used by the launch API.
create table if not exists public.webd_launches (
  mint text primary key,
  name text not null,
  symbol text not null,
  description text not null default '',
  domain_site text not null,
  token_directory text not null,
  metadata_uri text not null,
  image_url text,
  initial_buy_sol numeric(20,9) not null default 0,
  status text not null default 'prepared' check (status in ('prepared','confirmed','failed')),
  signature text,
  created_at timestamptz not null default now()
);
create index if not exists webd_launches_status_created_idx on public.webd_launches(status, created_at desc);

do $$ begin
  alter publication supabase_realtime add table public.webd_launches;
exception when duplicate_object then null;
end $$;
