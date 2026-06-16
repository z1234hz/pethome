-- PetHome Database Schema
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS uuid-ossp;

CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  phone VARCHAR(20) UNIQUE NOT NULL,
  nickname VARCHAR(50),
  avatar_url TEXT,
  city VARCHAR(100),
  lat DOUBLE PRECISION, lng DOUBLE PRECISION,
  level INT DEFAULT 1,
  points INT DEFAULT 0,
  vip_expires_at TIMESTAMP,
  wechat_openid VARCHAR(100) UNIQUE,
  apple_uid VARCHAR(100) UNIQUE,
  is_verified BOOLEAN DEFAULT false,
  is_banned BOOLEAN DEFAULT false,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE lost_pets (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES users(id),
  pet_name VARCHAR(50) NOT NULL,
  species VARCHAR(20), breed VARCHAR(50),
  color VARCHAR(100), gender VARCHAR(10),
  features TEXT,
  lost_time TIMESTAMP NOT NULL,
  lost_location TEXT NOT NULL,
  lat DOUBLE PRECISION, lng DOUBLE PRECISION,
  reward_amount DECIMAL(10,2) DEFAULT 0,
  contact_phone VARCHAR(20),
  description TEXT,
  photo_urls TEXT[],
  is_urgent BOOLEAN DEFAULT false,
  status VARCHAR(20) DEFAULT 'lost',
  views INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE found_pets (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES users(id),
  species VARCHAR(20), breed VARCHAR(50),
  color VARCHAR(100),
  found_location TEXT NOT NULL,
  lat DOUBLE PRECISION, lng DOUBLE PRECISION,
  description TEXT,
  photo_urls TEXT[],
  matched_post_id UUID REFERENCES lost_pets(id),
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE match_records (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  lost_pet_id UUID REFERENCES lost_pets(id),
  found_pet_id UUID REFERENCES found_pets(id),
  breed_score DOUBLE PRECISION DEFAULT 0,
  color_score DOUBLE PRECISION DEFAULT 0,
  distance_score DOUBLE PRECISION DEFAULT 0,
  time_score DOUBLE PRECISION DEFAULT 0,
  total_score DOUBLE PRECISION DEFAULT 0,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE subscriptions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES users(id),
  plan_type VARCHAR(20) NOT NULL,
  start_at TIMESTAMP NOT NULL,
  end_at TIMESTAMP NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  status VARCHAR(20) DEFAULT 'active',
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE orders (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES users(id),
  order_type VARCHAR(30) NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  payment_method VARCHAR(20),
  status VARCHAR(20) DEFAULT 'pending',
  description TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  paid_at TIMESTAMP
);

CREATE TABLE reward_escrows (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  lost_pet_id UUID REFERENCES lost_pets(id),
  amount DECIMAL(10,2) NOT NULL,
  platform_fee DECIMAL(10,2),
  status VARCHAR(20) DEFAULT 'escrowed',
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE community_posts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES users(id),
  title VARCHAR(200), content TEXT NOT NULL,
  post_type VARCHAR(30),
  photo_urls TEXT[],
  like_count INT DEFAULT 0,
  comment_count INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE system_configs (
  key VARCHAR(100) PRIMARY KEY,
  value JSONB NOT NULL,
  description TEXT,
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Default configs
INSERT INTO system_configs VALUES
('vip_prices','{"monthly":29.9,"quarterly":68,"yearly":198,"permanent":498}','VIP�۸�'),
('payment','{"alipay":"hezhong_z@aliyun.com","wechat":"MoreRoadSafety"}','֧������');
