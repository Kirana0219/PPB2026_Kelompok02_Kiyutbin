create or replace function public.sync_auth_profile()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.auth as profiles (
    id,
    full_name,
    email,
    phone,
    updated_at
  )
  values (
    new.id,
    coalesce(nullif(new.raw_user_meta_data->>'full_name', ''), ''),
    coalesce(new.email, ''),
    nullif(new.raw_user_meta_data->>'phone', ''),
    now()
  )
  on conflict (id) do update
  set
    full_name = coalesce(
      nullif(excluded.full_name, ''),
      nullif(profiles.full_name, ''),
      ''
    ),
    email = coalesce(
      nullif(excluded.email, ''),
      nullif(profiles.email, ''),
      ''
    ),
    phone = coalesce(
      excluded.phone,
      nullif(profiles.phone, '')
    ),
    updated_at = now();

  return new;
end;
$$;

drop trigger if exists sync_auth_profile_on_user_change on auth.users;

create trigger sync_auth_profile_on_user_change
after insert or update of email, raw_user_meta_data
on auth.users
for each row
execute function public.sync_auth_profile();

create or replace function public.ensure_auth_profile()
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  current_user_id uuid := auth.uid();
  auth_user auth.users%rowtype;
begin
  if current_user_id is null then
    raise exception 'Not authenticated';
  end if;

  select *
  into auth_user
  from auth.users
  where id = current_user_id;

  if auth_user.id is null then
    raise exception 'Auth user not found';
  end if;

  insert into public.auth as profiles (
    id,
    full_name,
    email,
    phone,
    updated_at
  )
  values (
    auth_user.id,
    coalesce(nullif(auth_user.raw_user_meta_data->>'full_name', ''), ''),
    coalesce(auth_user.email, ''),
    nullif(auth_user.raw_user_meta_data->>'phone', ''),
    now()
  )
  on conflict (id) do update
  set
    full_name = coalesce(
      nullif(excluded.full_name, ''),
      nullif(profiles.full_name, ''),
      ''
    ),
    email = coalesce(
      nullif(excluded.email, ''),
      nullif(profiles.email, ''),
      ''
    ),
    phone = coalesce(
      excluded.phone,
      nullif(profiles.phone, '')
    ),
    updated_at = now();
end;
$$;

grant execute on function public.ensure_auth_profile() to authenticated;

alter table public.auth enable row level security;

drop policy if exists "Users can read own profile" on public.auth;
create policy "Users can read own profile"
on public.auth
for select
to authenticated
using (auth.uid() = id);

drop policy if exists "Users can insert own profile" on public.auth;
create policy "Users can insert own profile"
on public.auth
for insert
to authenticated
with check (auth.uid() = id);

drop policy if exists "Users can update own profile" on public.auth;
create policy "Users can update own profile"
on public.auth
for update
to authenticated
using (auth.uid() = id)
with check (auth.uid() = id);

drop policy if exists "Users can delete own profile" on public.auth;
create policy "Users can delete own profile"
on public.auth
for delete
to authenticated
using (auth.uid() = id);

insert into public.auth as profiles (
  id,
  full_name,
  email,
  phone,
  updated_at
)
select
  users.id,
  coalesce(nullif(users.raw_user_meta_data->>'full_name', ''), ''),
  coalesce(users.email, ''),
  nullif(users.raw_user_meta_data->>'phone', ''),
  now()
from auth.users as users
where not exists (
  select 1
  from public.auth as existing_profiles
  where existing_profiles.id = users.id
)
on conflict (id) do update
set
  full_name = coalesce(
    nullif(excluded.full_name, ''),
    nullif(profiles.full_name, ''),
    ''
  ),
  email = coalesce(
    nullif(excluded.email, ''),
    nullif(profiles.email, ''),
    ''
  ),
  phone = coalesce(
    excluded.phone,
    nullif(profiles.phone, '')
  ),
  updated_at = now();
