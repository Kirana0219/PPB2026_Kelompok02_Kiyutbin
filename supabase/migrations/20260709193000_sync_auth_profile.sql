-- ==========================================================
-- KIYUTBIN: SYNC auth.users -> public.profiles
-- ==========================================================

create or replace function public.sync_auth_profile()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles as profiles (
    id,
    role_id,
    full_name,
    email,
    phone,
    photo_url,
    is_active,
    created_at,
    updated_at
  )
  values (
    new.id,
    1,
    coalesce(nullif(new.raw_user_meta_data->>'full_name', ''), ''),
    coalesce(new.email, ''),
    nullif(new.raw_user_meta_data->>'phone', ''),
    null,
    true,
    now(),
    now()
  )
  on conflict (id) do update
  set
    full_name = coalesce(
      nullif(excluded.full_name, ''),
      profiles.full_name,
      ''
    ),
    email = coalesce(
      nullif(excluded.email, ''),
      profiles.email,
      ''
    ),
    phone = coalesce(
      excluded.phone,
      profiles.phone
    ),
    updated_at = now();

  return new;
end;
$$;

-- ==========================================================
-- TRIGGER
-- ==========================================================

drop trigger if exists sync_auth_profile_on_user_change on auth.users;

create trigger sync_auth_profile_on_user_change
after insert or update of email, raw_user_meta_data
on auth.users
for each row
execute function public.sync_auth_profile();

-- ==========================================================
-- ROW LEVEL SECURITY
-- ==========================================================

alter table public.profiles enable row level security;

drop policy if exists "Users can read own profile" on public.profiles;
drop policy if exists "Users can insert own profile" on public.profiles;
drop policy if exists "Users can update own profile" on public.profiles;
drop policy if exists "Users can delete own profile" on public.profiles;

create policy "Users can read own profile"
on public.profiles
for select
to authenticated
using (auth.uid() = id);

create policy "Users can insert own profile"
on public.profiles
for insert
to authenticated
with check (
  auth.uid() = id
  and role_id = 1
  and is_active = true
);

create policy "Users can update own profile"
on public.profiles
for update
to authenticated
using (auth.uid() = id)
with check (auth.uid() = id);

create policy "Users can delete own profile"
on public.profiles
for delete
to authenticated
using (auth.uid() = id);

-- ==========================================================
-- BUAT PROFILE UNTUK USER LAMA
-- ==========================================================

insert into public.profiles as profiles (
  id,
  role_id,
  full_name,
  email,
  phone,
  photo_url,
  is_active,
  created_at,
  updated_at
)
select
  users.id,
  1,
  coalesce(nullif(users.raw_user_meta_data->>'full_name', ''), ''),
  coalesce(users.email, ''),
  nullif(users.raw_user_meta_data->>'phone', ''),
  null,
  true,
  now(),
  now()
from auth.users as users
on conflict (id) do update
set
  full_name = coalesce(
    nullif(excluded.full_name, ''),
    profiles.full_name,
    ''
  ),
  email = coalesce(
    nullif(excluded.email, ''),
    profiles.email,
    ''
  ),
  phone = coalesce(
    excluded.phone,
    profiles.phone
  ),
  updated_at = now();