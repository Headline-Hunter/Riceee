# 🚀 Complete Setup Guide for Journal App

This guide will walk you through setting up all the required dependencies and services for this Next.js journal application.

---

## 📋 Prerequisites

- Node.js (v18 or higher)
- npm or yarn package manager
- Git
- A web browser

---

## ✅ Step-by-Step Setup

### 1. **Install Dependencies** ✓ (Already Done)

Your `node_modules` are already installed. If you need to reinstall:

```powershell
npm install
```

---

### 2. **Setup Clerk Authentication** 🔐

**What is Clerk?** - Authentication and user management service

#### Steps:
1. Go to [https://clerk.com](https://clerk.com)
2. Sign up for a free account
3. Create a new application
4. Choose **Next.js** as your framework
5. Copy your API keys from the dashboard:
   - Click on **API Keys** in the sidebar
   - Copy `Publishable Key` → Add to `.env.local` as `NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY`
   - Copy `Secret Key` → Add to `.env.local` as `CLERK_SECRET_KEY`

**Files using Clerk:**
- `app/layout.js` - ClerkProvider wrapper
- `middleware.js` - Protected routes
- `app/(auth)/sign-in/` - Sign in page
- `app/(auth)/sign-up/` - Sign up page
- `lib/checkUser.js` - User synchronization

---

### 3. **Setup NeonDB (PostgreSQL Database)** 🗄️

**What is NeonDB?** - Serverless PostgreSQL database

#### Steps:
1. Go to [https://neon.tech](https://neon.tech)
2. Sign up for a free account
3. Create a new project
4. Give it a name (e.g., "journal-app")
5. Select a region closest to you
6. Copy the **Connection String**:
   - Go to your project dashboard
   - Click on **Connection Details**
   - Copy the connection string (starts with `postgresql://`)
   - Add to `.env.local` as `DATABASE_URL`

**Example format:**
```
DATABASE_URL=postgresql://username:password@host.neon.tech/dbname?sslmode=require
```

#### Run Prisma Migrations:
After adding the DATABASE_URL, run:

```powershell
npx prisma generate
npx prisma migrate deploy
```

Or to create the database from scratch:
```powershell
npx prisma db push
```

**Files using Prisma/NeonDB:**
- `prisma/schema.prisma` - Database schema
- `lib/prisma.js` - Prisma client instance
- All files in `actions/` folder

---

### 4. **Setup Pixabay API** 🖼️

**What is Pixabay?** - Free stock photos and images for mood visualization

#### Steps:
1. Go to [https://pixabay.com/api/docs/](https://pixabay.com/api/docs/)
2. Sign up for a free account
3. Go to [https://pixabay.com/service/about/api/](https://pixabay.com/service/about/api/)
4. Scroll down to get your **API Key**
5. Copy the API key and add to `.env.local` as `PIXABAY_API_KEY`

**Files using Pixabay:**
- `actions/journal.js` - Fetches mood images

---

### 5. **Setup ArcJet Security** 🛡️

**What is ArcJet?** - Security and rate limiting service

#### Steps:
1. Go to [https://arcjet.com](https://arcjet.com)
2. Sign up for a free account
3. Create a new site/project
4. Copy your **Site Key** from the dashboard
5. Add to `.env.local` as `ARCJET_KEY`

**Features used:**
- Rate limiting on collection creation
- Bot detection
- Shield protection (SQL injection, XSS protection)

**Files using ArcJet:**
- `middleware.js` - Global protection
- `lib/arcjet.js` - Collection rate limiting
- `actions/collection.js` - Rate limit enforcement

---

## 🔍 Verify Your `.env.local` File

Your `.env.local` file should look like this:

```env
# Clerk Authentication
NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY=pk_test_xxxxxxxxxxxxx
CLERK_SECRET_KEY=sk_test_xxxxxxxxxxxxx

NEXT_PUBLIC_CLERK_SIGN_IN_URL=/sign-in
NEXT_PUBLIC_CLERK_SIGN_UP_URL=/sign-up
NEXT_PUBLIC_CLERK_AFTER_SIGN_IN_URL=/dashboard
NEXT_PUBLIC_CLERK_AFTER_SIGN_UP_URL=/dashboard

# NeonDB Database
DATABASE_URL=postgresql://username:password@host.neon.tech/dbname?sslmode=require

# Pixabay API
PIXABAY_API_KEY=xxxxxxxxxxxxx-xxxxxxxxxxxxx

# ArcJet
ARCJET_KEY=ajkey_xxxxxxxxxxxxx
```

---

## 🚀 Running the Application

Once all environment variables are set:

```powershell
# Generate Prisma Client
npx prisma generate

# Run database migrations
npx prisma migrate deploy

# Start the development server
npm run dev
```

Visit [http://localhost:3000](http://localhost:3000)

---

## 🧪 Testing Each Service

### Test Clerk:
- Visit `/sign-in` - Should show Clerk sign-in page
- Create an account
- Should redirect to `/dashboard`

### Test NeonDB:
- After signing in, try creating a collection
- Try writing a journal entry
- Check your NeonDB dashboard to see if data is being saved

### Test Pixabay:
- Create a journal entry with a mood selection
- The mood image should be displayed

### Test ArcJet:
- Try creating more than 10 collections in an hour
- Should get rate limited

---

## 🐛 Common Issues & Fixes

### Issue: "Clerk is not configured"
**Fix:** Make sure both `NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY` and `CLERK_SECRET_KEY` are set

### Issue: "Prisma Client not generated"
**Fix:** Run `npx prisma generate`

### Issue: "Database connection failed"
**Fix:** 
- Check your `DATABASE_URL` is correct
- Make sure NeonDB project is active
- Check if you need to append `?sslmode=require` to the connection string

### Issue: "ArcJet blocking requests"
**Fix:**
- Check `ARCJET_KEY` is set
- Change mode from `"LIVE"` to `"DRY_RUN"` in `middleware.js` for testing

### Issue: No mood images showing
**Fix:** 
- Verify `PIXABAY_API_KEY` is correct
- Check Pixabay API quota (5000 requests/day on free tier)

---

## 📚 Project Structure

```
riceee/
├── actions/              # Server actions (database operations)
├── app/
│   ├── (auth)/          # Authentication pages (Clerk)
│   ├── (main)/          # Protected pages
│   ├── layout.js        # Root layout with ClerkProvider
│   └── globals.css      # Global styles
├── components/          # React components
├── lib/                 # Utilities and configurations
│   ├── prisma.js       # Database client
│   ├── arcjet.js       # Security configuration
│   └── checkUser.js    # Clerk user sync
├── prisma/
│   └── schema.prisma   # Database schema
├── middleware.js        # Route protection & security
└── .env.local          # Environment variables (YOU NEED TO CREATE THIS)
```

---

## 🎯 Quick Start Checklist

- [ ] Install dependencies (`npm install`)
- [ ] Create Clerk account and get API keys
- [ ] Create NeonDB project and get connection string
- [ ] Create Pixabay account and get API key
- [ ] Create ArcJet account and get site key
- [ ] Fill in `.env.local` with all keys
- [ ] Run `npx prisma generate`
- [ ] Run `npx prisma migrate deploy` or `npx prisma db push`
- [ ] Run `npm run dev`
- [ ] Test sign-in/sign-up
- [ ] Create a collection
- [ ] Write a journal entry

---

## 🔗 Useful Links

- **Clerk Docs:** https://clerk.com/docs
- **NeonDB Docs:** https://neon.tech/docs/introduction
- **Pixabay API Docs:** https://pixabay.com/api/docs/
- **ArcJet Docs:** https://docs.arcjet.com/
- **Prisma Docs:** https://www.prisma.io/docs
- **Next.js Docs:** https://nextjs.org/docs

---

## 💡 Tips

1. **Free Tier Limits:**
   - Clerk: 10,000 monthly active users
   - NeonDB: 0.5 GB storage
   - Pixabay: 5,000 requests/day
   - ArcJet: Check their pricing page

2. **Development Mode:**
   - You can set ArcJet to `DRY_RUN` mode while developing
   - This logs security events without blocking requests

3. **Database Management:**
   - Use `npx prisma studio` to view/edit database in a GUI
   - Access at http://localhost:5555

---

Good luck! 🎉 If you encounter any issues, check the documentation links above or the common issues section.
