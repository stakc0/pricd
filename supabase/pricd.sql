create table if not exists public.pricd_coins (
  mint text primary key,
  name text not null default 'Unknown', symbol text not null default 'TOKEN', image text not null default '',
  chain text not null default 'solana', market_cap_usd numeric not null default 0,
  volume24h_usd numeric not null default 0, liquidity_usd numeric not null default 0,
  price_usd numeric not null default 0, change24h numeric not null default 0,
  pair_address text not null default '', estimated_price_usd numeric not null default 0,
  indexed_at timestamptz not null default now(), source text not null default 'dexscreener'
);
create index if not exists pricd_coins_mc_idx on public.pricd_coins (market_cap_usd desc);
create index if not exists pricd_coins_volume_idx on public.pricd_coins (volume24h_usd desc);
create table if not exists public.pricd_listings (
  id uuid primary key default gen_random_uuid(), mint text not null references public.pricd_coins(mint),
  wallet text not null, asking_usd numeric not null, status text not null default 'active', created_at timestamptz not null default now()
);
create index if not exists pricd_listings_mint_idx on public.pricd_listings (mint,status);
create table if not exists public.pricd_bids (
  id uuid primary key default gen_random_uuid(), mint text not null references public.pricd_coins(mint),
  wallet text not null, bid_usd numeric not null, status text not null default 'open', created_at timestamptz not null default now()
);
create index if not exists pricd_bids_mint_idx on public.pricd_bids (mint,status,bid_usd desc);
