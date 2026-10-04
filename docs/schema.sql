-- ============================================
-- Table: profiles
-- Extends auth.users with additional user data
-- ============================================
create table profiles (
  id uuid references auth.users(id) primary key,
  full_name text,
  avatar_url text,
  phone_number text,
  address text,
  bio text,
  created_at timestamptz default now()
);

-- Row Level Security policies
create policy "Public profiles are viewable by everyone"
on profiles for select
using (true);

create policy "Users can insert their own profile"
on profiles for insert
with check (auth.uid() = id);

create policy "Users can update their own profile"
on profiles for update
using (auth.uid() = id);
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- ============================================
-- Table: products
-- Items listed for sale by users
-- ============================================
create table products (
  id uuid default gen_random_uuid() primary key,
  seller_id uuid references profiles(id) not null,
  title text not null,
  description text,
  price numeric not null,
  category text,
  images text[],
  status text default 'available',
  created_at timestamptz default now()
);
-- القراءة متاحة للجميع
create policy "Products are viewable by everyone"
on products for select
using (true);

-- الإضافة: المستخدم يقدر يضيف منتج بس لو seller_id بتاعه هو                                                                                                
create policy "Users can insert their own products"
on products for insert
with check (auth.uid() = seller_id);

-- التعديل: البائع يقدر يعدّل منتجاته هو بس
create policy "Users can update their own products"
on products for update
using (auth.uid() = seller_id);

-- الحذف: البائع يقدر يمسح منتجاته هو بس
create policy "Users can delete their own products"
on products for delete
using (auth.uid() = seller_id);
-- -- -- -- -- -- -- -- --  -- -- -- -- -- -- 
-- الدالة اللي بتاخد بيانات المستخدم الجديد وتعمل profile ليه
create function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
  insert into public.profiles (id, full_name, phone_number)
  values (
    new.id,
    new.raw_user_meta_data ->> 'full_name',
    new.raw_user_meta_data ->> 'phone_number'
  );
  return new;
end;
$$;

-- الـ Trigger اللي بيشغّل الدالة أوتوماتيك بعد أي تسجيل جديد
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();



  ---------------------------
  alter table profiles 
  drop constraint profiles_id_fkey,
  add constraint profiles_id_fkey 
    foreign key (id) references auth.users(id) on delete cascade;

alter table products 
  drop constraint products_seller_id_fkey,
  add constraint products_seller_id_fkey 
    foreign key (seller_id) references profiles(id) on delete cascade;